From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] laptop_panel.brightness_in_hardware: add all Asus laptops
Date: Thu, 16 Jul 2009 23:22:47 +0100
Message-ID: <4A5FA837.9050300@tuffmail.co.uk>
References: <4A49D305.1040703@tuffmail.co.uk> <71cd59b00906300231yf2d3657tb5c5945f5aae0e7b@mail.gmail.com> <20090708095111.GA8471@srcf.ucam.org> <61b223ba0907080336i313232cco216c9c647a2e9247@mail.gmail.com> <20090708104300.GA10269@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:60864 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454AbZGPWWw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2009 18:22:52 -0400
Received: by ewy26 with SMTP id 26so488396ewy.37
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2009 15:22:51 -0700 (PDT)
In-Reply-To: <20090708104300.GA10269@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: hal@lists.freedesktop.org, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

Matthew Garrett wrote:
> The problem in that case is that the kernel changes the backlight for 
> us. The lack of consistency on this front makes life somewhat harder. 
>
> In terms of the "Some hardware sends keyboard events but also changes 
> the brightness", I'm working on a cleaner solution for this. The easiest 
> would seem to be to generate a uevent when the backlight is changed, 
> which would then allow userspace to pop up UI even though the key press 
> events aren't propagated. It would seem to deal with the Eee (and older 
> Thinkpad) cases quite nicely, but does require some more code in 
> userspace.
>   

Ok. Maybe it's trivial or "niche", but I really appreciate this. I think 
it's the only remaining issue I have with my EeePC :-).

I just saw the patch to generate uevents for the acpi video driver. It 
looks like it still generates KEY_BRIGHTNESSDOWN. Are you planning a 
followup patch, to suppress the input events when 
brightness_switch_enabled == 1?

Equally, w.r.t patch 3, I don't think eeepc-laptop, should generate 
brightness events on the *input* device anymore.

The rationale is that KEY_BRIGHTNESSDOWN is a user request to increase 
brightness. In these cases, the firmware/driver has already increased 
the brightness. We've notified userspace via the backlight device. So we 
shouldn't pass the request on to userspace; it has already been acted 
upon. If we still generate KEY_BRIGHTNESS*, userspace has to guess 
whether or not the change has already been applied. If there is too much 
latency, it guesses wrong :-(.

Thanks!
Alan
