From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 20:02:17 +0100 (BST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0307151953560.1161-100000@localhost.localdomain>
References: <A5974D8E5F98D511BB910002A50A66470B981250@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981250-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Jul 2003, Brown, Len wrote:
> > What's the schedule for Len's rework to Marcelo?
> 
> I'm testing today and expect to push via Andy
> (http://linux-acpi.bkbits.net/to-andy-2.4)  when when I'm satisifed I
> haven't toasted anything -- probably Wednesday. 

Oh, thanks, that sounds very good, much the best if I don't interfere.
Three comments below.

> 		!ACPI && ACPI_HT_ONLY
> 			Minimal kernel to enable HT -- no ACPI
> 			acpi=cpu is the default behaviour here
> 			if somebody wants to disable ht, they can use "noht"
> 			This matches RHL's 2.4 distribution
> 
> 		ACPI && !ACPI_HT_ONLY
> 			Full ACPI w/o the acpi=cpu option
> 			Maybe OSD's will get here some day

Shouldn't this combination also support "noht", or is that too much to ask?

> acpismp=force
> 	TODO: Delete.

Hurrah!

> noht
> 	Keep
> 	TODO: fix
> 	Disable HT for benefit of systems which perform better with HT
> disabled, but
> 	have a BIOS incapable of disabling HT.
> 	currently broken in 2.5

And it's currently broken in 2.4 also.

Thanks,
Hugh
