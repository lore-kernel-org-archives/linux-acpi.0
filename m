From: Nicolas Kaiser <nikai@nikai.net>
Subject: Re: [PATCH] drivers/acpi/utils.c: Fixed coding style issues
Date: Thu, 21 Apr 2011 10:28:15 +0200
Message-ID: <20110421102815.5abf133e@absol.kitzblitz>
References: <1303341624.11397.2.camel@ks-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:55328 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752966Ab1DUIcd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Apr 2011 04:32:33 -0400
In-Reply-To: <1303341624.11397.2.camel@ks-ubuntu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karthigan Srinivasan <karthigan.srinivasan@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

* Karthigan Srinivasan <karthigan.srinivasan@hp.com>:
> Fixed brace and comment coding style issues in code.
> 
> Signed-off-by: Karthigan Srinivasan <karthigan.srinivasan@hp.com>
> ---
>  drivers/acpi/utils.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index b002a47..2cf81a1 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -99,9 +99,9 @@ acpi_extract_package(union acpi_object *package,
>  
>  		union acpi_object *element = &(package->package.elements[i]);
>  
> -		if (!element) {
> +		if (!element) 
                             ^
You are introducing trailing whitespace.

>  			return AE_BAD_DATA;
> -		}
> +		
   ^^^^^^^^^^^^^
For every pair of braces you clean away, you're adding
two new coding style issues.

Best regards,
Nicolas Kaiser
