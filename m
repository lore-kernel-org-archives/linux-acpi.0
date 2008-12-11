From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Thu, 11 Dec 2008 14:52:47 -0200
Message-ID: <20081211165247.GA4844@khazad-dum.debian.net>
References: <1228957506.4045.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55303 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757667AbYLKQww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Dec 2008 11:52:52 -0500
Content-Disposition: inline
In-Reply-To: <1228957506.4045.11.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au

On Thu, 11 Dec 2008, Tony Vroon wrote:
> The laptop has one "big" kill switch that kills everything,
> WLAN/Bluetooth/3G, you name it. I have no means to turn individual
> radios on or off, all I'll get is a big notifier (from which I can fire
> up a query to see whether the kill switch state got changed).

That is an input device, that should issue EV_SW SW_RFKILL_ALL events (and
not EV_KEY, etc).

So, you won't even #include <linux/rfkill.h>.  The only pitfall I know of is
that you have to re-sync the input layer at every point it could have missed
a state change.  This means you must issue gratuitous EV_SW SW_RFKILL_ALL
events with the current state of the switch after you created the input
device, after resume (from S3/S4), and when you get the notifier from ACPI
that the switch state could have changed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
