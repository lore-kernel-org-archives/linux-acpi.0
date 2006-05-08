From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [patch] fix pciehp compile issue when CONFIG_ACPI is not enabled.
Date: Mon, 8 May 2006 23:24:31 +0400
Message-ID: <20060508192431.GB7235@mipter.zuzino.mipt.ru>
References: <1147114470.3094.14.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:9867 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751294AbWEHT0D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 May 2006 15:26:03 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1035590nfe
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2006 12:26:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1147114470.3094.14.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, greg@kroah.com

On Mon, May 08, 2006 at 11:54:30AM -0700, Kristen Accardi wrote:
> Fix compile error when CONFIG_ACPI is not defined.

> --- 2.6-git.orig/include/acpi/actypes.h
> +++ 2.6-git/include/acpi/actypes.h
> @@ -348,6 +348,7 @@ struct acpi_pointer {
>   * Mescellaneous types
>   */
>  typedef u32 acpi_status;	/* All ACPI Exceptions */
> +#define acpi_status acpi_status
>  typedef u32 acpi_name;		/* 4-byte ACPI name */
>  typedef char *acpi_string;	/* Null terminated ASCII string */
>  typedef void *acpi_handle;	/* Actually a ptr to a NS Node */

The following in include/linux/pci-acpi.h is ugly

	#if !defined(acpi_status)
	typedef u32             acpi_status;
	#define AE_ERROR        (acpi_status) (0x0001)
	#endif

but you're adding more of it.

