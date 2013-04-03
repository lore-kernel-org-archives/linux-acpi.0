From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] acpi/bgrt: Don't let users configure BGRT on non X86
 systems
Date: Wed, 03 Apr 2013 02:10:29 +0200
Message-ID: <515B7375.9000502@intel.com>
References: <0234310@agluck-desk.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26907 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756197Ab3DCAKp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 20:10:45 -0400
In-Reply-To: <0234310@agluck-desk.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>

On 3/29/2013 11:30 PM, Luck, Tony wrote:
> Fengguang Wu's 0-Day kernel build testing backend found the
> following build error for an allmodconfig build on ia64:
>
>     drivers/built-in.o: In function `show_yoffset':
>>> bgrt.c:(.text+0xe5a71): undefined reference to `bgrt_tab'
>>> bgrt.c:(.text+0xe5a91): undefined reference to `bgrt_tab'
>     drivers/built-in.o: In function `show_xoffset':
>>> bgrt.c:(.text+0xe5b51): undefined reference to `bgrt_tab'
>>> bgrt.c:(.text+0xe5b71): undefined reference to `bgrt_tab'
>     drivers/built-in.o: In function `show_type':
>>> bgrt.c:(.text+0xe5c31): undefined reference to `bgrt_tab'
>     drivers/built-in.o:bgrt.c:(.text+0xe5c51): more undefined references to `bgrt_tab' follow
>     drivers/built-in.o: In function `bgrt_init':
>     bgrt.c:(.init.text+0x8931): undefined reference to `bgrt_image'
>     bgrt.c:(.init.text+0x8932): undefined reference to `bgrt_image_size'
>     bgrt.c:(.init.text+0x8950): undefined reference to `bgrt_image'
>     bgrt.c:(.init.text+0x8960): undefined reference to `bgrt_image_size'
>
> The problem is that all these undefined names are provided by
> arch/x86/platform/efi/efi-bgrt.c - which is obviously not available
> to the ia64 build.
>
> It doesn't seem useful to provide the BGRT support for Itanium
> (many systems are headless and have no graphics at all). So
> just don't let users configure this driver on non-X86 machines.
>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Acked-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

I'd take it, but it didn't seem to make it to the list for some obscure 
reason and I'd prefer it to show up there before it shows up in my tree.

Let's see if my reply makes it.

Thanks,
Rafael


> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 4fc0ffc..8fcae6d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -395,7 +395,7 @@ config ACPI_CUSTOM_METHOD
>   
>   config ACPI_BGRT
>   	bool "Boottime Graphics Resource Table support"
> -	depends on EFI
> +	depends on EFI && X86
>           help
>   	  This driver adds support for exposing the ACPI Boottime Graphics
>   	  Resource Table, which allows the operating system to obtain

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, 
VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

