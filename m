From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 7/8] acpi: avoid using internal acpica structures
Date: Wed, 26 Nov 2008 13:31:35 +0300
Message-ID: <492D2587.9070408@gmail.com>
References: <1227668177.7702.99.camel@minggr.sh.intel.com>	 <492D0504.8010301@gmail.com> <1227692693.16339.8.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:3669 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYKZKbh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2008 05:31:37 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1364641ugf.37
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2008 02:31:35 -0800 (PST)
In-Reply-To: <1227692693.16339.8.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Lin Ming wrote:
> On Wed, 2008-11-26 at 16:12 +0800, Alexey Starikovskiy wrote:
>   
>> At least, this patch should be split in two -- for each file it touches.
>>     
>
> OK, will split it into two.
>
>   
>> Second, please don't return failure status from this function, as all 
>> functions under
>> the EC scope should be tried, and not only ones before first failure.
>>     
>
> How about below patch?
>
> ---
>  drivers/acpi/ec.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 591b4f6..99bff80 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -754,12 +754,20 @@ static acpi_status
>  acpi_ec_register_query_methods(acpi_handle handle, u32 level,
>  			       void *context, void **return_value)
>  {
> -	struct acpi_namespace_node *node = handle;
> +	char node_name[5];
> +	struct acpi_buffer buffer = { sizeof(node_name), node_name };
>  	struct acpi_ec *ec = context;
>  	int value = 0;
> -	if (sscanf(node->name.ascii, "_Q%x", &value) == 1) {
> -		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
> +	acpi_status status;
>   
> +
> +	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
>   
Merge the above two lines?
> +
> +	if (ACPI_SUCCESS(status)) {
> +		if (sscanf(node_name, "_Q%x", &value) == 1) {
>   
single if (ACPI_SUCCESS(status) && sscanf(node_name, "_Q%x", &value) == 1) ?
> +			acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
> +		}
>  	}
> +       
>  	return AE_OK;
>  }
>  
>
> Thanks for review,
> Lin Ming
>   
