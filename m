From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/2] ACPICA: acpi_ds_resolve_package_element: Use proper
 status when logging exception
Date: Wed, 17 Jan 2018 21:54:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B754906A@ORSMSX110.amr.corp.intel.com>
References: <20180112113707.3833-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45804 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753062AbeAQVyL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jan 2018 16:54:11 -0500
In-Reply-To: <20180112113707.3833-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Schmauss, Erik" <erik.schmauss@intel.com>

We are working on this file right now, thanks.
Bob


> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Sent: Friday, January 12, 2018 3:37 AM
> To: Len Brown <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>;
> Zheng, Lv <lv.zheng@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;
> devel@acpica.org
> Subject: [PATCH 1/2] ACPICA: acpi_ds_resolve_package_element: Use proper
> status when logging exception
> 
> Do not override the status which causes us to call acpi_exception with
> the status returned by the acpi_ns_externalize_name call we do to get a
> name to log.
> 
> Related: https://bugzilla.kernel.org/show_bug.cgi?id=198167
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpica/dspkginit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/dspkginit.c
> b/drivers/acpi/acpica/dspkginit.c index 6d487edfe2de..cddbbed2f344
> 100644
> --- a/drivers/acpi/acpica/dspkginit.c
> +++ b/drivers/acpi/acpica/dspkginit.c
> @@ -372,9 +372,9 @@ acpi_ds_resolve_package_element(union
> acpi_operand_object **element_ptr)
>  				ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
>  				NULL, &resolved_node);
>  	if (ACPI_FAILURE(status)) {
> -		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
> -						  (char *)element->reference.
> -						  aml, NULL, &external_path);
> +		acpi_ns_externalize_name(ACPI_UINT32_MAX,
> +					 (char *)element->reference.aml, NULL,
> +					 &external_path);
> 
>  		ACPI_EXCEPTION((AE_INFO, status,
>  				"Could not find/resolve named package element: %s",
> --
> 2.14.3

