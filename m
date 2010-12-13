From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: Make sure the FADT is at least rev 2 before
 using the reset register
Date: Mon, 13 Dec 2010 08:16:36 +0800
Message-ID: <1292199396.1715.143.camel@rui>
References: <1292003871-13979-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292003871-13979-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2010-12-11 at 01:57 +0800, Matthew Garrett wrote:
> The reset register was only introduced with version 2 of the FADT, so we
> should check that the FADT revision before trusting its contents.
> 
does the current code break anything?
I'm curious about how you found this bug. :)

thanks,
rui

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/reboot.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index 4870aaa..a6c77e8b 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -15,6 +15,11 @@ void acpi_reboot(void)
>  
>  	rr = &acpi_gbl_FADT.reset_register;
>  
> +	/* ACPI reset register was only introduced with v2 of the FADT */
> +
> +	if (acpi_gbl_FADT.header.revision < 2)
> +		return;
> +
>  	/* Is the reset register supported? The spec says we should be
>  	 * checking the bit width and bit offset, but Windows ignores
>  	 * these fields */
