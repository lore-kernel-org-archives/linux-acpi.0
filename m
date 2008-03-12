From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: Set flag DOCK_UNDOCKING when triggered via sysfs
Date: Tue, 11 Mar 2008 22:35:22 -0700
Message-ID: <20080311223522.3326b6ee.akpm@linux-foundation.org>
References: <20080312000727.GB4089@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47035 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751206AbYCLFgJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 01:36:09 -0400
In-Reply-To: <20080312000727.GB4089@homac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, stable@kernel.org

On Wed, 12 Mar 2008 01:07:27 +0100 Holger Macht <hmacht@suse.de> wrote:

> begin_undock() is only called when triggered via a acpi notify handler
> (pressing the undock button on the dock station), but complete_undock() is
> always called after the eject. So if a undock is triggered through a sysfs
> write, the flag DOCK_UNDOCKING has to be set for the dock station,
> too. Otherwise this will freeze the system hard.
> 

We prefer not to make systems freeze hard.

> ---
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 307cef6..fa44fb9 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -710,6 +710,7 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
>  	if (!count)
>  		return -EINVAL;
>  
> +	begin_undock(dock_station);
>  	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
>  	return ret ? ret: count;
>  }

I assume that this is needed in 2.6.24.x as well?
