From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/osl: clear high bits in acpi_os_read_memory value
Date: Mon, 07 Jul 2014 22:15:16 +0200
Message-ID: <1837641.CC4MadLaAx@vostro.rjw.lan>
References: <1404761933-27300-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58239 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751307AbaGGT5L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2014 15:57:11 -0400
In-Reply-To: <1404761933-27300-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

On Monday, July 07, 2014 03:38:53 PM Paul Gortmaker wrote:
> If one looks at acpi_os_read_port() it is very similar to the
> acpi_os_read_memory() aside from the underlying I/O method.
> However we zero out the u32 in the former and not in the latter,
> when it seems prudent to do so in both.
> 
> This was found by quasi-random code inspection, and as such there
> is no known symptom or bug to associate with possibly having stale
> data in the high bits of "value".

I'm actually afraid that this may lead to regressions, because the caller's
intention may be to leave the higher bits untouched.  So I'd think some audit
of the existing callers would be necessary before making this change.

> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/acpi/osl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index bad25b070fe0..a7373f1f31c8 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -953,6 +953,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
>  	if (!value)
>  		value = &dummy;
>  
> +	*value = 0;
>  	switch (width) {
>  	case 8:
>  		*(u8 *) value = readb(virt_addr);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
