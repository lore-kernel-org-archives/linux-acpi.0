From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: [PATCH 1/2] 2.6: use scaling_available_freqs in acpi-cpufreq-ioport
	driver
Date: Fri, 20 Feb 2004 09:31:50 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040220083149.GA10215@dominikbrodowski.de>
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

Export an array of supported frequencies in sysfs [scaling_available_frequencies]

 arch/i386/kernel/cpu/cpufreq/acpi.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-02-18 10:22:09.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-02-18 22:29:03.112571968 +0100
@@ -306,7 +306,7 @@
 			data->freq_table[i].frequency = CPUFREQ_TABLE_END;
 	}
 
-	result = cpufreq_frequency_table_cpuinfo(policy, &data->freq_table[0]);
+	result = cpufreq_frequency_table_cpuinfo(policy, data->freq_table);
 	if (result) {
 		goto err_freqfree;
 	}
@@ -321,6 +321,7 @@
 			(u32) data->acpi_data.states[i].power,
 			(u32) data->acpi_data.states[i].transition_latency);
 
+	cpufreq_frequency_table_get_attr(data->freq_table, policy->cpu);
 	return_VALUE(result);
 
  err_freqfree:
@@ -345,6 +346,7 @@
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_exit");
 
 	if (data) {
+		cpufreq_frequency_table_put_attr(policy->cpu);
 		acpi_io_data[policy->cpu] = NULL;
 		acpi_processor_unregister_performance(&data->acpi_data, policy->cpu);
 		kfree(data);
@@ -354,6 +356,11 @@
 }
 
 
+static struct freq_attr* acpi_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
 static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify 	= acpi_cpufreq_verify,
 	.target 	= acpi_cpufreq_target,
@@ -361,6 +368,7 @@
 	.exit		= acpi_cpufreq_cpu_exit,
 	.name		= "acpi-cpufreq",
 	.owner		= THIS_MODULE,
+	.attr           = acpi_cpufreq_attr,
 };
