From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC
	behaviour
Date: Mon, 22 Feb 2010 09:51:19 +0800
Message-ID: <1266803479.2608.1484.camel@rzhang1-desktop>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com>
	 <alpine.LFD.2.00.1002190140230.24628@localhost.localdomain>
	 <20100219135431.GA29434@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33543 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab0BVBvt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Feb 2010 20:51:49 -0500
In-Reply-To: <20100219135431.GA29434@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2010-02-19 at 21:54 +0800, Matthew Garrett wrote:
> On Fri, Feb 19, 2010 at 01:40:47AM -0500, Len Brown wrote:
> > Matthew,
> > 
> > Is there a life failure someplace (eg. bugzilla) that works after this 
> > patch?
> 
> My system statically initialises the variable containing the current 
> brightness to 100, but doesn't include 100 in the list of valid 
> brightnesses.

sorry, I don't understand.
does the video driver set the backlight to 100, which is not a valid
value in the _BCL package?

>  Right now this causes us to stop believing _BQC. However, 
> the enxt thing we do is set the brightness to maximum anyway - at this 
> point _BQC will now return a correct value.

hmmm, could you attach the acpidump please?

thanks,
rui

>  So it makes sense to ignore 
> _BQC failures until we've set a valid value. If it continues to give 
> invalid results then we can invalidate it and just use our internal 
> state.
>  


