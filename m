From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH v2 3/4] acpi: add clock_domain field to acpi_srat_cpu_affinity
Date: Tue, 5 Feb 2013 14:34:13 +0900
Message-ID: <511099D5.1020209@jp.fujitsu.com>
References: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360031838-26898-4-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360031838-26898-4-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, rientjes@google.com
List-Id: linux-acpi@vger.kernel.org

2013/02/05 11:37, liguang wrote:
> according to ACPI SPEC v5.0, page 152,
> 5.2.16.1 Processor Local APIC/SAPIC Affinity Structure,
> the last member of it is clock_domain.
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> ---

Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>   include/acpi/actbl1.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 280fc45..98031a3 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -922,7 +922,7 @@ struct acpi_srat_cpu_affinity {
>   	u32 flags;
>   	u8 local_sapic_eid;
>   	u8 proximity_domain_hi[3];
> -	u32 reserved;		/* Reserved, must be zero */
> +	u32 clock_domain;
>   };
>   
>   /* Flags */
> 
