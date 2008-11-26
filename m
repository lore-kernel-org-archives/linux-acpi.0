From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: acpi_evaluate_integer broken by design
Date: Wed, 26 Nov 2008 13:20:50 -0800
Message-ID: <20081126132050.cecb170b.akpm@linux-foundation.org>
References: <20081125110508.GA1943@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51891 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119AbYKZVVX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Nov 2008 16:21:23 -0500
In-Reply-To: <20081125110508.GA1943@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

On Tue, 25 Nov 2008 12:05:08 +0100
Pavel Machek <pavel@suse.cz> wrote:

> Subject: acpi_evaluate_integer broken by design

Please don't give patches daft and not very meaningful titles.  It just
means that someone else has to invent a useful title and then we get
the same patch floating about with two different titles.

> Date: 	Tue, 25 Nov 2008 12:05:08 +0100
> Sender: linux-kernel-owner@vger.kernel.org
> User-Agent: Mutt/1.5.18 (2008-05-17)
>
> 
> Now I know why I had strange "scheduling in atomic" problems:
> acpi_evaluate_integer() does malloc(..., irqs_disabled() ? GFP_ATOMIC
> : GFP_KERNEL)... which is (of course) broken.

That is kinda weird.  When did this all start happening?

> There's no way to reliably tell if we need GFP_ATOMIC or not from
> code, this one for example fails to detect spinlocks held.
> 
> Fortunately, allocation seems small enough to be done on stack.

It's 24 bytes in an x86_64 allmodconfig build.  Clearly it should be a
local.

> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index e827be3..f844941 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -259,34 +259,26 @@ acpi_evaluate_integer(acpi_handle handle
>  		      struct acpi_object_list *arguments, unsigned long long *data)
>  {
>  	acpi_status status = AE_OK;
> -	union acpi_object *element;
> +	union acpi_object element;
>  	struct acpi_buffer buffer = { 0, NULL };
>  
> -
>  	if (!data)
>  		return AE_BAD_PARAMETER;
>  
> -	element = kzalloc(sizeof(union acpi_object), irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
> -	if (!element)
> -		return AE_NO_MEMORY;
> -
>  	buffer.length = sizeof(union acpi_object);
> -	buffer.pointer = element;
> +	buffer.pointer = &element;
>  	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
>  	if (ACPI_FAILURE(status)) {
>  		acpi_util_eval_error(handle, pathname, status);
> -		kfree(element);
>  		return status;
>  	}
>  
> -	if (element->type != ACPI_TYPE_INTEGER) {
> +	if (element.type != ACPI_TYPE_INTEGER) {
>  		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
> -		kfree(element);
>  		return AE_BAD_DATA;
>  	}
>  
> -	*data = element->integer.value;
> -	kfree(element);
> +	*data = element.integer.value;
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%llu]\n", *data));

Len, this looks like 2.6.28 material.  But given the poor quality of
the changelog it is hard to be sure about this.  Why isn't everyone
seeing these warnings?  What did Pavel do to provoke these alleged
warnings?  Nobody knows...



