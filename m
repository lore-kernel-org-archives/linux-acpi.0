From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: Add video_switch_key option
Date: Wed, 24 Nov 2010 14:26:18 +0000
Message-ID: <20101124142618.GB30831@srcf.ucam.org>
References: <s5hhbg7zzqi.wl%tiwai@suse.de> <s5hipznnqv4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34241 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab0KXO0Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2010 09:26:24 -0500
Content-Disposition: inline
In-Reply-To: <s5hipznnqv4.wl%tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wed, Nov 24, 2010 at 08:05:35AM +0100, Takashi Iwai wrote:
> Hi,
> 
> At Wed, 27 Oct 2010 12:39:17 +0200,
> Takashi Iwai wrote:
> > Some HP laptops send ACPI video events per lid open/close, and the
> > ACPI video driver translates to SWITCHVIDEOMODE input key events.
> > This behavior confuses the user-space daemon such as
> > gnome-settings-daemon since it changes the video mode per this key,
> > which results in a different video mode at each time you open/close
> > the laptop lid.  Fn-Fx keys are handled differently on such hardware,
> > thus this key generation is simply superfluous.
> > 
> > This patch adds a module parameter "video_switch_key" to either
> > assign a different key code for this ACPI event or disable by setting
> > zero there.
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Any comments on this patch?

I'm not entirely clear on why this is wanted. Lid state changes seem to 
be a reasonable proxy for "Reprobe outputs" - what's userspace actually 
doing that causes problems?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
