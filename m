From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 11:13:50 +0100
Message-ID: <1213956830.5049.10.camel@dax.rpnet.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
	 <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:45382 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYFTLCh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 07:02:37 -0400
In-Reply-To: <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>


On Fri, 2008-06-20 at 03:43 -0400, Len Brown wrote:
> From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> 
> This is driver for Compal Laptop: FL90/IFL90, based on MSI driver.
> 
> This driver exports a few files in /sys/devices/platform/compal-laptop/:
>  lcd_level - screen brightness: contains a single integer in the range 0..7 (rw)
>  wlan - wlan subsystem state: contains 0 or 1 (rw)
>  bluetooth - bluetooth subsystem state: contains 0 or 1 (rw)
>  raw - raw value taken from embedded controller register (ro)
> 
> In addition to these platform device attributes the driver registers itself
> in the Linux backlight control subsystem and is available to userspace under
> /sys/class/backlight/compal-laptop/.
> 
> Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Alexey Starikovskiy <aystarik@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Len Brown <len.brown@intel.com>

There was an update to this patch which dropped the lcd_level attribute
which might as well be applied before merging since the backlight class
handles all of that and there is no point in duplicating it.

Cheers,

Richard

