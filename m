From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Tue, 11 Sep 2018 15:16:40 -0500
Message-ID: <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi Jeffrey,

(+Sudeep)

On 09/11/2018 02:32 PM, Jeffrey Hugo wrote:
> The type of a cache might not be specified by architectural mechanisms (ie
> system registers), but its type might be specified in the PPTT.  In this
> case, following the PPTT specification, we should identify the cache as
> the type specified by PPTT.
> 
> This fixes the following lscpu issue where only the cache type sysfs file
> is missing which results in no output providing a poor user experience in
> the above system configuration-
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>   drivers/acpi/pptt.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index d1e26cb..3c6db09 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -401,6 +401,21 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   			break;
>   		}
>   	}
> +	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
> +	    (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
> +		switch (found_cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) {
> +		case ACPI_PPTT_CACHE_TYPE_DATA:
> +			this_leaf->type = CACHE_TYPE_DATA;
> +			break;
> +		case ACPI_PPTT_CACHE_TYPE_INSTR:
> +			this_leaf->type = CACHE_TYPE_INST;
> +			break;
> +		case ACPI_PPTT_CACHE_TYPE_UNIFIED:
> +		case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
> +			this_leaf->type = CACHE_TYPE_UNIFIED;
> +			break;
> +		}
> +	}
>   	/*
>   	 * If the above flags are valid, and the cache type is NOCACHE
>   	 * update the cache type as well.
> 

If you look at the next line of code following this comment its going to 
update the cache type for fully populated PPTT nodes. Although with the 
suggested change its only going to activate if someone completely fills 
out the node and fails to set the valid flag on the cache type.

What I suspect is happening in the reported case is that the nodes in 
the PPTT table are missing fields we consider to be important. Since 
that data isn't being filled out anywhere else, so we leave the cache 
type alone too. This has the effect of hiding sysfs nodes with 
incomplete information.

Also, the lack of the DATA/INST fields is based on the assumption that 
the only nodes which need their type field updated are outside of the 
CPU core itself so they are pretty much guaranteed to be UNIFIED. Are 
you hitting this case?


Thanks,
