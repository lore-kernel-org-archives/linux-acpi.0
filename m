From: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Subject: RE: [BUG] test9 ACPI bad: scheduling while atomic!
Date: Tue, 28 Oct 2003 15:56:05 -0800 (PST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.GSO.4.58.0310271858210.12662@blinky>
References: <571ACEFD467F7749BC50E0A98C17CDD8D5FDBB@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8D5FDBB-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 28 Oct 2003, Li, Shaohua wrote:

> The reason is just what you said. It's a race condition.

> In UP, the problem occurs also. But it can't cause anything, because spinlock
> does nothing in UP. In some machines which have the problem in UP, you will
> see some info like this:
> Hwregs-0760[35] hw_low_level_read: Unsupported address space:C8

It's clearly a spinlock that leads up to Alex's oops, but the T40 oops?

> > It seems rather theoretical, but perhaps we could fix it with a patch like
> > the following.  I tested it for kicks and didn't hit any problems, but I'm
> > afraid it risks more problems than it solves.  Thoughts?
>
> Did just discarding the events cause problem?

Hmmm.  I don't imagine it would.  Indeed, registering the address space handler
alone may be good enough for ECDT use.  I'd favor that.

Regardless, we still have the Thinkpad T40 problem.

On Tue, 28 Oct 2003, Li, Shaohua wrote:

> one solution is using bh to handle such events before EC device added.
> After EC is loaded, we still use keventd to handle the events. Any idea?

Aren't BHs obsolete?
