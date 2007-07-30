From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] report acpi video hot key event through input device
Date: Mon, 30 Jul 2007 08:55:21 -0400
Message-ID: <d120d5000707300555g1e677815s6148d346f0d65e5e@mail.gmail.com>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
	 <20070730005050.GB27398@srcf.ucam.org>
	 <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:42665 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757300AbXG3MzX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2007 08:55:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1047378ugf
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jul 2007 05:55:21 -0700 (PDT)
In-Reply-To: <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

Hi,

On 7/30/07, Richard Hughes <hughsient@gmail.com> wrote:
> On 30/07/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Sun, Jul 29, 2007 at 12:40:16PM -0400, Luming Yu wrote:
> > >       switch (event) {
> > >       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch,
> > >                                        * most likely via hotkey. */
> > >               acpi_bus_generate_event(device, event, 0);
> > > +             keycode = KEY_UNKNOWN;
> >
> > KEY_SWITCHVIDEOMODE ?
>
> Yes, please use this. This is what other ACPI drivers are using.
>
> > What's wrong with the existing KEY_BRIGHTNESSDOWN and KEY_BRIGHTNESSUP?
>
> Agree, this matches other drivers like thinkpad_acpi and sony-laptop.
>
> > > +#define KEY_BRIGHTNESS_ZERO  0x1fd
> > > +#define KEY_BRIGHTNESS_OFF   0x1fe
> >
> > You almost certainly want to go via linux-input if you're adding new
> > keycodes.
>
> Yup - do we have to distinguish between zero and off? Or is off
> "switch panel backlight off" and zero is "switch to lowest brightness
> level"?
>
> Thanks for doing this, this is another part or the puzzle to make keys
> just work in userspace and is very appreciated.
>

I have some concerns over this patch. Some of the events reported are
not the regular key presses that something needs to process and
perform an action. Consider ACPI_VIDEO_NOTIFY_SWITCH is "Used to
notify OSPM whenever the state of one of the output devices attached
to the VGA controller has been switched or toggled." As far as I
understand the event (whatever it was) was already processed by
firmware and we getting a notification event of system change. So I am
not sure that this event should be sent as a key event.

The brightness events on the other hand seem to be perfectly suited
for an input device (unless are are also already processed by the
firmware and action has already been taken).

-- 
Dmitry
