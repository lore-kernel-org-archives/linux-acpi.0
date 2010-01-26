From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Question about ACPI Video
Date: Tue, 26 Jan 2010 08:58:04 +0800
Message-ID: <1264467484.22448.310.camel@rzhang1-desktop>
References: <d292941c1001250145o43dc2785p6cdc7d2ff6d47e76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39327 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632Ab0AZA73 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jan 2010 19:59:29 -0500
In-Reply-To: <d292941c1001250145o43dc2785p6cdc7d2ff6d47e76@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: luke lin <luke.lin1105@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Luke lin <luke1105@gmail.com>

On Mon, 2010-01-25 at 17:45 +0800, luke lin wrote:
> Hi all,
> 
> I read the drivers/acpi/video.c:
> 
> 895         result = acpi_video_device_lcd_set_level(device, max_level);
> 896         if (result)
> 897                 goto out_free_levels;
> 898
> 899         result = acpi_video_device_lcd_get_level_current(device, &level);
> 900         if (result)
> 901                 goto out_free_levels;
> 902
> 903         br->flags._BQC_use_index = (level == max_level ? 0 : 1);
> 904
> 905         if (!br->flags._BQC_use_index) {
> 912                 for (i = 2; i < br->count; i++)
> 913                         if (level_old == br->levels[i])
> 914                                 level = level_old;
> 915                 goto set_level;
> 916         }
> why after level == max_level, it will still need set_level again?
> is this a bug, or it is necessary.
> 
Because setting the backlight to max_level is just to check if _BQC uses
indexed value. We need to set the backlight back after this is done.

thanks,
rui


> thx
> luke
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


