From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 4/4] output: Drop display output class support
Date: Wed, 19 Mar 2014 19:36:51 +0100
Message-ID: <20140319193651.3cd089dc@endymion.delvare>
References: <20140317154910.2016bf57@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36773 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbaCSSgz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2014 14:36:55 -0400
In-Reply-To: <20140317154910.2016bf57@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Zhang Rui <rui.zhang@intel.com>

On Mon, 17 Mar 2014 15:49:10 +0100, Jean Delvare wrote:
> It was only ever used by the ACPI video driver, and that only use case
> vanished over 3 years ago (see commit 677bd810, "ACPI video: remove
> output switching control".) So this is dead code and I guess we can
> remove it now.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/video/Kconfig        |    6 -
>  drivers/video/Makefile       |    2 
>  drivers/video/output.c       |  133 -------------------------------------------
>  include/linux/video_output.h |   57 ------------------
>  4 files changed, 198 deletions(-)
> (...)

Rafael, wait a minute. I just remembered that this last patch depends
on another clean-up patch of mine which is not upstream yet:
[PATCH 1/2] fujitsu-laptop: Drop unneeded include

List platform-driver-x86 doesn't seem to be archived anywhere so I
can't point you to it. I will resend the patch with you in Cc so that
you can include it in the series.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
