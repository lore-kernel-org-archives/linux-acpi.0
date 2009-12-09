From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [ibm-acpi-devel] [PATCH 10/10] thinkpad-acpi: sync input
	device EV_SW state directly
Date: Wed, 9 Dec 2009 12:59:26 -0800
Message-ID: <20091209205926.GD10138@core.coreip.homeip.net>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br> <1260322590-5571-11-git-send-email-hmh@hmh.eng.br> <200912081745.14725.dmitry.torokhov@gmail.com> <20091209163041.GA29575@khazad-dum.debian.net> <20091209172119.GB4456@core.coreip.homeip.net> <20091209203201.GC29575@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59990 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684AbZLIU7Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 15:59:25 -0500
Received: by pwj9 with SMTP id 9so2620254pwj.21
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2009 12:59:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091209203201.GC29575@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Len Brown <lenb@kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ibm-acpi-devel@lists.sourceforge.net

On Wed, Dec 09, 2009 at 06:32:01PM -0200, Henrique de Moraes Holschuh wrote:
> On Wed, 09 Dec 2009, Dmitry Torokhov wrote:
> > > input_report_switch() will call input_event(), which will have a 50% chance
> > > of doing the wrong thing at startup (i.e. issue an event) since it will look
> > > at the state of the sw bitmap to decide whether to issue an event or not.
> > > 
> > 
> > It will not propagate events because until you register the device there
> > won't be any consumers attached to it. So the only thing that will
> > happen is that it will sync internal state of the device from input core
> > point of view with the true state of the hardware.
> 
> Ah, I see.  Cute trick, and yes, that would work just fine.  I will do that,
> it certainly beats accessing the sw bitmap directly.
> 
> Is it documented anywhere?

Not explicetiley, no.

> 
> Still, please look at the patch below...  Would something like this be a
> cleaner API?  It is certainly more obvious, and it is cleaner on the driver
> side (one function call does everything, instead of a call to
> input_set_capability plus a call to whatever the driver needs to issue the
> initial EV_SW event)...
> 

Yes, I think it is a good idea. However why don't we change it to:

input_setup_event(dev, type, code, value)
{
	input_set_capability(...);
	input_event(...);
}

So it would work for everything (who knows, maybe down the road some
driver wants to init its ABS axes properly and so on)?

-- 
Dmitry
