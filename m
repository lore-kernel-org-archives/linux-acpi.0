From: Len Brown <lenb@kernel.org>
Subject: Re: [Bugme-new] [Bug 17802] New: touchpad become crazy: disable irq 21
Date: Fri, 26 Nov 2010 15:15:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011261510090.3588@x980>
References: <bug-17802-10286@https.bugzilla.kernel.org/>
 <20100908153201.91dc03d2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:33222 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0KZUPl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2010 15:15:41 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LCI00ESXDM0KQF1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 26 Nov 2010 14:15:37 -0600 (CST)
In-reply-to: <20100908153201.91dc03d2.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org, Dmitry Torokhov <dtor@mail.ru>, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, polhallen@fuckaround.org


            CPU0       CPU1       
   0:     287671     109637   IO-APIC-edge      timer
   8:          0          1   IO-APIC-edge      rtc0
   9:        483        479   IO-APIC-fasteoi   acpi
  16:      36491      15935   IO-APIC-fasteoi   uhci_hcd:usb4, 
uhci_hcd:usb5, ndiswrapper
  18:      23811      10147   IO-APIC-fasteoi   uhci_hcd:usb6, ata_piix
  19:          1          3   IO-APIC-fasteoi   ohci1394
  20:        869        298   IO-APIC-fasteoi   ehci_hcd:usb2, 
uhci_hcd:usb3, HDA Intel
  21:      97807      68959   IO-APIC-fasteoi   ide0, ide1, ehci_hcd:usb1, 
uhci_hcd:usb7
  27:          1          0   PCI-MSI-edge      eth0
  28:      18118      22763   PCI-MSI-edge      i915@pci:0000:00:02.0


The DSDT shows that there are no programmable IRQs
in IOAPIC mode on this machine, so it is unlikely that
there is an ACPI interrupt routing issue.

It is more likely that the problem is in one of the devices (above)
using IRQ21.  I assume that the touchpad is uhci_hcd:usb7?

What does "lsusb" show on this machine?

Of course I'd recommend trying to reproduce the issue
after excluding "ndiswrapper" from the configuration.

cheers,
Len Brown, Intel Open Source Technology Center

