From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Wed, 12 Sep 2018 16:38:41 +0100
Message-ID: <2873c62f-1bf9-5aa0-b3a2-07980ef61d35@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
 <af280111-5dec-a4e1-7dfd-20f38a9fd8ab@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af280111-5dec-a4e1-7dfd-20f38a9fd8ab@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>, Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org



On 12/09/18 16:27, Sudeep Holla wrote:
> 
> 
> On 12/09/18 15:41, Jeffrey Hugo wrote:

[...]

>>
>> Correct.  However, what if you have a NOCACHE (not architecturally
>> specified), that is fully described in PPTT, as a non-unified cache
>> (data only)?  Unlikely?  Maybe.  Still seem possible though, therefore I
>> feel this assumption is suspect.
>>
> 
> Yes, we have other issues if the architecturally not specified cache is
> not unified irrespective of what PPTT says. So we may need to review and
> see if that assumption is removed everywhere.
> 
> Until then why can't a simple change fix the issue you have:
> 
> -->8
> 
> diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
> index d1e26cb599bf..f74131201f5e 100644
> --- i/drivers/acpi/pptt.c
> +++ w/drivers/acpi/pptt.c
> @@ -406,7 +406,8 @@ static void update_cache_properties(struct cacheinfo
> *this_leaf,
>          * update the cache type as well.
>          */
>         if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -           valid_flags == PPTT_CHECKED_ATTRIBUTES)
> +           (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
> +            found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))

Looking at this again, if we are supporting just presence of cache type
and size(may be), then we can drop the whole valid_flags thing here.

>                 this_leaf->type = CACHE_TYPE_UNIFIED;
>  }
> 
-- 
Regards,
Sudeep
