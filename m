From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 20 Oct 2003 16:15:12 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031020141512.GA30157@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Suspending and resuming from S1 disables ACPI interrupts for my machine
(ASUS L3800C laptop). No further interrupts and events are generated,
/proc/interrupts shows no change w.r. to ACPI. This happens regardless of
whether the specific IRQ is shared or not.

Versions affected: 2.6.0-test[5-8], 2.6.0-test5-mm4, 2.6.0-test6-mm4.
Versions unaffected: 2.6.0-test3, 2.4.22 with 20030918 ACPI.

Note: it seems that running a pmdisk cycle after resume from S1 reenables
the interrupts somehow (though treat it as a not-thoroughly-tested
observation for now).

http://bugme.osdl.org/show_bug.cgi?id=1185 may contain information relevant
to the matter (DSDT, dmesg, etc.).

I'll be happy to provide any further info.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
