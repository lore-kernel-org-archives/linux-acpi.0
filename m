From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RESEND PATCH 1/2] backlight: always update the brightness
	when poking "brightness"
Date: Thu, 08 Jan 2009 14:12:41 +0000
Message-ID: <1231423961.6467.0.camel@dax.rpnet.com>
References: <1231396340.20746.80.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:61749 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbZAHOMp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2009 09:12:45 -0500
In-Reply-To: <1231396340.20746.80.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>


On Thu, 2009-01-08 at 14:32 +0800, Zhang Rui wrote:
> bd->props.brightness doesn't reflect the actual backlight level.
> Always invoke backlight_update_status when users want to change
> the backlight.
> 
> For setups where brightness change is an expensive operation,
> this could be done in the driver rather than the core.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12249
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Queued in the backlight tree, thanks.

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre

