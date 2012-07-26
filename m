From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update relevant
 code
Date: Thu, 26 Jul 2012 14:58:38 +0200
Message-ID: <20120726125838.GA28853@growl>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56304 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab2GZM6q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2012 08:58:46 -0400
Received: by weyx8 with SMTP id x8so1315590wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2012 05:58:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Wed, Jul 25, 2012 at 01:38:09PM -0400, alexdeucher@gmail.com wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> Add a new header that defines the AMD ACPI interface used
> for laptops, PowerXpress, and chipset specific functionality
> and update the current code to use it.

Great! Now my DSDT makes sense ;)

> Todo:
> - properly verify the ACPI interfaces
> - hook up and handle ACPI notifications

I see a problem here, I've hacked up a standalone test module, but:

> +#define ATIF_FUNCTION_GET_SYSTEM_PARAMETERS                        0x1
[...]
> + * flags
> + * bits 1:0:
> + * 0 - Notify(VGA, 0x81) is not used for notification
> + * 1 - Notify(VGA, 0x81) is used for notification

My system has this bit set, and the brightness control method does send
the notification.
My module register itself with register_acpi_notifier and gets 2
notifications, one with ACPI_VIDEO_NOTIFY_PROBE (0x81) and the other
with ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS (or DEC, depending on what I
press).

The standard acpi "video" module, however, in response to
ACPI_VIDEO_NOTIFY_PROBE generates a key press sending
KEY_SWITCHVIDEOMODE.

This greatly confuses KDE which messes up my dual screen configuration;
I guess that the spurious KEY_SWITCHVIDEOMODE may be problematic also
with other DEs...

In more detail what happens is the following:
- I press the brightness hotkey, firmware generates a notification on
  the relevant device (_SB.PCI0.PEG0.VGA.LCD)
- ACPI video module gets the ACPI_VIDEO_NOTIFY_{DEC,INC}_BRIGHTNESS
  notification and tries to adjust the brightness with
  acpi_video_device_lcd_set_level, which in turns calls _BCM
- _BCM sets the relevant bits in the AMD-specific structure and does a
  Notify (VGA, 0x81)
- again ACPI video module gets the nodification (in this case
  ACPI_VIDEO_NOTIFY_PROBE), re-enumerated and send KEY_SWITCHVIDEOMODE
- KDE seems this and muck with the screen configuration :(
- meanwhile the brightness notification is propagated, the hypothetical
  radeon driver does its magic to adjust the screen.

My first idea would be to make ACPI_VIDEO_NOTIFY_PROBE also call to the
acpi notifier chain, and allow the handlers to veto the key press (like
it's done for ACPI_VIDEO_NOTIFY_SWITCH).

Zhang Rui what do you think about this?

The other missing bit is how to actually change the brightness... Alex,
do you know what registers to poke?

My card is a:

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices [AMD] nee ATI Thames XT/GL [Radeon HD 600M Series] [1002:6840]

on a Toshiba L855.

Luca
