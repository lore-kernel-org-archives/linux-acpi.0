From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support to hotkey subdriver
Date: Mon, 16 Jul 2007 11:46:26 -0400
Message-ID: <d120d5000707160846m541ddd33uccdb5387ee9ee1c3@mail.gmail.com>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	 <11844223334107-git-send-email-hmh@hmh.eng.br>
	 <20070714223144.GA25782@srcf.ucam.org>
	 <20070715181233.GG14134@khazad-dum.debian.net>
	 <20070715184519.GD3235@srcf.ucam.org>
	 <20070715200338.GB19066@khazad-dum.debian.net>
	 <20070715201201.GA5518@srcf.ucam.org>
	 <20070715205934.GF19066@khazad-dum.debian.net>
	 <20070715210405.GA6216@srcf.ucam.org>
	 <20070715215453.GJ19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:45676 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbXGPPq2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 11:46:28 -0400
Received: by nz-out-0506.google.com with SMTP id s18so871021nze
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 08:46:27 -0700 (PDT)
In-Reply-To: <20070715215453.GJ19066@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On 7/15/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > On Sun, Jul 15, 2007 at 05:59:34PM -0300, Henrique de Moraes Holschuh wrote:
> > > *HAL* does.  HAL is *not* all there is to userspace.  The input layer is not
> > > an interface between the kernel and HAL, it is an interface between kernel
> > > and userspace.
> >
> > Hal is the only piece of userspace that knows how to speak to more than
> > one type of backlight in any useful way, which makes it the de-facto
> > reference for how userspace interprets these keys.
>
> Since when does system-specific programs not count?
>
> Anyway, the idea of "special cases" that are not exposed anywhere and
> requires out-of-band information to be handled correctly is just broken IMO.
> This goes triple for an interface whose only canon documentation is the
> current kernel code, so you can't even tell people to read somewhere how to
> properly use it.
>
> Since we have detected the need for passive events, I'd much rather that
> information was added to the input layer itself, instead of being
> synthesized later.
>

I am unconvinced that input layer is the proper place to add such
information. These are events signalling state change of some device.
In case of volume changes these events do not refect change in
keyboard state but rather some other device (sound card) so I would
expect these events be coming from there.
I also do not want to convert input layer into kitchen sink of generic
userspace notifications. Laptop "battery removed" does not belong to
input. "Network cable removed" does not belong to input. "Hard driver
dying" does not belong to input.

> > > Add that knowledge to the input layer, and I will agree.  Add it to every
> > > consumer of input events, and I will concede.  Until then, it is good that
> > > HAL can overcome the lack of such information in the input layer, but that
> > > doesn't make it the right way to use the input layer.
> >
> > The fact that keys share event codes doesn't mean that these keycodes
> > are going to have identical semantics on all hardware. One solution to
> > that would be to avoid ever sending these keycodes, but that would make
> > having them defined in the first place a bit silly. Since they /are/
> > there, it makes sense to use them.
>
> I see a keycode defined in the USB HID spec for use in stuff that only knows
> active handling -- passive doesn't even make any sense for them -- and its
> reflect on the kernel input layer.
>
> There _are_ a few platforms where *one* of the built-in devices need a
> different handling, and that's just because the firmware won't cooperate.
> But if I plug a USB keyboard on a thinkpad, for example, I need the proper
> (active) handling of the event.
>
> I definately think "avoid ever sending these keycodes" in this instance is
> the right way to go, until we can actually issue a "this is a passive key
> press" event.
>

How do you know that this is a "passive keypress"? Can you put another
(better) soundcard in a docking station? Woudl the firmware still
control that card (doubtful)? Do we want the same keys to control that
card's volume?

-- 
Dmitry
