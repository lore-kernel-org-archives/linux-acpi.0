From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI 100002 IRQ 9 problem.
Date: Wed, 25 Jun 2003 10:20:15 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE65@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Joshua Schmidlkofer <menion-8BColdH5dlvzIImvGDD8mw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Joshua Schmidlkofer [mailto:menion-8BColdH5dlvzIImvGDD8mw@public.gmane.org] 
>    First is there a different list for ACPI questions?

>From MAINTAINERS:

ACPI
P:	Andy Grover
M:	andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
L:	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
W:	http://sf.net/projects/acpi/
S:	Maintained

>    For the sake of disclosure, the dump I am reporting is 2.5.73, plus
> the Davide Libenzis' SiS-96x patch.  I also am currently using the
> nvidia driver, I was able to reproduce this in vanilla 2.5.72 (no
> nvidia), and I will try tomorrow with a vanilla setup of 2.5.73-bk3.
> [unless bk4 is available].
> 
>    I have a Soyo P4S-645D, with the SiS 645 chipset.  I have had some
> problems w/ the IRQ routing, but 2.5.7[123] have sorted it 
> out (mostly) 
> I am having problems ACPI, it is better if I say 
> 'pci=noacpi', but what
> happens is when the ACPI interrupt count hit 100002, then I get the
> following message on all consoles:
> 
> menion kernel: Disabling IRQ #9
> 
> Then, I have the following as part of dmesg:
> 
> Call Trace: [<c010cad4>]  [<c010cbad>]  [<c010ce46>]  [<c010880e>] 
> [<c010880e>]  [<c010b320>]  [<c010880e>]  [<c010880e>]  [<c0108832>] 
> [<c010889a>]  [<c0105000>]  [<c041c6bd>]  [<c041c41e>]
> [<c0247446>]
> Warning (Oops_read): Code line not seen, dumping what data is 
> available

There is a known, as-yet-unfixed problem, but the usual symptom is you
hit 100000 interrupts and then it gets nicely disabled - I'm not sure
why your system oopses.

Regards -- Andy
