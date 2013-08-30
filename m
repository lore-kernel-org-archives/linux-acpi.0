From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/4] mm/acpi: use NUMA_NO_NODE
Date: Fri, 30 Aug 2013 14:07:37 +0200
Message-ID: <1489693.CsKFcLgBvu@vostro.rjw.lan>
References: <521FF494.6000504@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44650 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756Ab3H3L4w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Aug 2013 07:56:52 -0400
In-Reply-To: <521FF494.6000504@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jianguo Wu <wujianguo@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Friday, August 30, 2013 09:25:40 AM Jianguo Wu wrote:
> Use more appropriate NUMA_NO_NODE instead of -1
> 
> Signed-off-by: Jianguo Wu <wujianguo@huawei.com>

I'll queue this up for 3.13.

Thanks,
Rafael


> ---
>  drivers/acpi/acpi_memhotplug.c |    2 +-
>  drivers/acpi/numa.c            |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 999adb5..c00a3a7 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -281,7 +281,7 @@ static void acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
>  		if (!info->enabled)
>  			continue;
>  
> -		if (nid < 0)
> +		if (nid == NUMA_NO_NODE)
>  			nid = memory_add_physaddr_to_nid(info->start_addr);
>  
>  		acpi_unbind_memory_blocks(info, handle);
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 33e609f..09f79a2 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -73,7 +73,7 @@ int acpi_map_pxm_to_node(int pxm)
>  {
>  	int node = pxm_to_node_map[pxm];
>  
> -	if (node < 0) {
> +	if (node == NUMA_NO_NODE) {
>  		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
>  			return NUMA_NO_NODE;
>  		node = first_unset_node(nodes_found_map);
> @@ -334,7 +334,7 @@ int acpi_get_pxm(acpi_handle h)
>  
>  int acpi_get_node(acpi_handle *handle)
>  {
> -	int pxm, node = -1;
> +	int pxm, node = NUMA_NO_NODE;
>  
>  	pxm = acpi_get_pxm(handle);
>  	if (pxm >= 0 && pxm < MAX_PXM_DOMAINS)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
