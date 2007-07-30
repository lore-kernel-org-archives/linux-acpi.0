From: "Richard Hughes" <hughsient@gmail.com>
Subject: Re: [RFC PATCH] report acpi video hot key event through input device
Date: Mon, 30 Jul 2007 12:47:52 +0100
Message-ID: <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
	 <20070730005050.GB27398@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:42998 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761380AbXG3Lry (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2007 07:47:54 -0400
Received: by wr-out-0506.google.com with SMTP id 36so8705wra
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jul 2007 04:47:53 -0700 (PDT)
In-Reply-To: <20070730005050.GB27398@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On 30/07/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sun, Jul 29, 2007 at 12:40:16PM -0400, Luming Yu wrote:
> >       switch (event) {
> >       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch,
> >                                        * most likely via hotkey. */
> >               acpi_bus_generate_event(device, event, 0);
> > +             keycode = KEY_UNKNOWN;
>
> KEY_SWITCHVIDEOMODE ?

Yes, please use this. This is what other ACPI drivers are using.

> What's wrong with the existing KEY_BRIGHTNESSDOWN and KEY_BRIGHTNESSUP?

Agree, this matches other drivers like thinkpad_acpi and sony-laptop.

> > +#define KEY_BRIGHTNESS_ZERO  0x1fd
> > +#define KEY_BRIGHTNESS_OFF   0x1fe
>
> You almost certainly want to go via linux-input if you're adding new
> keycodes.

Yup - do we have to distinguish between zero and off? Or is off
"switch panel backlight off" and zero is "switch to lowest brightness
level"?

Thanks for doing this, this is another part or the puzzle to make keys
just work in userspace and is very appreciated.

Richard.
