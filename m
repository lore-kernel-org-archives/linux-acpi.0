From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 12:11:17 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE91@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>, hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Mikael Pettersson [mailto:mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org] 
> I would like to see HT_ONLY generalized to parsing the MADT for
> I/O-APICs. The problem I have is that some mainboards, like my
> i850 ASUS P4T-E, have I/O-APICs but no MP tables. The only way for
> the Linux kernel to discover the I/O-APICs on these mainboard is
> through MADT parsing.
> 
> However, this currently requires me to enable all of ACPI, which
> I don't need or want for many reasons, including code bloat and
> behavioural side-effects.
> 
> Replacing "HT_ONLY" with "MADT_PARSING_ONLY" would be ideal, IMO.

This won't help you. If you have *no* MPS tables, then you need ACPI
(and specifically the ability to execute the _PRT control methods) for
interrupt routing information, in addition to ioapic and local apic
(CPU) enumeration. If this wasn't the case, I'm sure someone would have
implemented ioapic MADT enumeration code long ago.

Also, nothing is going to fundamentally change the size of the ACPI code
(but we do keep chipping away at it, as evidenced by the dynamic SDT
patch, -Os, etc.) but I'd like to hear more about the behavioral
side-effects you'd mentioned, with an eye towards fixing them.

Regards -- Andy
