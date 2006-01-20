From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Gentoo on Acer Aspire 3502WLCi with bugged DSDT (Phoenix BIOS)
Date: Fri, 20 Jan 2006 17:27:58 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005CA2273@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:24277 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932245AbWATW2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 17:28:42 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Venturi <fabio.venturi@studenti.unipr.it>
Cc: linux-acpi@vger.kernel.org


>title Gentoo GNU/Linux (Fixed DSDT)
>kernel (hd0,2)/boot/bzImage-2.6.15 root=/dev/hda3
>initrd=(hd0,2)/boot/DSDT.aml
>[...]
>
>but when the system finish to boot, "dmsg |grep -i dsdt" says:
>
>ACPI: DSDT (v001 PTLTD     661MX 0x06040000 MSFT 0x0100000e) @
>0x00000000
>ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
>Table [DSDT](id 0006) - 485 Objects with 39 Devices 93 Methods 10
>Regions
>
>So the original DSDT from the BIOS is loaded instead of
>loading the custom one.
>(Yes, i activate the CONFIG_ACPI_CUSTOM_DSDT, RamDisk Support ecc..

If you're using CONFIG_ACPI_CUSTOM_DSDT
(and setting CONFIG_ACPI_CUSTOM_DSDT_FILE to the soruce file...)

then do not apply the initrd patch (unapply it if you've applied it)
do not create a special initrd file, and do not modify your grub/menu.lst

-Len
