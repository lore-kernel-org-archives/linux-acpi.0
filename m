From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [RFC PATCH] report acpi video hot key event through input
	device
Date: Tue, 14 Aug 2007 12:58:25 +0100
Message-ID: <1187092705.2800.9.camel@hughsie-laptop>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
	 <20070730005050.GB27398@srcf.ucam.org>
	 <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
	 <1186555034.19883.19.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:10588 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbXHNJ6x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Aug 2007 05:58:53 -0400
Received: by py-out-1112.google.com with SMTP id d32so2872266pye
        for <linux-acpi@vger.kernel.org>; Tue, 14 Aug 2007 02:58:52 -0700 (PDT)
In-Reply-To: <1186555034.19883.19.camel@rzhang-asus.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org


On Wed, 2007-08-08 at 14:37 +0800, Zhang Rui wrote:
> On Mon, 2007-07-30 at 12:47 +0100, Richard Hughes wrote:
> > On 30/07/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > On Sun, Jul 29, 2007 at 12:40:16PM -0400, Luming Yu wrote:
> > > >       switch (event) {
> > > >       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch,
> > > >                                        * most likely via hotkey. */
> > > >               acpi_bus_generate_event(device, event, 0);
> > > > +             keycode = KEY_UNKNOWN;
> > >
> > > KEY_SWITCHVIDEOMODE ?
> > 
> > Yes, please use this. This is what other ACPI drivers are using.
> > 
> > > What's wrong with the existing KEY_BRIGHTNESSDOWN and KEY_BRIGHTNESSUP?
> > 
> > Agree, this matches other drivers like thinkpad_acpi and sony-laptop.
> > 
> > > > +#define KEY_BRIGHTNESS_ZERO  0x1fd
> > > > +#define KEY_BRIGHTNESS_OFF   0x1fe
> > >
> > > You almost certainly want to go via linux-input if you're adding new
> > > keycodes.
> > 
> > Yup - do we have to distinguish between zero and off? Or is off
> > "switch panel backlight off" and zero is "switch to lowest brightness
> > level"?
> > 
> Hmm, I think they are slightly different.
> IMO, "zero" equals _BCM(0), it means to turn off the backlight, but we
> may still see the screen if there is a ambient light.
> "off" means turn off the output device, i.e. set to D1/D2/D3 state. 

Sure, so they are different states, but to a user they are both
effectively the same "screen is off". Is there any use case to removing
the backlight without powering down the display?

Richard.


