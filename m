From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Documentation / cpu hotplug: remove outdated description for MADT entries
Date: Thu, 20 Jun 2013 21:52:51 +0200
Message-ID: <3504197.mRYUAZnZ9p@vostro.rjw.lan>
References: <1371718482-452-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371718482-452-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Rob Landley <rob@landley.net>, Rusty Russell <rusty@rustcorp.com.au>, Srivatsa Vaddagiri <vatsa@in.ibm.com>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, June 20, 2013 04:54:42 PM Hanjun Guo wrote:
> More than 256 entries in ACPI MADT is supported from ACPI 3.0 Specification,
> So the outdated description for MADT entries should be removed.

Well, it kind of is still valid for systems pre-dating ACPI 3.0, isn't it?

So perhaps instead of simply removing that information it would be better to
rephrase it?

Thanks,
Rafael


> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/cpu-hotplug.txt |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
> index 9f40135..2e36e40 100644
> --- a/Documentation/cpu-hotplug.txt
> +++ b/Documentation/cpu-hotplug.txt
> @@ -370,9 +370,6 @@ A: There is no clear spec defined way from ACPI that can give us that
>     CPUs in MADT as hotpluggable CPUS.  In the case there are no disabled CPUS
>     we assume 1/2 the number of CPUs currently present can be hotplugged.
>  
> -   Caveat: Today's ACPI MADT can only provide 256 entries since the apicid field
> -   in MADT is only 8 bits.
> -
>  User Space Notification
>  
>  Hotplug support for devices is common in Linux today. Its being used today to
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
