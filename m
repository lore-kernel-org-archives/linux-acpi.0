From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] RE: [patch] 2.4.x ACPI updates
Date: Wed, 20 Aug 2003 19:55:13 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC96@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yeah, broke this in 2.6 also -- apparently neglected to test that change w/o CONFIG_SMP...

Patrick suggested a cleaner way to do this code using fewer #ifdefs, so I'll try that out this evening.  Until that arrives, you can just nuke that line and the "noapic" flag will revert to being broken in ACPI mode like it was before this week.

Thanks,
-Len

===== arch/i386/kernel/setup.c 1.91 vs edited =====
--- 1.91/arch/i386/kernel/setup.c	Sat Aug 16 00:28:34 2003
+++ edited/arch/i386/kernel/setup.c	Wed Aug 20 19:48:21 2003
@@ -545,7 +545,7 @@
 
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6)) {
-			skip_ioapic_setup = 1;
+//			skip_ioapic_setup = 1;
 		}
 #endif
