From: =?iso-8859-1?q?Mica=20Telodico?= <maria_libera2000-whZMOeQn8C0@public.gmane.org>
Subject: _CRS returns NULL!  message , problems?
Date: Sun, 29 Feb 2004 14:49:42 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040229134942.75260.qmail@web41906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

I'm the owner of a Abit KV7 Motherboard (VIA KT600),
and I get these messages at the boot time :

 _CRS returns NULL! Using IRQ 21 fordevice (PCI
Interrupt Link [ALKB]).
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ
21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 20 fordevice (PCI
Interrupt Link [ALKA]).
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ
20 Mode:1 Active:1)
00:00:11[A] -> 2-20 -> IRQ 20
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 22 fordevice (PCI
Interrupt Link [ALKC]).
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ
22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
_CRS returns NULL! Using IRQ 23 fordevice (PCI
Interrupt Link [ALKD]).
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ
23 Mode:1 Active:1)
00:00:11[D] -> 2-23 -> IRQ 23


what do mean those _CRS returns NULL! ?

Does this message means problems with some hardware?

Thanks

______________________________________________________________________
Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati, l'antivirus, il filtro Anti-spam
http://it.yahoo.com/mail_it/foot/?http://it.mail.yahoo.com/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
