From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH 2/8] memory-hotplug: offline memory only when it is
 onlined
Date: Fri, 20 Jul 2012 16:46:40 +0900
Message-ID: <50090CE0.3040409@jp.fujitsu.com>
References: <5009038A.4090001@cn.fujitsu.com> <5009044B.7050203@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <5009044B.7050203@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

Hi Wen,

2012/07/20 16:10, Wen Congyang wrote:
> offline_memory() will fail if the memory is not onlined. So check
> whether the memory is onlined before calling offline_memory().
>
> CC: David Rientjes <rientjes@google.com>
> CC: Jiang Liu <liuj97@gmail.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> ---

I have no comment.
Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>   drivers/acpi/acpi_memhotplug.c |   10 +++++++---
>   1 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index db8de39..712e767 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -323,9 +323,13 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>   	 */
>   	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>   		if (info->enabled) {
> -			result = offline_memory(info->start_addr, info->length);
> -			if (result)
> -				return result;
> +			if (!is_memblk_offline(info->start_addr,
> +					       info->length)) {
> +				result = offline_memory(info->start_addr,
> +							info->length);
> +				if (result)
> +					return result;
> +			}
>   		}
>   		list_del(&info->list);
>   		kfree(info);
>


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
