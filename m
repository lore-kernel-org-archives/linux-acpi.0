From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/SRAT: fix SRAT order parsing when both LAPIC and X2APIC present
Date: Thu, 21 Apr 2016 02:07:46 +0200
Message-ID: <5650804.Bpcz1v4kAC@vostro.rjw.lan>
References: <1460017288-2176-1-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58493 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751341AbcDUAEz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:04:55 -0400
In-Reply-To: <1460017288-2176-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: len.brown@intel.com, mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, April 07, 2016 10:21:28 AM Lukasz Anaczkowski wrote:
> SRAT maps APIC ID to proximity domains ids. Mapping from proximity
> domain ids to NUMA node ids is based on order of entries in SRAT table.
> SRAT table has just LAPIC entires or mix of LAPIC and X2APIC entries.
> As long as there are only LAPIC entires, mapping from proximity domain
> id to NUMA node id is as assumed by BIOS. However, once APIC entries are
> mixed, X2APIC entries would be first mapped which causes unexpected NUMA
> node mapping.

The changelog describes the problem (good), but it doesn't say anything
about the mitigation (not good).  You should say something about what the
patch does to address the issue, like "To address that problem, do X".

> Fixes: d81056b5278 (Handle apic/x2apic entries in MADT in correct order)
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
> ---
>  drivers/acpi/numa.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 72b6e9e..d176e0e 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -327,10 +327,18 @@ int __init acpi_numa_init(void)
>  
>  	/* SRAT: Static Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> -		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
> -				     acpi_parse_x2apic_affinity, 0);
> -		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
> -				     acpi_parse_processor_affinity, 0);
> +		struct acpi_subtable_proc srat_proc[2];
> +
> +		memset(srat_proc, 0, sizeof(srat_proc));
> +		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> +		srat_proc[0].handler = acpi_parse_processor_affinity;
> +		srat_proc[1].id = ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY;
> +		srat_proc[1].handler = acpi_parse_x2apic_affinity;
> +
> +		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
> +					sizeof(struct acpi_table_srat),
> +					srat_proc, ARRAY_SIZE(srat_proc), 0);
> +

Looking at the code, the idea is to check each entry against both LAPIC and
X2APIC in table order so as to cause them to be mapped in that order too, right?

>  		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>  					    acpi_parse_memory_affinity,
>  					    NR_NODE_MEMBLKS);
> 

Thanks,
Rafael

