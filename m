From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: KT400 clarification
Date: Tue, 15 Jul 2003 01:05:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307150105.50440.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

OK, been thinking about this some more. I think you have several problems 
here:

In APIC mode, your BIOS's AML code for ALKA, ALKB, ALKC, ALKD (IRQs 20, 21, 
22, 23) is buggy for IRQs > 15 on the following devices: (this list is 
derived from where I think there are bugs in the AML)

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 
[EHCI])
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)

This seems to match up to the devices that have problems in your 2.5.75 dmesg.


In PIC mode, your BIOS's ACPI entries _should_ be all right. However, I think 
you then ran into problems because the IRQ parameters were incorrectly set.


Without ACPI at all, a different IRQ assignment method is used which does not 
have the bugs I've found.


So my current thinking is (this is with my latest irq parameters patch)... can 
you confirm?

1) No ACPI, No APIC --- This works OK.
2) ACPI + APIC --- This does not work. It will never work unless the AML code 
in your BIOS is fixed. 
3) ACPI, No APIC --- This should work with the changes my patch made. 
4) No ACPI, APIC --- This works OK.

Looking back at your mails, I don't think you've tried (3) with my patch... 

You don't happen to have <quiet>windows</quiet> you could get onto that box do 
you? It would be interesting to see what it does with those devices... just 
idle curiosity on my part though.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
