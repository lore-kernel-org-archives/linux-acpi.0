From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Tue, 18 Mar 2008 11:11:21 +0800
Message-ID: <1205809881.6193.10.camel@sli10-desk.sh.intel.com>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
	 <200803142203.33821.rjw@sisk.pl>
	 <1205716543.26236.6.camel@sli10-desk.sh.intel.com>
	 <200803171726.46904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44790 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbYCRDLw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2008 23:11:52 -0400
In-Reply-To: <200803171726.46904.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>


On Mon, 2008-03-17 at 17:26 +0100, Rafael J. Wysocki wrote:
> On Monday, 17 of March 2008, Shaohua Li wrote:
> > 
> > On Fri, 2008-03-14 at 22:03 +0100, Rafael J. Wysocki wrote:
> > > On Friday, 14 of March 2008, Jesse Barnes wrote:
> > > > On Friday, March 14, 2008 7:37 am Rafael J. Wysocki wrote:
> > > > > On Friday, 14 of March 2008, Shaohua Li wrote:
> > > > > > On Thu, 2008-03-13 at 21:44 -0700, Greg KH wrote:
> > > > > > > On Fri, Mar 14, 2008 at 11:49:09AM +0800, Shaohua Li wrote:
> > > > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > > > > index 9010f54..821ad02 100644
> > > > > > > > --- a/include/linux/pci.h
> > > > > > > > +++ b/include/linux/pci.h
> > > > > > > > @@ -1016,6 +1016,8 @@ enum pci_fixup_pass {
> > > > > > > >  	pci_fixup_final,	/* Final phase of device fixups */
> > > > > > > >  	pci_fixup_enable,	/* pci_enable_device() time */
> > > > > > > >  	pci_fixup_resume,	/* pci_enable_device() time */
> > > > > > > > +	pci_fixup_suspend,
> > > > > > > > +	pci_fixup_resume_later,
> > > > > > >
> > > > > > > Please document when these quirks are run.
> > > > > >
> > > > > > will do if you think the method is correct.
> > > > > >
> > > > > > > And why "_later"?  What's wrong with the normal resume time?
> > > > > >
> > > > > > pci_fixup_resume is called in pci_device_resume_earily(), which is
> > > > > > called with interrupt disable, so I added a new one which is called at
> > > > > > pci_device_resume(), this routine is called with interrupt enabled.
> > > > >
> > > > > Is the pci_fixup_resume thing used at all?  If it is, how can I check who
> > > > > uses it?
> > > > 
> > > > Oh good catch, it looks like it's unused at this point (at least there's no 
> > > > DECLARE_PCI_FIXUP_SUSPEND macro in pci.h), it was probably just put there for 
> > > > completeness.
> > > 
> > > It seems to be used only in quirks.c .
> > > 
> > > I'd prefer to rename the existing one to pci_fixup_resume_noirq and define a
> > > new one called pci_fixup_resume to be used by pci_device_resume().
> > > 
> > > Also, it would be worth checking if all of the existing resume quirks need to
> > > be run with interrupts disabled.
> > As far as I checked, only this one need interrupt enabled.
> 
> Still, do all of the others _require_ interrupts to be disabled?
No, they don't need interrupt disabled, but be called in .resume_early,
which will disable interrupt.

> > Introducing 
> > pci_fixup_resume_noirq and move the quirk to .resume is feasible in the
> > case, but it's not quite good to me. The quirk is to make smbus
> > controller not hide and then smbus can be resumed, the order is
> > important. If the quirk is called in .resume, that means smbus
> > controller can't have a .resume_early. The quirk is a FIXUP_HEADER, it
> > really should be called early, eg in .resume_early.
> 
> I meant "move all of the other quirks that need to run with interrupts
> disabled to pci_fixup_resume_noirq, leave those that may run with interrups
> enabled within pci_fixup_resume and add yours to pci_fixup_resume".
Just change the name? then I'd prefer use pci_fixup_resume and
pci_fixup_resume_early.

