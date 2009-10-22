From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH] acpi_power_meter: Don't leak ACPI error
 codes  to userspace
Date: Thu, 22 Oct 2009 09:27:53 +0200
Message-ID: <20091022092753.1b4b9706@hyperion.delvare>
References: <20091022010137.GB21723@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poutre.nerim.net ([62.4.16.124]:61938 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbZJVH1u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Oct 2009 03:27:50 -0400
In-Reply-To: <20091022010137.GB21723@tux1.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: djwong@us.ibm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 21 Oct 2009 18:01:37 -0700, Darrick J. Wong wrote:
> acpi-power-meter: Don't leak ACPI error codes to userspace
> 
> If the ACPI methods return an error code, we must return -EINVAL to userspace
> to flag the error.  Right now we pass the (positive) number right through,
> which causes echo to keep writing bogus values.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> 
>  drivers/acpi/power_meter.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
> index e6bfd77..2ef7030 100644
> --- a/drivers/acpi/power_meter.c
> +++ b/drivers/acpi/power_meter.c
> @@ -294,7 +294,11 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
>  		return -EINVAL;
>  	}
>  
> -	return data;
> +	/* _PTP returns 0 on success, nonzero otherwise */
> +	if (data)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,

-- 
Jean Delvare
