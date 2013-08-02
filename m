From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH] acpi: video: fix reversed indexed BQC
Date: Fri, 02 Aug 2013 10:03:41 +0800
Message-ID: <51FB137D.7070000@gmail.com>
References: <1375400042-989-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:47929 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab3HBCDS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Aug 2013 22:03:18 -0400
In-Reply-To: <1375400042-989-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 08/02/2013 07:34 AM, Felipe Contreras wrote:
> Commit 1a7c618 (ACPI video: support _BQC/_BCL/_BCM methods that use
> index values) assumed that bl->levels were not reverted, but at this
> point they already are, so there's no need to revert them yet again.

When acpi_video_bqc_value_to_level is called, bl->levels is not
reverted. Can you please point me the code path when it is called and
bl->levels were still reverted? I think we will need to fix that then.

-Aaron

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/acpi/video.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 0ec434d..b27c049 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -499,19 +499,10 @@ acpi_video_bqc_value_to_level(struct acpi_video_device *device,
>  {
>  	unsigned long long level;
>  
> -	if (device->brightness->flags._BQC_use_index) {
> -		/*
> -		 * _BQC returns an index that doesn't account for
> -		 * the first 2 items with special meaning, so we need
> -		 * to compensate for that by offsetting ourselves
> -		 */
> -		if (device->brightness->flags._BCL_reversed)
> -			bqc_value = device->brightness->count - 3 - bqc_value;
> -
> +	if (device->brightness->flags._BQC_use_index)
>  		level = device->brightness->levels[bqc_value + 2];
> -	} else {
> +	else
>  		level = bqc_value;
> -	}
>  
>  	level += bqc_offset_aml_bug_workaround;
>  
> 

