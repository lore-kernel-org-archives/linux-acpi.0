From: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 20:49:29 +0200 (MEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200307151849.h6FInTkH025346@harpo.it.uu.se>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Jul 2003 11:07:29 -0700, "Brown, Len" wrote:
>Ps. Below is the current plan for ACPI build and boot knobs.  Except for the
>config syntax -- 2.4 and 2.5 should end up the same.  Let me know if we
>missed anything.
>
>Audit of ACPI build and boot options
>Scrubbed w/ Andy 7/10 -- see TODO for Lenb's plan
>
>
>Build Options
>-------------
>Indentation shows dependency (from acpi/Kconfig, Makefile)
>
>CONFIG_ACPI_HT_ONLY
>	depends on X86 && ACPI && X86_LOCAL_APIC
>	:= acpitable.o
>
>	TODO: simplify acpitable.c to only to LAPIC enumeration for HT
>		It probably shouldn't parse the non-LAPIC MADT entries

I would like to see HT_ONLY generalized to parsing the MADT for
I/O-APICs. The problem I have is that some mainboards, like my
i850 ASUS P4T-E, have I/O-APICs but no MP tables. The only way for
the Linux kernel to discover the I/O-APICs on these mainboard is
through MADT parsing.

However, this currently requires me to enable all of ACPI, which
I don't need or want for many reasons, including code bloat and
behavioural side-effects.

Replacing "HT_ONLY" with "MADT_PARSING_ONLY" would be ideal, IMO.

/Mikael
