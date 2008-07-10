From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH -next 2/2] acpi,rfkill,backlight:
	comapl-laptop update - use rfkill switch subsystem
Date: Wed, 9 Jul 2008 22:12:01 -0300
Message-ID: <20080710011201.GC15729@khazad-dum.debian.net>
References: <20080709231059.778d16f4@debian> <200807092333.01355.IvDoorn@gmail.com> <20080709234419.12d6eabc@debian> <200807092357.28013.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56811 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751224AbYGJBMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 21:12:07 -0400
Content-Disposition: inline
In-Reply-To: <200807092357.28013.IvDoorn@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 09 Jul 2008, Ivo van Doorn wrote:
> It is not mandatory if you are writing rfkill support for a driver that does not
> come with a rfkill switch. Such drivers can make use of the rfkill events produced
> by the hardware which does have such a switch.
> 
> When the hardware does have the rfkill switch, then yes rfkill_force_state() is mandatory.
> The get_state() callback function is optional, and allows rfkill to differentiate
> between soft and hardblock.

Do you want me to mark rfkill_force_state() as mandatory in the docs?  It
*IS* the preferred way to deal with firmware/hardware-initiated state
changes, after all.

The rfkill subsystem will limp along without it, even when there are
hardware rfkill lines... but no OSD function will work, as the system will
pick up the change only when someone reads or writes to the state
attribute...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
