From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Thu, 11 Dec 2008 17:47:34 -0200
Message-ID: <20081211194734.GA18132@khazad-dum.debian.net>
References: <1228957506.4045.11.camel@localhost> <20081211165247.GA4844@khazad-dum.debian.net> <1229016827.6446.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33593 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760265AbYLKTrj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Dec 2008 14:47:39 -0500
Content-Disposition: inline
In-Reply-To: <1229016827.6446.6.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au

On Thu, 11 Dec 2008, Tony Vroon wrote:
> On Thu, 2008-12-11 at 14:52 -0200, Henrique de Moraes Holschuh wrote:
> > That is an input device, that should issue EV_SW SW_RFKILL_ALL events (and
> > not EV_KEY, etc).
> 
> Okay, glad I asked.
> Can I combine EV_SW & EV_KEY on a single input device (as there is
> already a FUJ02E3 input device within the device driver) or would that
> break things?

Sure, you can combine them.

> Also, would there be a clear acknowledgement of an rfkill state change
> in Gnome?

I don't think so if you mean Gnome knowing what to do with EV_SW
SW_RFKILL_ALL.  That is not a report that radios got rfkilled, but rather a
COMMAND to rfkill all radios.

One could attach OSD to it (using HAL), but it would be more correct to
attach OSD events to the radios being rfkilled (and not to the command to
rfkill radios as some radios might refuse to obey that command, after
all... probably those without rfkill support :p).

Gnome (well, network manager) is supposed to notice is radios getting
rfkilled, which is likely to mean it will notice the WLAN card going into
RFKILL_STATE_HARD_BLOCKED in your case, since WWAN and BT are often USB
devices and just get hot(un)plugged...

> > The only pitfall I know of is that you have to re-sync the input layer at every point it could have missed
> > a state change.  This means you must issue gratuitous EV_SW SW_RFKILL_ALL
> > events with the current state of the switch after you created the input
> > device, after resume (from S3/S4), and when you get the notifier from ACPI
> > that the switch state could have changed.
> 
> Done at input device creation and when notified. I have no resume
> callback to hook into.

You will need one, even if you will use it only to call your "read the
current state and send it over the input layer as an EV_SW SW_RFKILL_ALL
event" function.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
