From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: Add video_switch_key option
Date: Wed, 24 Nov 2010 14:35:17 +0000
Message-ID: <20101124143517.GA31182@srcf.ucam.org>
References: <s5hhbg7zzqi.wl%tiwai@suse.de> <s5hipznnqv4.wl%tiwai@suse.de> <20101124142618.GB30831@srcf.ucam.org> <s5hfwuqrdxs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45147 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0KXOfX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2010 09:35:23 -0500
Content-Disposition: inline
In-Reply-To: <s5hfwuqrdxs.wl%tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wed, Nov 24, 2010 at 03:31:11PM +0100, Takashi Iwai wrote:

> Typically GNOME changes to the next monitor mode (e.g. xinearama,
> clone, laptop-only, external-only) by each XF86VideoSwitch key event.
> If you connect your laptop to a monitor, and sets to clone mode,
> close the lid, and reopen.  Then you'll find the video mode is now
> external-monitor only.  It's because two XF86VideoSwitch key events
> are issued during close/open the lid.

That's not what that keystroke is expected to do. Userspace needs to 
either interpret it as "Reprobe devices" or pay attention to the 
configuration that the firmware requested.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
