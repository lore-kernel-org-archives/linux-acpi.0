From: mru-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 20 Oct 2003 16:32:59 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <yw1x8yngj7xg.fsf@users.sourceforge.net>
References: <20031020141512.GA30157@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> writes:

> Suspending and resuming from S1 disables ACPI interrupts for my machi=
ne
> (ASUS L3800C laptop). No further interrupts and events are generated,
> /proc/interrupts shows no change w.r. to ACPI. This happens regardles=
s of
> whether the specific IRQ is shared or not.

I've got an Asus M2400E laptop, and have seen similar things.  After a
suspend, the extra buttons (I use them to fire up programs) stop
working.  Normally, they will generate an ACPI event, that is
processed by acpid etc.  After a suspend, each button will work once.
If I then close and open the lid, they will work one more time, and so
on.  Any way I can help?

--=20
M=E5ns Rullg=E5rd
mru-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org
