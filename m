From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] acpi: Fix typo in SRAT table name
Date: Mon, 24 Jul 2017 22:29:10 +0200
Message-ID: <7822621.77xjRtf9ye@aspire.rjw.lan>
References: <20170721225124.15297-1-ross.zwisler@linux.intel.com> <20170721225124.15297-2-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56890 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754019AbdGXUhH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 16:37:07 -0400
In-Reply-To: <20170721225124.15297-2-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, devel@acpica.org, linux-acpi@vger.kernel.org

On Friday, July 21, 2017 04:51:24 PM Ross Zwisler wrote:
> To save someone the time of searching the ACPI spec for "Static Resource
> Affinity Table".
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
>  drivers/acpi/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index edb0c79..917f1cc 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
>  	 * So go over all cpu entries in SRAT to get apicid to node mapping.
>  	 */
>  
> -	/* SRAT: Static Resource Affinity Table */
> +	/* SRAT: System Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
>  		struct acpi_subtable_proc srat_proc[3];
>  
> 

Both this and the [1/2] applied, thanks!

