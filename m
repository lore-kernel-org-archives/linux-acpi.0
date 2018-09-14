From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/2] drivers: base: cacheinfo: Do not populate sysfs
 for unknown cache types
Date: Fri, 14 Sep 2018 12:14:11 -0500
Message-ID: <3e842dd3-9b92-c56b-c45a-72d99b37f946@arm.com>
References: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
 <1536942489-4018-2-git-send-email-jhugo@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536942489-4018-2-git-send-email-jhugo@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>, sudeep.holla@arm.com, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 09/14/2018 11:28 AM, Jeffrey Hugo wrote:
> If a cache has an unknown type because neither the hardware nor the
> firmware told us, an entry in the sysfs tree will be made, but the type
> file will not be present.  lscpu depends on the type file being present
> for every entry, and will error out without printing system information
> if lscpu cannot open the type file.
> 
> Presenting information about a cache without indicating its type is not
> useful, therefore if we hit a cache with an unknown type, stop populating
> sysfs so that userspace has the maximum amount of useful information.
> 
> This addresses the following lscpu error, which prevents any output.
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>   drivers/base/cacheinfo.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 5d5b598..cf78fa6 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
>   		this_leaf = this_cpu_ci->info_list + i;
>   		if (this_leaf->disable_sysfs)
>   			continue;
> +		if (this_leaf->type == CACHE_TYPE_NOCACHE)
> +			break;
>   		cache_groups = cache_get_attribute_groups(this_leaf);
>   		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
>   					   "index%1u", i);
> 

Looks fine to me:

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>


Thanks,
