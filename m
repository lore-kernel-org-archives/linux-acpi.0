From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 2.6.4] (1/2) acpi-cpufreq driver: guess P-State at startup
Date: Mon, 15 Mar 2004 15:15:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040315141528.GI8636@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len,

Please apply (2.6.{4,5}).

Thanks,
	Dominik

One big limitation of the ACPI specification is that it's impossible to
detect the current P-State by reading from ACPI-defined registers. And the
CPU isn't always at P0 when the system boots. So, try to "guess" the current
P-State by analyzing cpu_khz.

 arch/i386/kernel/cpu/cpufreq/acpi.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-03-15 09:20:50.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-03-15 13:50:36.152118840 +0100
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


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
