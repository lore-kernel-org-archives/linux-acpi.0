From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/9] ACPI: thinkpad-acpi: make the video output feature
	optional
Date: Sat, 16 Feb 2008 15:47:05 -0200
Message-ID: <20080216174705.GB3193@khazad-dum.debian.net>
References: <1203135478-4813-1-git-send-email-hmh@hmh.eng.br> <1203135478-4813-6-git-send-email-hmh@hmh.eng.br> <200802160039.17214.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36645 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756031AbYBPRrM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Feb 2008 12:47:12 -0500
Content-Disposition: inline
In-Reply-To: <200802160039.17214.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Sat, 16 Feb 2008, Len Brown wrote:
> On Friday 15 February 2008 23:17, Henrique de Moraes Holschuh wrote:
> > The video output port control feature is not very useful on many ThinkPads
> > (especially when a X server is running), and lately userspace is getting
> > better and better at it, so it makes sense to allow users to stripe out the
> > thinkpad-acpi video feature from their kernels and save at least 2KB.

[...]

> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -258,6 +258,23 @@ config THINKPAD_ACPI_BAY
> >  
> >  	  If you are not sure, say Y here.
> >  
> > +config THINKPAD_ACPI_VIDEO
> > +	bool "Video output control support"
> > +	depends on THINKPAD_ACPI
> > +	default y
> 
> I would consider going one step further and delete this line
> to make it default N (and update the description below).
> 
> Indeed, we recently deleted the kernel code from the ACPI video driver
> that did video display switching -- at the request of the X community.

thinkpad-acpi's video output switching code never triggers automatically, so
it won't cause problems for X.org people, as long as *nobody* ties it to HAL
(or some likewise braindamaged idea) by default.  So far, nobody was
foolhardy enough to do it in any distro or upstream.   Users do, but they do
it *after* they tried it manually and therefore they know if it will work
right or not in their setup.

I think it is best to just leave it to default Y for a few more months,
while I get more reports about where it works well (and how well).  I know
it is a lost cause on very new thinkpads, but what I really need are reports
on the older models, which I don't get as often as I'd like.

Maybe we can make it default to N for 2.6.26, along with a big fat warning
on the Kconfig and at runtime that I need reports on Axx, T2x, X3x, R3x,
otherwise I'll just rip it out for 2.6.27...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
