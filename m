From: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Mon, 30 Aug 2004 17:45:12 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0408301743190.21529@montezuma.fsmlabs.com>
References: <200408171728.06262.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0408231839280.13924@montezuma.fsmlabs.com>
 <200408301309.54465.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262905AbUH3Vku@vger.kernel.org>
In-Reply-To: <200408301309.54465.blaisorblade_spam@yahoo.it>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Mon, 30 Aug 2004, BlaisorBlade wrote:

> Alle 00:41, marted=EC 24 agosto 2004, Zwane Mwaikambo ha scritto:
> > On Thu, 19 Aug 2004, BlaisorBlade wrote:
> > > (CC me on replies as I'm not subscribed).
> > >
> > > A short description, with my hypothesis about how the panic() hap=
pened:
> >
> > There is a short one liner for this which is already in the latest
> > kernel;
>
> Ok, fine, that's a lot better than my fix - and what about the stacki=
ng
> problem? Also there are some other drivers which could need fixing, p=
robably
> (I've not the time now).

I don't think we should worry about the stacking problem, in fact it's =
not
meant to be stacked at all. Regarding other drivers, there are none tha=
t
i'm aware of that require fixing. There aren't many users of pm_idle
outside of arch/*/kernel/process.c

Thanks,
	Zwane
