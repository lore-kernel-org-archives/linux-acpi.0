From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [BK PATCH] acpismp=force fix
Date: Mon, 23 Jun 2003 12:46:38 +0100 (BST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0306231224590.1648-100000@localhost.localdomain>
References: <1056355301.1699.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1056355301.1699.6.camel-PDvaWZGbcxi0rsOeZxrteAC/G2K4zDHf@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 23 Jun 2003, Arjan van de Ven wrote:
> On Mon, 2003-06-23 at 09:43, Grover, Andrew wrote:
> > > From: Andrew Morton [mailto:akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org] 
> > > >    ACPI: make it so acpismp=force works (reported by Andrew Morton)
> > 
> > > But prior to 2.5.72, CPU enumeration worked fine without 
> > > acpismp=force. 
> > > Now it is required.  How come?
> > 
> > (I'm taking the liberty to update the subject, which I accidentally left
> > blank)
> > 
> > Because 2.4 has that behavior. One objection that people raised to
> > applying the 2.4 ACPI patch was that it changed that behavior. So I made
> > an effort to keep it there.
> 
> in 2.4 it is absolutely not mantadory; it's default actually if the cpu
> advertises the "ht" flag.....

Right, enabling HT hasn't relied on "acpismp=force" since 2.4.18.
Requiring "acpismp=force" now in 2.4 or 2.5 is just a step backwards.

But when we changed to HT by default, I added bootparam "noht" to
disable it if it was found troublesome.  Last time I checked, "noht"
was ineffectual on 2.5, and perhaps now it's ineffectual on 2.4.22-pre?

(If I remember right, in 2.5 it did have one effect, determining whether
the "ht" flag is shown in /proc/cpuinfo: but it was intended to be more
useful than that.)

Certainly reliance on "acpismp=force" should be removed if it's crept
back in.  But what should we do about "noht"?  Wave a fond goodbye,
and remove it's associated code and Documentation from 2.4 and 2.5
trees, rely on changing the BIOS setting instead?  Or bring it back
into action?

Hugh
