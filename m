From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [Bug #13389] Warning 'Invalid throttling state, reset' gets displayed when it should not be
Date: Mon, 27 Jul 2009 23:25:02 +0200
Message-ID: <200907272325.03259.rjw@sisk.pl>
References: <DizPU9GBfHF.A.kgF.iWObKB@chimera> <H5-1lZIIeYK.A.f0H.XYObKB@chimera> <200907270322.47523.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200907270322.47523.elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 27 July 2009, Frans Pop wrote:
> On Sunday 26 July 2009, Rafael J. Wysocki wrote:
> > The following bug entry is on the current list of known regressions
> > introduced between 2.6.29 and 2.6.30.  Please verify if it still should
> > be listed and let me know (either way).
> >
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13389
> > Subject	: Warning 'Invalid throttling state, reset' gets displayed
> >		  when it should not be
> > Patch		: http://bugzilla.kernel.org/attachment.cgi?id=21671
> > 		  http://bugzilla.kernel.org/attachment.cgi?id=21672
> 
> Rui has acked the patches [1], but AFAIK Len has not yet picked them up.
> 
> [1] http://lkml.org/lkml/2009/7/7/474

No, Len hasn't picked them up, but he's not been responsive recently in
general.

Best,
Rafael
