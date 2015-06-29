From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 1/1] ACPI/resource.c: Fixing memory leak for reg
Date: Mon, 29 Jun 2015 15:13:42 +0800
Message-ID: <5590F026.1020202@linux.intel.com>
References: <1435559640-18059-1-git-send-email-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8649 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbbF2HNq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jun 2015 03:13:46 -0400
In-Reply-To: <1435559640-18059-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maninder Singh <maninder1.s@samsung.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com

On 2015/6/29 14:34, Maninder Singh wrote:
> static analysis gives memory leak error for reg:-
> [drivers/acpi/resource.c:663]: (error) Memory leak: reg
> 
> Thus to prevent this allocate memory for reg after
> request_range error checking.
Hi Maninder,
	Seems it would be better to release the allocated memory
instead of reorder the code in case of failure. Otherwise the
resource region reserved by request_range() will get lost and
causes inconsistent view.
Thanks!
Gerry

> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> ---
>  drivers/acpi/resource.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index fcb7807..f942b70 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -655,14 +655,14 @@ static int add_region_before(u64 start, u64 end, u8 space_id,
>  	struct reserved_region *reg;
>  	int error;
>  
> -	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
> -	if (!reg)
> -		return -ENOMEM;
> -
>  	error = request_range(start, end, space_id, flags, desc);
>  	if (error)
>  		return error;
>  
> +	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
>  	reg->start = start;
>  	reg->end = end;
>  	list_add_tail(&reg->node, head);
> 
