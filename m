From: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [BK PATCH] acpismp=force fix
Date: Fri, 27 Jun 2003 11:59:34 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030627115934.D16156@devserv.devel.redhat.com>
References: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com> <Pine.LNX.4.44.0306271221110.1197-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306271221110.1197-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>; from hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org on Fri, Jun 27, 2003 at 12:58:17PM +0100
To: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Arjan van de Ven' <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 27, 2003 at 12:58:17PM +0100, Hugh Dickins wrote:
> and in 2.4.22-pre (which thus diverges from 2.4.21).  That surprises me,
> but I'd definitely defer to Arjan's preference.

for 2.4 it's a matter of compatability; also Andrew said it made the
code cleaner actually.

> > Re: "acpismp=force"
> > I wouldn't miss it.  Sounds unanimous.
> 
> It did have some point before, recent changes have rendered it pointless,
> and even if those changes get revised, there'll be a better way than the
> confusing "acpismp=force".

it became mostly useless when the automatic detection based on CPU flag went it

> > Re: "noht"
> > To disable HT on a uni-processor, wouldn't it be preferable to simply run
> > the UP kernel rather than the SMP kernel with HT disabled?
> 
> Yes, though wouldn't BIOS be able to disable it on those too?

not all bioses have such a setting unfortionatly so it remains a
useful option.
