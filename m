From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Tables: Restore old behavor to favor 32-bit FADT addresses.
Date: Mon, 26 May 2014 15:06:12 +0200
Message-ID: <4631514.kRXiOV1YTi@vostro.rjw.lan>
References: <38907770.bupFXhytsS@vostro.rjw.lan> <6018e562465c35d11cf98f181baedf3b8483e812.1399970899.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64217 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751651AbaEZMtJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 May 2014 08:49:09 -0400
In-Reply-To: <6018e562465c35d11cf98f181baedf3b8483e812.1399970899.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Lv,

There was a merge conflict with the new ACPICA material queued up for 3.16
related to this.

Can you please have a look at the linux-next branch in my tree and see if
the ACPICA material in there is in a good shape?

Rafael


On Tuesday, May 13, 2014 04:50:30 PM Lv Zheng wrote:
> We need to find a smarter way to switch to 64-bit FADT addresses according
> to the bug report.  This patch reverts Linux to the original behavior.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=74021
> Reported-by: Oswald Buddenhagen <ossi@kde.org>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Tested-by: Oswald Buddenhagen <ossi@kde.org>
> Cc: <stable@vger.kernel.org> # 3.14.x: 0249ed24: ACPICA: Add option to favor 32-bit FADT addresses
> ---
>  include/acpi/acpixf.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 4e3044c..b66b6a8 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -190,7 +190,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
>   * some machines have been found to have a corrupted non-zero 64-bit
>   * address. Default is FALSE, do not favor the 32-bit addresses.
>   */
> -ACPI_INIT_GLOBAL(u8, acpi_gbl_use32_bit_fadt_addresses, FALSE);
> +ACPI_INIT_GLOBAL(u8, acpi_gbl_use32_bit_fadt_addresses, TRUE);
>  
>  /*
>   * Optionally truncate I/O addresses to 16 bits. Provides compatibility
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
