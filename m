From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 2/2 update] misc: Add dell-laptop driver
Date: Wed, 03 Dec 2008 12:37:22 +0000
Message-ID: <49367D82.8040305@tuffmail.co.uk>
References: <20081127163357.GA22846@srcf.ucam.org> <20081127163444.GB22846@srcf.ucam.org> <20081202115029.2b9d1153.akpm@linux-foundation.org> <20081202201645.GB31620@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:34644 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYLCMh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 07:37:28 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1491449eyi.37
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2008 04:37:26 -0800 (PST)
In-Reply-To: <20081202201645.GB31620@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Ivo van Doorn <ivdoorn@gmail.com>

Matthew Garrett wrote:
> misc: Add dell-laptop driver
>     
> Add a driver for controling Dell-specific backlight and rfkill interfaces.
> This driver makes use of the dcdbas interface to the Dell firmware to allow
> the backlight and rfkill interfaces on Dell systems to be driven through the
> standardised sysfs interfaces.
>     
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> ---
>
> Contains Andrew's suggested updates, plus a fix for a leak on the init 
> error path.
>   

I see you don't call rfkill_set_default(). Do Dell firmwares support
persistent rfkill state?

My ill-informed guess is that it shouldn't hurt to call it. If the
firmware is sane, it will initialize the rfkill to a useful state.
Otherwise, the radio(s) would be unusable without the platform driver.
But do feel free to ignore me, if you suspect the firmware of insanity :).

Regards
Alan
