From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 0/2] PPTT handle Handle architecturally unknown cache types
Date: Fri, 05 Oct 2018 11:45:34 +0200
Message-ID: <2264331.PzHIdRIQff@aspire.rjw.lan>
References: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: sudeep.holla@arm.com, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, jeremy.linton@arm.com, linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, October 4, 2018 5:20:04 PM CEST Jeffrey Hugo wrote:
> The ARM Architecture Reference Manual allows for caches to be "invisible" and
> thus not specified in the system registers under some scenarios such as if the
> cache cannot be managed by set/way operations.
> 
> However, such caches may be specified in the ACPI PPTT table for workload
> performance/scheduling optimizations.
> 
> Currently such caches can cause an error in lscpu -
> 
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> and result in no output, providing a poor user experience.  lstopo is also
> affected as such caches are not included in the output.
> 
> Address these issues by attempting to be a little more discerning about when
> cache information is provided to userspace, and also utilize all sources for
> cache information when possible.
> 
> [v4]
> -Collected all current tags and ammended to individual patches
> -Removed PPTT_CHECKED_ATTRIBUTES
> 
> [v3]
> -removed valid flag in PPTT
> -Added Jeremy Linton's reviewed-by
> 
> [v2]
> -Updated cacheinfo per Sudeep's suggestion
> -Integrated the PPTT fix into existing PPTT code per Sudeep's suggestion
> 
> Jeffrey Hugo (2):
>   drivers: base: cacheinfo: Do not populate sysfs for unknown cache
>     types
>   ACPI/PPTT: Handle architecturally unknown cache types
> 
>  drivers/acpi/pptt.c      | 15 +++++++++++----
>  drivers/base/cacheinfo.c |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> 

Both patches applied, thanks!
