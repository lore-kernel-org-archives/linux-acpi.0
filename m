From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [RFC][PATCH 1/2] show Intel QuickPath Interconnect Routing and
	Protocol Layer Registers in PCI config space
Date: Fri, 4 Sep 2009 10:07:45 -0700
Message-ID: <86802c440909041007w9fee1edg49d755dc3fe627e5@mail.gmail.com>
References: <20090904165525.26294.31112.sendpatchset@t500>
	 <20090904165535.26294.95511.sendpatchset@t500>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:60839 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933769AbZIDRPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2009 13:15:20 -0400
In-Reply-To: <20090904165535.26294.95511.sendpatchset@t500>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@redhat.com>
Cc: linux-kernel@vger.kernel.org, jcm@redhat.com, sdietrich@novell.com, linux-acpi@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, mingo@elte.hu, lenb@kernel.org, ktokunag@redhat.com, tglx@linutronix.de, Olaf.Dabrunz@gmx.net

On Fri, Sep 4, 2009 at 9:55 AM, Stefan Assmann<sassmann@redhat.com> wro=
te:
> On some machines with Intel X58 or Intel 55x0 chipset the Intel Quick=
Path
> Interconnect Routing and Protocol Layer Registers or not exposed to P=
CI config
> space. Access to these is necessary to disable boot interrupts in the=
 QPI
> Protocol Interrupt Control Register.
> DEVHIDE1 provides a method to (un)hide the PCI config space of device=
s inside
> the IOH and is altered to guarantee that PCI config space is accessib=
le.
> See Intel document #320838-003, sections 17.6.5.10 and 17.11.2.21.
>
> Signed-off-by: Stefan Assmann <sassmann@redhat.com>
> ---
> =A0drivers/pci/quirks.c =A0 =A0| =A0 24 ++++++++++++++++++++++++
> =A0include/linux/pci_ids.h | =A0 =A01 +
> =A02 files changed, 25 insertions(+)
>
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1612,6 +1612,30 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
> =A0DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, =A0 PCI_DEVICE_ID_IN=
TEL_ESB_10, =A0 =A0quirk_disable_intel_boot_interrupt);
>
> =A0/*
> + * Show Intel QuickPath Interconnect Routing and Protocol Layer Regi=
sters
> + * in PCI config space (ensures access to QPIPINTRC).
> + * See Intel document #320838-003, sections 17.6.5.10 and 17.11.2.21=
=2E
> + */
> +#define INTEL_X58_55x0_DEVHIDE1_REG =A0 =A00xf2
> +#define INTEL_X58_55x0_HIDE_DEV17_FUN0 (1<<12)
> +#define INTEL_X58_55x0_HIDE_DEV17_FUN1 (1<<13)
> +
> +static void quirk_show_intel_qpi_conf_register(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 u16 pci_config_word;
> +
> + =A0 =A0 =A0 pci_read_config_word(dev, INTEL_X58_55x0_DEVHIDE1_REG, =
&pci_config_word);
> + =A0 =A0 =A0 pci_config_word &=3D ~(INTEL_X58_55x0_HIDE_DEV17_FUN0 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INTEL_X58_55=
x0_HIDE_DEV17_FUN1);
> + =A0 =A0 =A0 pci_write_config_word(dev, INTEL_X58_55x0_DEVHIDE1_REG,=
 pci_config_word);
> +
> + =A0 =A0 =A0 /* need to rescan the bus for changes to take effect */
> + =A0 =A0 =A0 pci_rescan_bus(dev->bus);

better to check if those bits are set already...

can you move the quirk to EARLY to avoid rescan bus?

YH

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, =A0 PCI_DEVICE_ID_INTEL=
_IOAT_TBG9, =A0quirk_show_intel_qpi_conf_register);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, =A0PCI_DEVICE_ID_INTEL=
_IOAT_TBG9, =A0quirk_show_intel_qpi_conf_register);
> +
> +/*
> =A0* disable boot interrupts on HT-1000
> =A0*/
> =A0#define BC_HT1000_FEATURE_REG =A0 =A0 =A0 =A0 =A00x64
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2508,6 +2508,7 @@
> =A0#define PCI_DEVICE_ID_INTEL_IOAT_TBG5 =A00x342a
> =A0#define PCI_DEVICE_ID_INTEL_IOAT_TBG6 =A00x342b
> =A0#define PCI_DEVICE_ID_INTEL_IOAT_TBG7 =A00x342c
> +#define PCI_DEVICE_ID_INTEL_IOAT_TBG9 =A00x342e
> =A0#define PCI_DEVICE_ID_INTEL_IOAT_TBG0 =A00x3430
> =A0#define PCI_DEVICE_ID_INTEL_IOAT_TBG1 =A00x3431
> =A0#define PCI_DEVICE_ID_INTEL_IOAT_TBG2 =A00x3432
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
