From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 18:38:39 +0100 (BST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0307151832520.7904-100000@localhost.localdomain>
References: <F760B14C9561B941B89469F59BA3A8470255EE8F@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EE8F-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb417-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Jul 2003, Grover, Andrew wrote:
> > From: Hugh Dickins [mailto:hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org] 
> > > Make it so acpismp=force works (reported by Andrew Morton)
> > 
> > But we don't want "acpismp=force" to work, it now serves no purpose
> > but to confuse.  May I push again to Marcelo my patch you acked
> > before, which removes it completely?  I had been waiting to say it's
> > in 2.6, but Andrew didn't push it from 2.5-mm into 2.6 - any reason?
> > 
> > Whereas we would still like "noht" to work, but it's now beyond me.
> 
> That patch was sitting in my bk tree but yeah it's kinda stale. Len
> Brown was going to completely redo all this stuff, so Hugh if you have a
> need for your fix in the interim then great feel free to push, but there
> is a more comprehensive fix also in the works.

I've no desperate need to push it, can easily apply the patch to my own
tree.  It's just that Marcelo is motoring so speedily towards 2.4.22,
be a shame if that goes out with CONFIG_ACPI_HT_ONLY needing pointless
"acpismp=force" too.  What's the schedule for Len's rework to Marcelo?

Hugh
