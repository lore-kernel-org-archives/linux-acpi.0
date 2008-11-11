From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix argument type for acpi_evaluate_integer in
 acpi_get_physical_pci_device
Date: Tue, 11 Nov 2008 14:24:39 -0800
Message-ID: <20081111142439.b804bdd6.akpm@linux-foundation.org>
References: <200811031216.15690.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38161 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753317AbYKKWZN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Nov 2008 17:25:13 -0500
In-Reply-To: <200811031216.15690.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 3 Nov 2008 12:16:13 +0300
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> Subject: [PATCH] Fix argument type for acpi_evaluate_integer in acpi_get_physical_pci_device
> From: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> CC      drivers/acpi/glue.o
> /home/bor/src/linux-git/drivers/acpi/glue.c: In function 'acpi_get_physical_pci_device':
> /home/bor/src/linux-git/drivers/acpi/glue.c:157: warning: passing argument 4 of 'acpi_evaluate_integer' from incompatible pointer type
> 
> acpi_evaluate_integer takes pointer to unsigned long long as fourth argument
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> 
> ---
> 
>  drivers/acpi/glue.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 98c9c76..436c8a3 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -150,7 +150,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
>  struct device *acpi_get_physical_pci_device(acpi_handle handle)
>  {
>  	struct device *dev;
> -	long device_id;
> +	unsigned long long device_id;
>  	acpi_status status;
>  
>  	status =

Someone has gone and changed this to `long long', which is still wrong
but which (surprisingly) doesn't seem to generate a compilation
warning.

