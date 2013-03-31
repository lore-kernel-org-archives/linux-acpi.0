From: Artem Savkov <artem.savkov@gmail.com>
Subject: Re: [PATCH] acpi/video: lcd_get_level_current doen't return current
 level
Date: Sun, 31 Mar 2013 10:46:19 +0400
Message-ID: <20130331064619.GA11544@thinkpad.lan>
References: <1364648501-5127-1-git-send-email-artem.savkov@gmail.com>
 <3fb82299-bdb9-4842-bd55-f3b87d2d789e@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:46296 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab3CaGqW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Mar 2013 02:46:22 -0400
Content-Disposition: inline
In-Reply-To: <3fb82299-bdb9-4842-bd55-f3b87d2d789e@email.android.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Baumann <dannybaumann@web.de>
Cc: aaron.lu@intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 31, 2013 at 08:15:14AM +0200, Danny Baumann wrote:
> Artem Savkov <artem.savkov@gmail.com> schrieb:
> >acpi_video_device_lcd_get_level_current() called
> >acpi_video_bqc_value_to_level()
> >with "*level" as a second argument, resulting in level being returned
> >based on
> >initial input, not current brightness, breaking backlight controls.
> I don't think this change is correct. As level was passed as parameter into the evaluation of _BQC, *level contains the AML returned brightness level afterwards, so it's correct to use it as an input to acpi_video_bqc_value_to_level(). Actually, the whole point of acpi_video_device_lcd_get_level_current() is to update device->brightness->curr, so it doesn't make sense to me to use it in that function.
> 
> What's the exact problem this patch tries to solve?

I'm running a -next kernel on my laptop and couple of days ago keyboard
backlight controls stopped working: only 2 lower brightness levels. I've
debugged it a bit and found out that acpi_video_switch_brightness() calls
acpi_video_device_lcd_get_level_current() with level uninitialized and
always gets lowest posible value.

-- 
Regards,
Artem
