From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: Divergence: Remove redundant definitions.
Date: Fri, 08 May 2015 23:10:42 +0200
Message-ID: <2141885.RRIlZlr0YX@vostro.rjw.lan>
References: <34f53a89dcef23c362071f5ee48038494d940e9d.1430880973.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51322 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753678AbbEHUph (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2015 16:45:37 -0400
In-Reply-To: <34f53a89dcef23c362071f5ee48038494d940e9d.1430880973.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday, May 06, 2015 10:57:53 AM Lv Zheng wrote:
> There are two same "define"s in the actypes.h for ACPI_USE_NATIVE_DIVIDE,
> this patch removes one of them as it is useless and is not in the ACPICA
> upstream. It is likely that the useless block is there because of the
> issues in the old ACPICA release process.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Queued up for 4.2, thanks!

> ---
>  include/acpi/actypes.h |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 792c1a0..5298976b 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -472,11 +472,6 @@ typedef u8 acpi_owner_id;
>  
>  #define ACPI_INTEGER_BIT_SIZE           64
>  #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
> -
> -#if ACPI_MACHINE_WIDTH == 64
> -#define ACPI_USE_NATIVE_DIVIDE	/* Use compiler native 64-bit divide */
> -#endif
> -
>  #define ACPI_MAX64_DECIMAL_DIGITS       20
>  #define ACPI_MAX32_DECIMAL_DIGITS       10
>  #define ACPI_MAX16_DECIMAL_DIGITS        5
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
