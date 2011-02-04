From: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Fri, 4 Feb 2011 08:44:05 +0200
Message-ID: <201102040844.05490.ozan@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D4B2883.4020701@pardus.org.tr> <201102032351.31307.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:55073 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab1BDGuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Feb 2011 01:50:11 -0500
In-Reply-To: <201102032351.31307.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

Cuma 04 =C5=9Eubat 2011 g=C3=BCn=C3=BC (saat 00:51:31) Rafael J. Wysock=
i =C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:

> Hmm.  Are those boxes uniprocessor running SMP kernels?

The kernel is SMP.

ASUS X61S is=20
 CPU0: Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz stepping 0a

=4650SV has 2 CPU's too according to dmesg:
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] Processor #1
[    0.000000] I/O APIC #2 Version 20 at 0xFEC00000.
[    0.000000] IOAPIC[0]: apic_id 2, version 20, address 0xfec00000, GS=
I 0-23
[    0.000000] Processors: 2
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs

ASUS N51JQ (occasional shutdown hang) has:
CPU0: Intel(R) Core(TM) i7 CPU       Q 740  @ 1.73GHz stepping 05
[    0.132435] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 Ok.
[    0.768809] Brought up 8 CPUs


---
Ozan =C3=87a=C4=9Flayan
TUBITAK/UEKAE - Pardus Linux
http://www.pardus.org.tr/eng
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
