From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sat, 21 Jun 2008 02:40:47 +0100
Message-ID: <20080621014047.GA20908@srcf.ucam.org>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806201353.59083.rjw@sisk.pl> <20080620115714.GC8637@srcf.ucam.org> <200806201422.12659.rjw@sisk.pl> <20080620122714.GA9332@srcf.ucam.org> <Pine.LNX.4.55.0806202241120.19614@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806202241120.19614@cliff.in.clinika.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 21, 2008 at 02:09:00AM +0100, Maciej W. Rozycki wrote:

>  Meanwhile we may consider implementing a workaround.  I think one that 
> does not hurt competent vendors would be preferable.  The DSDT containing 
> the rubbish described here is marked with an OEM ID: "HP    " and OEM 
> Table ID: "SB400".  These keys could be used to remove IRQ0 information
> from the IRQ tables.  Our code is prepared to handle such a case.  
> Something easy to do for a seasoned ACPI fiddler, I suppose. ;)

Something roughly like the following? Entirely untested, my 6125 is in a 
box somewhere. My recollection is that skip_timer_override will disable 
the IRQ 0->2 mapping, which I believe is what's broken here?

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 33c5216..6ca5eff 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1060,6 +1060,16 @@ static int __init force_acpi_ht(const struct dmi_system_id *d)
 	return 0;
 }
 
+#ifdef CONFIG_X86_IO_APIC
+static int __init force_skip_timer_override(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE "%s detected: disabling timer overrides",
+	       d->ident);
+	acpi_skip_timer_override = 1;
+	return 0;
+}
+#endif
+
 /*
  * If your system is blacklisted here, but you find that acpi=force
  * works for you, please contact acpi-devel@sourceforge.net
@@ -1227,6 +1237,24 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+#ifdef CONFIG_X86_IO_APIC
+	{
+	 .callback = force_skip_timer_override,
+	 .ident = "HP NX6125 laptop",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nx6125"),
+		     },
+	 },
+	{
+	 .callback = force_skip_timer_override,
+	 .ident = "HP NX6325 laptop",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nx6325"),
+		     },
+	 },
+#endif
 	{}
 };


-- 
Matthew Garrett | mjg59@srcf.ucam.org
