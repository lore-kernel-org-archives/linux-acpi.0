From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] laptop_panel.brightness_in_hardware: add all Asus
	laptops
Date: Thu, 16 Jul 2009 23:27:03 +0100
Message-ID: <20090716222703.GA24437@srcf.ucam.org>
References: <4A49D305.1040703@tuffmail.co.uk> <71cd59b00906300231yf2d3657tb5c5945f5aae0e7b@mail.gmail.com> <20090708095111.GA8471@srcf.ucam.org> <61b223ba0907080336i313232cco216c9c647a2e9247@mail.gmail.com> <20090708104300.GA10269@srcf.ucam.org> <4A5FA837.9050300@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55088 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933449AbZGPW1J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2009 18:27:09 -0400
Content-Disposition: inline
In-Reply-To: <4A5FA837.9050300@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: hal@lists.freedesktop.org, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, Jul 16, 2009 at 11:22:47PM +0100, Alan Jenkins wrote:

> I just saw the patch to generate uevents for the acpi video driver. It  
> looks like it still generates KEY_BRIGHTNESSDOWN. Are you planning a  
> followup patch, to suppress the input events when  
> brightness_switch_enabled == 1?

I didn't want to change the behaviour of the driver with existing 
userspace, but yes, I agree that that's the correct behaviour. To make 
it consistent with everything else it should probably also default to 
brightness_switch_enabled = 0 (and we ship it that way in Fedora), but 
again, compatibility.

> Equally, w.r.t patch 3, I don't think eeepc-laptop, should generate  
> brightness events on the *input* device anymore.

Right.

> The rationale is that KEY_BRIGHTNESSDOWN is a user request to increase  
> brightness. In these cases, the firmware/driver has already increased  
> the brightness. We've notified userspace via the backlight device. So we  
> shouldn't pass the request on to userspace; it has already been acted  
> upon. If we still generate KEY_BRIGHTNESS*, userspace has to guess  
> whether or not the change has already been applied. If there is too much  
> latency, it guesses wrong :-(.

Absolutely. The other thing that needs doing is for dell-laptop to 
consume the brightness keys, or alternatively for us to remap them on 
Dells. Right now (in the worst case) we're getting two sets of them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
