From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: add utility to test for device dma coherency
Date: Tue, 09 Sep 2014 23:49:41 +0200
Message-ID: <2333063.oAgzS6NIuV@vostro.rjw.lan>
References: <1410296278-1244-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61272 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751268AbaIIVaP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 17:30:15 -0400
In-Reply-To: <1410296278-1244-1-git-send-email-msalter@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

On Tuesday, September 09, 2014 04:57:58 PM Mark Salter wrote:
> ACPI 5.1 adds a _CCA object to indicate memory coherency
> of a bus master device. It is an integer with zero meaning
> non-coherent and one meaning coherent. This attribute may
> be inherited from a parent device. It may also be missing
> entirely, in which case, an architecture-specific default
> is assumed.
> 
> This patch adds a utility function to parse a device handle
> (and its parents) for a _CCA object and return the coherency
> attribute if found.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  drivers/acpi/utils.c    | 26 ++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 07c8c5a..aec9656 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -698,3 +698,29 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
>  	return false;
>  }
>  EXPORT_SYMBOL(acpi_check_dsm);
> +
> +/**
> + * acpi_check_coherency - check for memory coherency of a device
> + * @handle: ACPI device handle
> + * @val:    Pointer to returned value
> + *
> + * Search a device and its parents for a _CCA method and return
> + * its value.
> + */
> +acpi_status acpi_check_coherency(acpi_handle handle, int *val)
> +{
> +	unsigned long long data;
> +	acpi_status status;
> +
> +	do {
> +		status = acpi_evaluate_integer(handle, "_CCA", NULL, &data);
> +		if (!ACPI_FAILURE(status)) {

We have an ACPI_SUCCESS() macro for that.

> +			*val = data;
> +			break;
> +		}
> +		status = acpi_get_parent(handle, &handle);
> +	} while (!ACPI_FAILURE(status));
> +

And here.

Anyway, how do you think this routine will be used?  Do you have any
particular use cases in mind?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
