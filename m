From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
Date: Tue, 18 Nov 2014 21:51:25 +0800
Message-ID: <546B4EDD.9050804@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46447 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbaKRNvi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 08:51:38 -0500
Received: by mail-pd0-f182.google.com with SMTP id g10so8336017pdj.27
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2014 05:51:38 -0800 (PST)
In-Reply-To: <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, Kangkang.Shen@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@l

Hi Rafael,

On 2014=E5=B9=B410=E6=9C=8817=E6=97=A5 21:36, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> It is very useful to traverse all available table entries without max
> number of expected entries type. Current acpi_parse_entries()
> implementation gives that feature but it does not count those entries=
,
> it returns 0 instead, so fix it to count matched and successfully
> entries and return it.
>
> NOTE: This change has no impact to x86 and ia64 archs since existing =
code
> checks for error occurrence only (acpi_parse_entries(...,0) < 0).
>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Patch 2 and patch 3 are only for ACPI cores, and have no harm to x86
and IA64, could you merge first in 3.19?

Thanks
Hanjun

> ---
>   drivers/acpi/tables.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 21ae521..b18e45e 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -225,10 +225,13 @@ acpi_parse_entries(unsigned long table_size,
>   	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header=
) <
>   	       table_end) {
>   		if (entry->type =3D=3D entry_id
> -		    && (!max_entries || count++ < max_entries))
> +		    && (!max_entries || count < max_entries)) {
>   			if (handler(entry, table_end))
>   				return -EINVAL;
>
> +			count++;
> +		}
> +
>   		/*
>   		 * If entry->length is 0, break from this loop to avoid
>   		 * infinite loop.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
