From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: "noht" (RE: ACPI patches updated (20030714))
Date: Thu, 17 Jul 2003 19:14:58 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <A5974D8E5F98D511BB910002A50A66470B981269@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Hugh Dickins' <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'ACPI-Devel mailing list' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Marcelo Tosatti' <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

"noht" turns out to be tricky for ACPI in practice.

ACPI really shouldn't tinker with or skip LAPIC enumeration.  It can't rely
on the table LAPIC ids to get packge numbers, and it can't rely on the BIOS
to have MPS implemented to enumerate physical processors.

The only reliable way to get the logical/physical mapping is the way
init_intel() does it today -- run CPUID locally on that logical processor
after it is up and running.

So if the kernel is to disable HT, the proper way would be to initialize all
the logical processors, have them identify themselves, and then optionally
take themselves off-line.  A possiblity for 2.6.

BIOS SETUP remains the preferred way to disable HT.  If the hardware is
implemented such that duplicated resources could be combined when HT is
disabled, only the BIOS would be able to do that -- so single threaded
performance with Linux implemented 'noht' might lag performance with BIOS
implemented 'noht'...

Given that 'noht' is workaround for a missing BIOS switch, I'm not confident
it is a win to burden the Linux kernel with it.

Cheers,
-Len


> -----Original Message-----
> From: Brown, Len 
> Sent: Tuesday, July 15, 2003 10:36 PM
> To: 'Hugh Dickins'
> Cc: Grover, Andrew; ACPI-Devel mailing list; 
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Marcelo Tosatti
> Subject: RE: ACPI patches updated (20030714)
> 
> 
> > From: Hugh Dickins [mailto:hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org] 
> 
> > > 		ACPI && !ACPI_HT_ONLY
> > > 			Full ACPI w/o the acpi=cpu option
> > 
> > Shouldn't this combination also support "noht", or is that 
> > too much to ask?
> 
> Can do.  It will be called CONFIG_ACPI_HT, and will be 
> required for ACPI to enable HT -- with or without the full 
> CONFIG_ACPI.
> 
> Cheers,
> -Len
> 
