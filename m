From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/2] WMI based driver fixes for 2.6.251 & 2
Date: Sat, 9 Feb 2008 03:30:44 -0500
Message-ID: <200802090330.44408.lenb@kernel.org>
References: <20080208235137.2786.80503.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57745 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbYBIIbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 9 Feb 2008 03:31:03 -0500
In-Reply-To: <20080208235137.2786.80503.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

1 & 2 applied,

thanks,
-len

On Friday 08 February 2008 18:51, Carlos Corbacho wrote:
> The following series is two small fixes to the WMI based drivers:
> 
> 1) Make tc1100-wmi depend on EXPERIMENTAL, since its code base is completely
> untested. (This is just a resend of the patch I sent earlier today).
> 
> 2) Fix setting the backlight on acer-wmi for older Acer laptops.
> 
> These are both candidates for 2.6.25, but they can wait until -rc1 if need
> be.
> 
> -Carlos
> ---
> 
> Carlos Corbacho (2):
>       acer-wmi: Fix backlight on AMW0 (V1) laptops
>       tc1100-wmi: Mark as experimental
> 
> 
>  drivers/misc/Kconfig    |    3 ++-
>  drivers/misc/acer-wmi.c |    6 ++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
