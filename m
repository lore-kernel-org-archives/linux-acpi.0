From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking
	"brightness"
Date: Tue, 30 Dec 2008 10:34:10 +0000
Message-ID: <1230633250.5328.8.camel@dax.rpnet.com>
References: <1230088058.562.219.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:64108 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbYL3LGJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 06:06:09 -0500
In-Reply-To: <1230088058.562.219.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 2008-12-24 at 11:07 +0800, Zhang Rui wrote:
> bd->props.brightness is a cached value.
> the current code has some potential problems when poking the
> backlight I/F.
> 
> For example,
> 1. set the brightness level to 5 via sysfs I/F
> 2. set the backlight to another level via the procfs,
> 3. setting it back to 5 doesn't work because bd->props.brightness
> is still 5.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12249

The root of the problem here is that there are two interfaces
controlling the same piece of hardware. Personally, I'd like to see the
proc interfaces to backlights depreacated but we do need to make them
work I guess. The real bug looks like the proc interface should update
props.brightness for that hardware...

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre

