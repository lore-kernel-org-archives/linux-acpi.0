From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [PATCH v3 0/4] Fix Win8 backlight issue
Date: Wed, 25 Sep 2013 11:09:04 +0200
Message-ID: <CADDKRnDn1YqBF_W6z6LRWCxtCWb-cT6VMEakv-9rP2-bf5-s0w@mail.gmail.com>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:37889 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab3IYJJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 05:09:05 -0400
In-Reply-To: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, inux-kernel@vger.kernel.org

2013/9/24 Aaron Lu <aaron.lu@intel.com>:
> v3:
> 1 Add a new patch 4/4 to fix some problems in thinkpad-acpi module;
> 2 Remove unnecessary function acpi_video_unregister introduced in
>   patch 2/3 as pointed out by Jani Nikula.
>
> v2:
> v1 has the subject of "Rework ACPI video driver" and is posted here:
> http://lkml.org/lkml/2013/9/9/74
> Since the objective is really to fix Win8 backlight issues, I changed
> the subject in this version, sorry about that.
>
> This patchset has three patches, the first introduced a new API named
> backlight_device_registered in backlight layer that can be used for
> backlight interface provider module to check if a specific type backl=
ight
> interface has been registered, see changelog for patch 1/3 for detail=
s.
> Then patch 2/3 does the cleanup to sepeate the backlight control and
> event delivery functionality in the ACPI video module and patch 3/3
> solves some Win8 backlight control problems by avoiding register ACPI
> video's backlight interface if:
> 1 Kernel cmdline option acpi_backlight=3Dvideo is not given;
> 2 This is a Win8 system;
> 3 Native backlight control interface exists.
>
> Technically, patch 2/3 is not required to fix the issue here. So if y=
ou
> think it is not necessary, I can remove it from the series.
>
> Aaron Lu (4):
>   backlight: introduce backlight_device_registered
>   ACPI / video: seperate backlight control and event interface
>   ACPI / video: Do not register backlight if win8 and native interfac=
e
>     exists
>   thinkpad-acpi: fix handle locate for video and query of _BCL
>
>  drivers/acpi/internal.h              |   5 +-
>  drivers/acpi/video.c                 | 442 ++++++++++++++++++++-----=
----------
>  drivers/acpi/video_detect.c          |  14 +-
>  drivers/platform/x86/thinkpad_acpi.c |  31 ++-
>  drivers/video/backlight/backlight.c  |  31 +++
>  include/acpi/video.h                 |   2 +
>  include/linux/backlight.h            |   4 +
>  7 files changed, 324 insertions(+), 205 deletions(-)
>
> --
> 1.8.4.12.g2ea3df6
>

Backlight can't be modified with this patch set -  neither with
function keys nor
with the gui. It is a step backward to v3.11-rc1

Video driver: i915
=46UJITSU LIFEBOOK AH532/FJNBB1C, BIOS Version 1.09 05/22/2012

acpi_backlight=3Dvideo works.

J=C3=B6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
