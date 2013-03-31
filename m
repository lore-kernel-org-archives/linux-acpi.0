From: Danny Baumann <dannybaumann@web.de>
Subject: Re: [PATCH] acpi/video: lcd_get_level_current doen't return current level
Date: Sun, 31 Mar 2013 08:15:14 +0200
Message-ID: <3fb82299-bdb9-4842-bd55-f3b87d2d789e@email.android.com>
References: <1364648501-5127-1-git-send-email-artem.savkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364648501-5127-1-git-send-email-artem.savkov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Savkov <artem.savkov@gmail.com>
Cc: aaron.lu@intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



Artem Savkov <artem.savkov@gmail.com> schrieb:

>acpi_video_device_lcd_get_level_current() called
>acpi_video_bqc_value_to_level()
>with "*level" as a second argument, resulting in level being returned
>based on
>initial input, not current brightness, breaking backlight controls.

I don't think this change is correct. As level was passed as parameter into the evaluation of _BQC, *level contains the AML returned brightness level afterwards, so it's correct to use it as an input to acpi_video_bqc_value_to_level(). Actually, the whole point of acpi_video_device_lcd_get_level_current() is to update device->brightness->curr, so it doesn't make sense to me to use it in that function.

What's the exact problem this patch tries to solve?

Regards,

Danny
Hi,
