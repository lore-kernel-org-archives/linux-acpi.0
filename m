From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: [PATCH 2/2] 2.6: try to determine current P-State setting in
	acpi-cpufreq-ioport driver
Date: Fri, 20 Feb 2004 09:31:55 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040220083155.GB10215@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

One big limitation of the ACPI specification is that it's impossible to
detect the current P-State by reading from ACPI-defined registers. And the
CPU isn't always at P0 when the system boots. So, try to "guess" the current
P-State by analyzing cpu_khz.

 arch/i386/kernel/cpu/cpufreq/acpi.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-02-19 20:37:16.050489712 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-02-19 20:38:55.362392008 +0100
@@ -238,6 +238,34 @@
 }
 
 
+static unsigned long
+acpi_cpufreq_guess_freq (
+	struct cpufreq_acpi_io	*data,
+	unsigned int		cpu)
+{
+	if (cpu_khz) {
+		/* search the closest match to cpu_khz */
+		unsigned int i;
+		unsigned long freq;
+		unsigned long freqn = data->acpi_data.states[0].core_frequency * 1000;
+
+		for (i=0; i < (data->acpi_data.state_count - 1); i++) {
+			freq = freqn;
+			freqn = data->acpi_data.states[i+1].core_frequency * 1000;
+			if ((2 * cpu_khz) > (freqn + freq)) {
+				data->acpi_data.state = i;
+				return (freq);
+			}
+		}
+		data->acpi_data.state = data->acpi_data.state_count - 1;
+		return (freqn);
+	} else
+		/* assume CPU is at P0... */
+		data->acpi_data.state = 0;
+		return data->acpi_data.states[0].core_frequency * 1000;
+	
+}
+
 static int
 acpi_cpufreq_cpu_init (
 	struct cpufreq_policy   *policy)
@@ -290,11 +318,8 @@
 	}
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 
-	/* 
-	 * The current speed is unknown and not detectable by ACPI... argh! Assume 
-	 * it's P0, it will be set to this value later during initialization.
-	 */
-	policy->cur = data->acpi_data.states[0].core_frequency * 1000;
+	/* The current speed is unknown and not detectable by ACPI...  */
+	policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
 
 	/* table init */
 	for (i=0; i<=data->acpi_data.state_count; i++)
