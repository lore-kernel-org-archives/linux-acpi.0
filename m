From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: remove duplicate u8 typedef
Date: Wed, 29 Apr 2015 00:27:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270FB03@SHSMSX101.ccr.corp.intel.com>
References: <1430232844-11018-1-git-send-email-olaf@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60946 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031166AbbD2Aao convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 20:30:44 -0400
In-Reply-To: <1430232844-11018-1-git-send-email-olaf@aepfle.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

> From: Olaf Hering [mailto:olaf@aepfle.de]
> Sent: Tuesday, April 28, 2015 10:54 PM
> Subject: [PATCH] ACPICA: remove duplicate u8 typedef
> 
> During commit e252652fb2664d42de19f933aa3688bbc470de3f ("ACPICA:
> acpidump: Remove integer types translation protection.") two 'unsigned
> char' types got converted to 'u8'.
> 
> The result does not compile with gcc-4.5, it can not cope with duplicate
> typedefs.

The 2 u8 typedefs actually are different types in ACPICA.
If this really causes problem, I'm OK with deleting it from Linux side.
We'll take care of introducing a new type to eliminate such "divergence".

Thanks
-Lv

> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  include/acpi/actypes.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index f5ca0e9..1c3002e 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -124,7 +124,6 @@
>  #ifndef ACPI_USE_SYSTEM_INTTYPES
> 
>  typedef unsigned char u8;
> -typedef unsigned char u8;
>  typedef unsigned short u16;
>  typedef short s16;
>  typedef COMPILER_DEPENDENT_UINT64 u64;
