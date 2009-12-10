From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [PATCH 10/10] thinkpad-acpi: sync input
 device EV_SW state directly
Date: Thu, 10 Dec 2009 11:19:18 -0200
Message-ID: <20091210131918.GA18283@khazad-dum.debian.net>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
 <1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
 <200912081745.14725.dmitry.torokhov@gmail.com>
 <20091209163041.GA29575@khazad-dum.debian.net>
 <20091209172119.GB4456@core.coreip.homeip.net>
 <20091209203201.GC29575@khazad-dum.debian.net>
 <20091209205926.GD10138@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44303 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758892AbZLJNTP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Dec 2009 08:19:15 -0500
Content-Disposition: inline
In-Reply-To: <20091209205926.GD10138@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Len Brown <lenb@kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ibm-acpi-devel@lists.sourceforge.net

On Wed, 09 Dec 2009, Dmitry Torokhov wrote:
> > Still, please look at the patch below...  Would something like this be a
> > cleaner API?  It is certainly more obvious, and it is cleaner on the driver
> > side (one function call does everything, instead of a call to
> > input_set_capability plus a call to whatever the driver needs to issue the
> > initial EV_SW event)...
> > 
> 
> Yes, I think it is a good idea. However why don't we change it to:
> 
> input_setup_event(dev, type, code, value)
> {
> 	input_set_capability(...);
> 	input_event(...);
> }
> 
> So it would work for everything (who knows, maybe down the road some
> driver wants to init its ABS axes properly and so on)?

Well, we already have input_set_abs_params, I'd say that's the correct place
to init the axes... and you'd compile-break any drivers that need love to
properly init the axes, so it is a win-win situation as it would make sure
the patch is feature-complete (i.e. converts all drivers to the new call and
makes sure they all init their abs params properly).

The only other event that needs initialization are the switches, so I'd
argue that we might as well use my proposed patch, which is specific and
more lightweight, and convert the in-tree drivers to it.  A few might be
missing the before-registering input_event...

BTW, looking at input.h, wouldn't it be better to force the init functions
to be run before registering the input device, doing a BUG_ON() if they're
misused?   I'd also suggest a BUG_ON(!dev), or at least an if (!dev) return
-EINVAL; to the top of input_register_device(...)...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
