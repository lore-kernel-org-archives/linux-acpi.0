From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] acpi: add utility to test for device dma coherency
Date: Wed, 10 Sep 2014 02:39:17 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880266DC80@SHSMSX101.ccr.corp.intel.com>
References: <1410296278-1244-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13474 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbaIJCoB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 22:44:01 -0400
In-Reply-To: <1410296278-1244-1-git-send-email-msalter@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Mark Salter [mailto:msalter@redhat.com]
> Sent: Wednesday, September 10, 2014 4:58 AM
> 
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
> +			*val = data;
> +			break;
> +		}
> +		status = acpi_get_parent(handle, &handle);

Why do you need such a loop?
In ACPI specification 5.3 ACPI Namespace, there is such a statement:
Quote: "A name is located by finding the matching name in the current namespace, and then in the parent namespace."
This searching rule should have already been implemented by ACPICA.

Thanks and best regards
-Lv

> +	} while (!ACPI_FAILURE(status));
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(acpi_check_coherency);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index bcfd808..b97f09d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -68,6 +68,8 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs);
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
>  			int rev, int func, union acpi_object *argv4);
> 
> +acpi_status acpi_check_coherency(acpi_handle handle, int *val);
> +
>  static inline union acpi_object *
>  acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, int rev, int func,
>  			union acpi_object *argv4, acpi_object_type type)
> --
> 1.8.3.1

