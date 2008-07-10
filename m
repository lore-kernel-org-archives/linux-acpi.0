From: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: [RESEND] [PATCH -next 2/2] acpi,rfkill,backlight: comapl-laptop update - use rfkill switch subsystem
Date: Thu, 10 Jul 2008 15:17:37 +0200
Message-ID: <200807101517.38109.IvDoorn@gmail.com>
References: <20080709231059.778d16f4@debian> <200807092357.28013.IvDoorn@gmail.com> <20080710011201.GC15729@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:12485 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYGJNIO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 09:08:14 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2459915wri.5
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 06:08:12 -0700 (PDT)
In-Reply-To: <20080710011201.GC15729@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>

On Thursday 10 July 2008, Henrique de Moraes Holschuh wrote:
> On Wed, 09 Jul 2008, Ivo van Doorn wrote:
> > It is not mandatory if you are writing rfkill support for a driver that does not
> > come with a rfkill switch. Such drivers can make use of the rfkill events produced
> > by the hardware which does have such a switch.
> > 
> > When the hardware does have the rfkill switch, then yes rfkill_force_state() is mandatory.
> > The get_state() callback function is optional, and allows rfkill to differentiate
> > between soft and hardblock.
> 
> Do you want me to mark rfkill_force_state() as mandatory in the docs?  It
> *IS* the preferred way to deal with firmware/hardware-initiated state
> changes, after all.

Please do. Thanks.

> The rfkill subsystem will limp along without it, even when there are
> hardware rfkill lines... but no OSD function will work, as the system will
> pick up the change only when someone reads or writes to the state
> attribute...

That reason alone is good enough for me to mark it mandatory for any drivers
which features the rfkill key. :)

Ivo
