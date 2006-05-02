From: Norbert Preining <preining@logic.at>
Subject: Bus hidden behind transparent bridge
Date: Tue, 2 May 2006 13:09:43 +0200
Message-ID: <20060502110943.GC7703@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:36788 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S932174AbWEBLJp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 May 2006 07:09:45 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3])
	by alpha.logic.tuwien.ac.at with esmtp (Exim 3.35 #1)
	id 1FaslD-0006da-00
	for linux-acpi@vger.kernel.org; Tue, 02 May 2006 13:09:43 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 3.35 #1)
	id 1FaslD-0002Ls-00
	for linux-acpi@vger.kernel.org; Tue, 02 May 2006 13:09:43 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all!

This has been since long time like this without negative impact, but th=
e
message to report it to linux-kernel seems new, so here I am:
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try=
 'pci=3Dassign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #02 (-#02) (try=
 'pci=3Dassign-busses')
Please report the result to linux-kernel to fix this permanently

What can I send you?

Acer TM654LCi
cat /proc/interrupts
           CPU0      =20
  0:     461771          XT-PIC  timer
  1:       5335          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     114019          XT-PIC  uhci_hcd:usb2, eth0
  7:          1          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:      41606          XT-PIC  acpi
 10:     109813          XT-PIC  Intel 82801CA-ICH3 Modem, yenta, uhci_=
hcd:usb1, yenta, uhci_hcd:usb3, uhci_hcd:usb4, ehci_hcd:usb5, Intel 828=
01CA-ICH3, ohci1394, wifi0, radeon@pci:0000:01:00.0
 12:     289329          XT-PIC  i8042
 14:      33170          XT-PIC  ide0
 15:      16326          XT-PIC  ide1
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0


kernel 2.6.17-rc3-mm1


Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0=
 di Siena
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
WRITTLE (vb.)
Of a steel ball, to settle into a hole.
			--- Douglas Adams, The Meaning of Liff
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
