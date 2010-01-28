From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Question about ACPI Video
Date: Thu, 28 Jan 2010 15:04:23 +0800
Message-ID: <1264662263.9599.8.camel@rzhang1-desktop>
References: <d292941c1001250145o43dc2785p6cdc7d2ff6d47e76@mail.gmail.com>
	 <1264467484.22448.310.camel@rzhang1-desktop>
	 <ff05f3d01001271002o19135ab7g10b7118be8d85976@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49158 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab0A1HGE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jan 2010 02:06:04 -0500
In-Reply-To: <ff05f3d01001271002o19135ab7g10b7118be8d85976@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Edward Shao <laface.tw@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Luke lin <luke1105@gmail.com>

On Thu, 2010-01-28 at 02:02 +0800, Edward Shao wrote:
> On Tue, Jan 26, 2010 at 8:58 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> > On Mon, 2010-01-25 at 17:45 +0800, luke lin wrote:
> >> Hi all,
> >>
> >> I read the drivers/acpi/video.c:
> >>
> >> 895         result = acpi_video_device_lcd_set_level(device, max_level);
> >> 896         if (result)
> >> 897                 goto out_free_levels;
> >> 898
> >> 899         result = acpi_video_device_lcd_get_level_current(device, &level);
> >> 900         if (result)
> >> 901                 goto out_free_levels;
> >> 902
> >> 903         br->flags._BQC_use_index = (level == max_level ? 0 : 1);
> >> 904
> >> 905         if (!br->flags._BQC_use_index) {
> >> 912                 for (i = 2; i < br->count; i++)
> >> 913                         if (level_old == br->levels[i])
> >> 914                                 level = level_old;
> >> 915                 goto set_level;
> >> 916         }
> >> why after level == max_level, it will still need set_level again?
> >> is this a bug, or it is necessary.
> >>
> > Because setting the backlight to max_level is just to check if _BQC uses
> > indexed value. We need to set the backlight back after this is done.
> >
> > thanks,
> > rui
> 
> Hi~
> 
> I'm wondering why check (level == max_level) can make sure if _BQC
> uses indexed value?
> Is it possible that both level and max_level is indexed value?
> 
If both _BQC and _BCL uses indexed value, then we don't need to treat
them as indexed value. :p

for example,
_BCL returns {0, 1, 2, 3, 4, 5, ... },  the index of level n is n.
If _BQC uses indexed value, it should returns n for level n.
so this equals a BIOS that both _BCL and _BQC use percentage values.

thanks,
rui

> Thank you very much.
> 