Some quirks should be called with interrupt disabled, we can't directly
call them in .resume_early. Also the patch introduces
pci_fixup_resume_early and pci_fixup_suspend, which matches current
device core callbacks (.suspend/.resume_early).

TBD: Somebody knows why we need quirk resume should double check if a
quirk should be called in resume or resume_early. I changed some per my
understanding, but can't make sure I fixed all.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e571c72..59307d6 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -289,6 +289,9 @@ static int pci_device_suspend(struct device * dev, pm_message_t state)
 		if (pci_dev->current_state == PCI_D0)
 			pci_dev->current_state = PCI_UNKNOWN;
 	}
+
+	pci_fixup_device(pci_fixup_suspend, pci_dev);
+
 	return i;
 }
 
@@ -334,6 +337,7 @@ static int pci_device_resume(struct device * dev)
 		error = drv->resume(pci_dev);
 	else
 		error = pci_default_resume(pci_dev);
+	pci_fixup_device(pci_fixup_resume, pci_dev);
 	return error;
 }
 
@@ -343,7 +347,7 @@ static int pci_device_resume_early(struct device * dev)
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
-	pci_fixup_device(pci_fixup_resume, pci_dev);
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (drv && drv->resume_early)
 		error = drv->resume_early(pci_dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e9a333d..21e9cdb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -556,7 +556,7 @@ static void quirk_via_ioapic(struct pci_dev *dev)
 	pci_write_config_byte (dev, 0x58, tmp);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic);
 
 /*
  * VIA 8237: Some BIOSs don't set the 'Bypass APIC De-Assert Message' Bit.
@@ -576,7 +576,7 @@ static void quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
 
 /*
  * The AMD io apic can hang the box when an apic irq is masked.
@@ -622,7 +622,7 @@ static void quirk_amd_8131_ioapic(struct pci_dev *dev)
         }
 } 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
 #endif /* CONFIG_X86_IO_APIC */
 
 /*
@@ -774,7 +774,7 @@ static void quirk_cardbus_legacy(struct pci_dev *dev)
 	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_cardbus_legacy);
-DECLARE_PCI_FIXUP_RESUME(PCI_ANY_ID, PCI_ANY_ID, quirk_cardbus_legacy);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID, quirk_cardbus_legacy);
 
 /*
  * Following the PCI ordering rules is optional on the AMD762. I'm not
@@ -797,7 +797,7 @@ static void quirk_amd_ordering(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
 
 /*
  *	DreamWorks provided workaround for Dunord I-3000 problem
@@ -865,7 +865,7 @@ static void quirk_disable_pxb(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
 
 static void __devinit quirk_amd_ide_mode(struct pci_dev *pdev)
 {
@@ -885,9 +885,9 @@ static void __devinit quirk_amd_ide_mode(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
@@ -1092,31 +1092,61 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asu
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
 
-static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+/* It appears we just have one such device. If not, we have a warning */
+static void __iomem *asus_rcba_base;
+static void asus_hides_smbus_lpc_ich6_suspend(struct pci_dev *dev)
 {
-	u32 val, rcba;
-	void __iomem *base;
+	u32 rcba;
 
 	if (likely(!asus_hides_smbus))
 		return;
+	WARN_ON(asus_rcba_base);
+
 	pci_read_config_dword(dev, 0xF0, &rcba);
-	base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000); /* use bits 31:14, 16 kB aligned */
-	if (base == NULL) return;
-	val=readl(base + 0x3418); /* read the Function Disable register, dword mode only */
-	writel(val & 0xFFFFFFF7, base + 0x3418); /* enable the SMBus device */
-	iounmap(base);
+	/* use bits 31:14, 16 kB aligned */
+	asus_rcba_base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000);
+	if (asus_rcba_base == NULL)
+		return;
+}
+
+static void asus_hides_smbus_lpc_ich6_resume_early(struct pci_dev *dev)
+{
+	u32 val;
+
+	if (likely(!asus_hides_smbus || !asus_rcba_base))
+		return;
+	/* read the Function Disable register, dword mode only */
+	val = readl(asus_rcba_base + 0x3418);
+	writel(val & 0xFFFFFFF7, asus_rcba_base + 0x3418); /* enable the SMBus device */
+}
+
+static void asus_hides_smbus_lpc_ich6_resume(struct pci_dev *dev)
+{
+	if (likely(!asus_hides_smbus || !asus_rcba_base))
+		return;
+	iounmap(asus_rcba_base);
+	asus_rcba_base = NULL;
 	dev_info(&dev->dev, "Enabled ICH6/i801 SMBus device\n");
 }
