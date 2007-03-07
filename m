From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/6] sony-laptop fix uninitialised variable
Date: Wed, 7 Mar 2007 03:06:06 -0500
Message-ID: <200703070306.07149.lenb@kernel.org>
References: <200703061029.l26ATgUA019125@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57711 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161305AbXCGIIA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 03:08:00 -0500
In-Reply-To: <200703061029.l26ATgUA019125@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

Applied.

thanks,
-Len

On Tuesday 06 March 2007 05:29, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/misc/sony-laptop.c: In function 'sony_acpi_add':
> drivers/misc/sony-laptop.c:456: warning: 'result' may be used uninitialized in this function
> 
> The compiler seems to actually be telling the truth this time.
> 
> Cc: Mattia Dongili <malattia@linux.it>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/misc/sony-laptop.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/misc/sony-laptop.c~sony-laptop-fix-uninitialised-variable drivers/misc/sony-laptop.c
> --- a/drivers/misc/sony-laptop.c~sony-laptop-fix-uninitialised-variable
> +++ a/drivers/misc/sony-laptop.c
> @@ -453,7 +453,7 @@ static int sony_acpi_resume(struct acpi_
>  static int sony_acpi_add(struct acpi_device *device)
>  {
>  	acpi_status status;
> -	int result;
> +	int result = 0;
>  	acpi_handle handle;
>  
>  	sony_acpi_acpi_device = device;
> _
> 
