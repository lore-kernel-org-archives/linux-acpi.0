From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: [ACPI] [PATCH] disable SMM access to SpeedStep using ACPI-FADT
	pstate_cnt
Date: Mon, 15 Mar 2004 15:15:45 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040315141545.GK8636@dominikbrodowski.de>
References: <20040215105712.GB6105@dominikbrodowski.de>
	<1076909364.2512.23.camel@dhcppc4>
	<20040215105712.GB6105@dominikbrodowski.de>
	<20040215145407.GK13262@poupinou.org>
	<1076910396.2507.41.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1076909364.2512.23.camel@dhcppc4>
	<1076910396.2507.41.camel@dhcppc4>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Len Brown <len.brown@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, Bruno Ducrot <ducrot@poupinou.org>, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi Len,

On Mon, Feb 16, 2004 at 12:46:37AM -0500, Len Brown wrote:
> 
> - acpi_processor_disable_smm
> + acpi_processor_notify_smm

This name change is included in the attached new version of this patch, and

On Mon, Feb 16, 2004 at 12:29:31AM -0500, Len Brown wrote:
> On Sun, 2004-02-15 at 05:57, Dominik Brodowski wrote:
> > Disable SMM access to SpeedStep
> > 
> > Often, the BIOS changes the CPU frequency if a notebook is (dis)connected
> > from its AC adapter. This interferes with a) an user setting the CPU frequency
> > and b) kernel timing code which needs to know loops_per_jiffy, cpu_khz etc.
> > 
> > So, ACPI 2.0 offers a method to disable such BIOS changes -- writing
> > a value contained in the FADT (pstate_cnt) to the smi_cmd port. This patch
> > utilizes this method by doing this write in processor.c.
> > 
> > However, most current notebooks only offer 1.0 ACPI tables, where the
> > pstate_cnt entry is marked as "reserved". Whenever there is a _PCT entry
> > in the DSDT, though [and this is only a 2.0 object!], we assume the
> > "reserved" entry to be the pstate_cnt entry [if it isn't zero].
> 
> Yes, it seems bogus that an OEM would implement 2.0 _PCT and have a 1.0
> FADT with a non-zero PSTATE_CNT field -- particularly bogus if using
> that "reserved" field is necessary to make p-states works.
> 
> I think when we detect this situation, we should... 
> warning: ACPI 2.0 _PCT and 1.0 FADT with non-zero PSTATE_CNT
> Because we're technically out on a limb using this reserved value, and
> we should complain -- the OEM should have a 2.0 FADT rather than
> requiring us to break spec.
> 
> Further, when we add the "acpi_strict" flag (this week) we should not
> second guess them when it is set, but follow the letter of the spec and
> not use a reserved field.

if acpi_strict is set, the pstate_cnt value is zeroed again.


> > +#else
> > +static void acpi_processor_disable_smm(void) { return; }
> > +#endif
> 
> I think the custom is to use a static inline when you want define out a
> routine -- but maybe that is just when defined in headers?

No, you're right -- changed it.

> If it turns out that this value really is useful, then we should simply
> keep it in this routine and not clear it.  Later on when we use it is
> when we should complain.  We don't want to bother complaining here
> unless we know we have a system with _PCT; b/c it would be noise on real
> 1.0 systems w/o PCT.

I found no way to complain of 1.0 FADT <-> 2.0 _PCT, as tables/tbconv.c is 
too early, and in processor.c it's too late as we don't know the FADT revision 
any more...

	Dominik



Disable SMM access to SpeedStep

Often, the BIOS changes the CPU frequency if a notebook is (dis)connected
from its AC adapter. This interferes with a) an user setting the CPU frequency
and b) kernel timing code which needs to know loops_per_jiffy, cpu_khz etc.

So, ACPI 2.0 offers a method to disable such BIOS changes -- writing
a value contained in the FADT (pstate_cnt) to the smi_cmd port. This patch
utilizes this method by doing this write in processor.c.

However, most current notebooks only offer 1.0 ACPI tables, where the
pstate_cnt entry is marked as "reserved". Whenever there is a _PCT entry
in the DSDT, though [and this is only a 2.0 object!], we assume the
"reserved" entry to be the pstate_cnt entry [if it isn't zero].

 drivers/acpi/processor.c       |   61 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables/tbconvrt.c |    7 +++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2004-03-15 09:16:47.000000000 +0100
+++ linux/drivers/acpi/processor.c	2004-03-15 14:33:17.511732992 +0100
@@ -2374,6 +2374,65 @@
 }
 
 
+#ifdef CONFIG_CPU_FREQ
+/*
+ * acpi_processor_notify_smm - disable BIOS meddling with SpeedStep settings
+ *
+ * By writing pstate_cnt to smi_cmd the BIOS no longer interferes with
+ * the P-States setting of the processor.
+ */
+static void acpi_processor_notify_smm(void) {
+	acpi_status		status;
+	int			i;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_disable_smm");
+
+	/* Can't write pstate_cnt to smi_cmd if either value is zero 
+	 */
+	if ((!acpi_fadt.smi_cmd) ||
+	    (!acpi_fadt.pstate_cnt)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"No SMI port or pstate_cnt\n"));
+		return_VOID;
+	}
+
+	/* Don't write pstate_cnt to smi_cmd if there is no support for
+	 * P-States anyway. This is also a safety precaution for ACPI-1.0
+	 * systems.
+	 */
+	for (i=0;i<NR_CPUS;i++) {
+		struct acpi_processor	*pr = processors[i];
+		acpi_handle		handle = NULL;
+
+		if (!pr || !pr->handle)
+			continue;
+
+		status = acpi_get_handle(pr->handle, "_PCT", &handle);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
+				"No _PCT available, so ignore pstate_cnt"));
+			return_VOID;
+		}
+		break;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Writing pstate_cnt [0x%x] to smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
+
+	status = acpi_os_write_port (acpi_fadt.smi_cmd,
+					(u32) acpi_fadt.pstate_cnt, 8);
+	if (ACPI_FAILURE (status))
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Failed to write pstate_cnt [0x%x] to "
+				"smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
+
+	return_VOID;
+}
+
+#else
+static inline void acpi_processor_notify_smm(void) { return; }
+#endif
+
+
 static int __init
 acpi_processor_init (void)
 {
@@ -2398,6 +2457,8 @@
 
 	acpi_processor_ppc_init();
 
+	acpi_processor_notify_smm();
+
 	return_VALUE(0);
 }
 
diff -ruN linux-original/drivers/acpi/tables/tbconvrt.c linux/drivers/acpi/tables/tbconvrt.c
--- linux-original/drivers/acpi/tables/tbconvrt.c	2004-03-15 09:19:39.000000000 +0100
+++ linux/drivers/acpi/tables/tbconvrt.c	2004-03-15 14:40:30.541902400 +0100
@@ -240,9 +240,12 @@
 	/*
 	 * Processor Performance State Control. This is the value OSPM writes to
 	 * the SMI_CMD register to assume processor performance state control
-	 * responsibility. There isn't any equivalence in 1.0, leave it zeroed.
+	 * responsibility. There isn't any equivalence in 1.0, but as many 1.x
+	 * ACPI tables contain _PCT and _PSS we also keep this value, unless
+	 * acpi_strict is set.
 	 */
-	local_fadt->pstate_cnt = 0;
+	if (acpi_strict)
+		local_fadt->pstate_cnt = 0;
 
 	/*
 	 * Support for the _CST object and C States change notification.
