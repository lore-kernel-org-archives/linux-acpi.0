From: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [BK PATCH] acpismp=force fix
Date: Mon, 23 Jun 2003 11:54:08 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030623115408.E23874@devserv.devel.redhat.com>
References: <1056355301.1699.6.camel@laptop.fenrus.com> <Pine.LNX.4.44.0306231224590.1648-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306231224590.1648-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>; from hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org on Mon, Jun 23, 2003 at 12:46:38PM +0100
To: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 12:46:38PM +0100, Hugh Dickins wrote:
> Certainly reliance on "acpismp=force" should be removed if it's crept
> back in.  But what should we do about "noht"?  Wave a fond goodbye,
> and remove it's associated code and Documentation from 2.4 and 2.5
> trees, rely on changing the BIOS setting instead?  Or bring it back
> into action?

for 2.4 it's no problem to honor it really code wise; and it's
useful for machines where you can't disable HT in the bios but where
your particular workload doesn't positively benefit from HT.
