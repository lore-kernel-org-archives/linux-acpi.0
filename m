From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH -next 2/2] acpi,rfkill,backlight:
	comapl-laptop update - use rfkill switch subsystem
Date: Thu, 10 Jul 2008 10:29:34 -0300
Message-ID: <20080710132934.GB1346@khazad-dum.debian.net>
References: <20080709231059.778d16f4@debian> <200807092357.28013.IvDoorn@gmail.com> <20080710011201.GC15729@khazad-dum.debian.net> <200807101517.38109.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754981AbYGJN3w@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807101517.38109.IvDoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 10 Jul 2008, Ivo van Doorn wrote:
> > Do you want me to mark rfkill_force_state() as mandatory in the docs?  It
> > *IS* the preferred way to deal with firmware/hardware-initiated state
> > changes, after all.
> 
> Please do. Thanks.
> 
> > The rfkill subsystem will limp along without it, even when there are
> > hardware rfkill lines... but no OSD function will work, as the system will
> > pick up the change only when someone reads or writes to the state
> > attribute...
> 
> That reason alone is good enough for me to mark it mandatory for any drivers
> which features the rfkill key. :)

Input drivers don't need it at all, so it is not the drivers with rfkill
keys (input devices) that need it.  Rather, the drivers of wireless devices
with hardware rfkill lines are the ones who "need" it.

Yeah, I am definately adding it to the docs.  Did some locking fixes and
other dangerous crap too (in the sense that it can easily force me to down a
brown paperbag!), that needs to go to the list for RFC.  Will send what I
have done already after some light testing.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
