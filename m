From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI source releases updated (20030619)
Date: Tue, 24 Jun 2003 10:07:40 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FC6@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Udo A. Steinberg [mailto:us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org] 
> The new ACPI interpreter works much better and seems to 
> mostly solve the
> previous problems I had with ACPI on a Dual-Xeon machine with HT, see
> http://bugme.osdl.org/show_bug.cgi?id=774
> 
> The excessive ACPI interrupts have ceased, but I still get exactly
> 100000 ACPI interrupts during bootup and then no more. Also the ACPI
> interrupt seems to hit the e100 driver unexpectedly.

There's still a problem here, btw, so don't close the bug or anything -
it's just that the interrupt code is noticing we're horribly broken and
turning the interrupt off.

Regards -- Andy
