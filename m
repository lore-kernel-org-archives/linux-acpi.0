From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH] report acpi video hot key event through input
	device
Date: Wed, 08 Aug 2007 14:08:05 -0400
Message-ID: <1186596485.19883.10.camel@rzhang-asus.sh.intel.com>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
	 <20070730005050.GB27398@srcf.ucam.org>
	 <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51921 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbXHHGGv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Aug 2007 02:06:51 -0400
In-Reply-To: <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Mon, 2007-07-30 at 12:47 +0100, Richard Hughes wrote:
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
Hmm, I think they are slightly different.
"zero" equals _BCM(0)
"off" means turn off the output device, i.e. set to D1/D2/D3 state. 

Thanks,
Rui
