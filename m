From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 18:11:14 +0100 (BST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0307151805020.7780-100000@localhost.localdomain>
References: <F760B14C9561B941B89469F59BA3A8470255EE8E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EE8E-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Jul 2003, Grover, Andrew wrote:
> 
> Make it so acpismp=force works (reported by Andrew Morton)

But we don't want "acpismp=force" to work, it now serves no purpose
but to confuse.  May I push again to Marcelo my patch you acked
before, which removes it completely?  I had been waiting to say it's
in 2.6, but Andrew didn't push it from 2.5-mm into 2.6 - any reason?

Whereas we would still like "noht" to work, but it's now beyond me.

Hugh