+
+static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+{
+	asus_hides_smbus_lpc_ich6_suspend(dev);
+	asus_hides_smbus_lpc_ich6_resume_early(dev);
+	asus_hides_smbus_lpc_ich6_resume(dev);
+}
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume_early);
 
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
@@ -1134,10 +1164,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus);
 
 /*
  * ... This is further complicated by the fact that some SiS96x south
@@ -1171,7 +1201,7 @@ static void quirk_sis_503(struct pci_dev *dev)
 	quirk_sis_96x_smbus(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
 
 
 /*
@@ -1204,7 +1234,7 @@ static void asus_hides_ac97_lpc(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
 
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
@@ -1269,12 +1299,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, qui
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
 
 #endif
 
@@ -1521,6 +1551,10 @@ extern struct pci_fixup __start_pci_fixups_enable[];
 extern struct pci_fixup __end_pci_fixups_enable[];
 extern struct pci_fixup __start_pci_fixups_resume[];
 extern struct pci_fixup __end_pci_fixups_resume[];
+extern struct pci_fixup __start_pci_fixups_resume_early[];
+extern struct pci_fixup __end_pci_fixups_resume_early[];
+extern struct pci_fixup __start_pci_fixups_suspend[];
+extern struct pci_fixup __end_pci_fixups_suspend[];
 
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
@@ -1553,6 +1587,16 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		end = __end_pci_fixups_resume;
 		break;
 
+	case pci_fixup_resume_early:
+		start = __start_pci_fixups_resume_early;
+		end = __end_pci_fixups_resume_early;
+		break;
+
+	case pci_fixup_suspend:
+		start = __start_pci_fixups_suspend;
+		end = __end_pci_fixups_suspend;
+		break;
+
 	default:
 		/* stupid compiler warning, you would think with an enum... */
 		return;
@@ -1629,7 +1673,7 @@ static void quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
 static void __devinit quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f054778..cf108a3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -84,6 +84,12 @@
 		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
 		*(.pci_fixup_resume)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_resume_early) = .;	\
+		*(.pci_fixup_resume_early)				\
+		VMLINUX_SYMBOL(__end_pci_fixups_resume_early) = .;	\
+		VMLINUX_SYMBOL(__start_pci_fixups_suspend) = .;		\
+		*(.pci_fixup_suspend)					\
+		VMLINUX_SYMBOL(__end_pci_fixups_suspend) = .;		\
 	}								\
 									\
 	/* RapidIO route ops */						\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b7e4b63..ec68b45 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1015,7 +1015,9 @@ enum pci_fixup_pass {
 	pci_fixup_header,	/* After reading configuration header */
 	pci_fixup_final,	/* Final phase of device fixups */
 	pci_fixup_enable,	/* pci_enable_device() time */
-	pci_fixup_resume,	/* pci_enable_device() time */
+	pci_fixup_resume,	/* pci_device_resume() */
+	pci_fixup_suspend,	/* pci_device_suspend */
+	pci_fixup_resume_early, /* pci_device_resume_early() */
 };
 
 /* Anonymous variables would be nice... */
@@ -1037,6 +1039,12 @@ enum pci_fixup_pass {
 #define DECLARE_PCI_FIXUP_RESUME(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
 			resume##vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_RESUME_EARLY(vendor, device, hook)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume_early,		\
+			resume_early##vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_SUSPEND(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend,			\
+			suspend##vendor##device##hook, vendor, device, hook)
 
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);


