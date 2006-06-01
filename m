From: Daniel Drake <dsd@gentoo.org>
Subject: Most interrupts are edge-triggered, non-APIC system
Date: Thu, 01 Jun 2006 22:04:46 +0100
Message-ID: <447F566E.4060502@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:43104 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965304AbWFAVEy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jun 2006 17:04:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: joliveirinha@gmail.com

Hi,

Jo=C3=A3o Oliveirinha reported a bug related to the sky2 network driver=
 on=20
the Gentoo bugzilla. Stephen Hemminger (sky2 author) kindly helped=20
diagnose the issues, and he believes that one of the reasons why things=
=20
are running sub-optimally is because the interrupt assigned to sky2 is=20
edge-triggered (NAPI requires things to be level-triggered).

The system is a bit odd in that even on the latest BIOS, APIC support i=
s=20
apparently completely non-functional (or maybe just non-existent?). Eve=
n=20
when the "lapic" parameter is used, ACPI appears to be used exclusively=
=20
for interrupt routing.

This is a Toshiba M40-298 laptop.

Here is the interrupts map:

            CPU0
   0:      47094          XT-PIC  timer
   1:        541          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   9:         13          XT-PIC  acpi
  10:       5548          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb2, Intel I=
CH6
  11:         27          XT-PIC  uhci_hcd:usb3, uhci_hcd:usb4,=20
uhci_hcd:usb5, yenta, sdhci:slot0, sdhci:slot1, sdhci:slot2, ohci1394, =
sky2
  12:        618          XT-PIC  i8042
  14:       7384          XT-PIC  libata
  15:       1275          XT-PIC  libata
NMI:          0
LOC:          0
ERR:          0
MIS:          0

And the ELCR register:
	ACPI: setting ELCR to 0200 (from 0c20)

0200 suggests that IRQ 9 is the only level-triggered interrupt. Also,=20
the interrupts are heavily shared, I'm not sure if this is another=20
reason for concern...

Anyway, I'm not too familiar with ACPI or interrupt routing, so: do you=
=20
regard it as a bug that so many interrupts are level-triggered?

If so, we can get it filed at the kernel bugzilla if appropriate.

Here is some info that might be useful:

dmesg dump with ACPI debugging enabled:
http://bugs.gentoo.org/attachment.cgi?id=3D85619&action=3Dview

dmesg with the lapic parameter used at boot:
https://bugs.gentoo.org/attachment.cgi?id=3D85540&action=3Dview

acpidump:
https://bugs.gentoo.org/attachment.cgi?id=3D85685&action=3Dview

The actual bug report:
http://bugs.gentoo.org/show_bug.cgi?id=3D131274

Thanks,
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
