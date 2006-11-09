From: "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Thu, 9 Nov 2006 13:03:16 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071CC@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-res.frontbridge.com ([63.161.60.49]:26295 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S966057AbWKIVD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2006 16:03:28 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olivier Nicolas <olivn@trollprod.org>
Cc: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>


           CPU0       CPU1       
  0:        214      24856   IO-APIC-edge      timer
  1:          0        359   IO-APIC-edge      i8042
  6:          0          5   IO-APIC-edge      floppy
  8:          0          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          0        103   IO-APIC-edge      i8042
 14:          0        128   IO-APIC-edge      ide0
 16:          0          0   IO-APIC-fasteoi   libata
 17:          1          2   IO-APIC-fasteoi   bttv0
 20:         22       6469   IO-APIC-fasteoi   libata
 21:         11      99989   IO-APIC-fasteoi   ehci_hcd:usb2, HDA Intel
 22:          0          1   IO-APIC-fasteoi   libata, ohci_hcd:usb1
 23:          0          0   IO-APIC-fasteoi   libata
308:          8       2378   PCI-MSI-edge      eth1
309:          0          9   PCI-MSI-edge      eth1
310:          0          9   PCI-MSI-edge      eth1
311:          4       2401   PCI-MSI-edge      eth0
312:          0          0   PCI-MSI-edge      eth0
313:          0          1   PCI-MSI-edge      eth0
NMI:         74         47 
LOC:      25024      24991 
ERR:          0

But according to the irq router in pci conf, 
the ehci and audio share to use irq 20.
sata0 and ohci use irq 23
sata1 use irq 22, (MAC1 share it but kernel will use MSI)
sata2 use irq 21, (MAC0 share it but kernel will use MSI)

the ACPI report wrong GSI for them?

Can you disable the acpi and check the interrupt and lspci?

YH




