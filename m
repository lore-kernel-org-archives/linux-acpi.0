From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 2/2] video: mark "actual_brightness" deprecated
Date: Tue, 30 Dec 2008 10:37:17 +0000
Message-ID: <1230633437.5328.13.camel@dax.rpnet.com>
References: <1230088061.562.220.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:64108 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbYL3LGH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 06:06:07 -0500
In-Reply-To: <1230088061.562.220.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>


On Wed, 2008-12-24 at 11:07 +0800, Zhang Rui wrote:
> /sys/class/backlight/.../brightness returns a cached value,
> which confuses a lot of users.
> 
> Make the "brightness" reflect the actual backlight levels,
> and mark /sys/class/backlight/.../brightness as depreacated
> in this patch.

This isn't an acceptable approach I'm afraid. We have some hardware
which needs limiting of the backlight brightness in cases of low battery
for example. "brightness" is the user requested value,
"actual_brightness" is the one that is actually active. This also makes
it clear when things like console blanking are active since the actual
value is 0 but brightness preserves the user requested value.

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre

