From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: remove duplicate u8 typedef
Date: Wed, 29 Apr 2015 02:43:31 +0200
Message-ID: <1624281.lNzTEna4Ru@vostro.rjw.lan>
References: <1430232844-11018-1-git-send-email-olaf@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54524 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1031083AbbD2ASj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 20:18:39 -0400
In-Reply-To: <1430232844-11018-1-git-send-email-olaf@aepfle.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>, Lv Zheng <lv.zheng@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

On Tuesday, April 28, 2015 04:54:04 PM Olaf Hering wrote:
> During commit e252652fb2664d42de19f933aa3688bbc470de3f ("ACPICA:
> acpidump: Remove integer types translation protection.") two 'unsigned
> char' types got converted to 'u8'.
> 
> The result does not compile with gcc-4.5, it can not cope with duplicate
> typedefs.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Applied, thanks!

Lv, can you please see if that's an upstream issue too?

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
