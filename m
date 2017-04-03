From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 1/2] ACPI: ACPICA: Add non-linux host build support
Date: Mon, 3 Apr 2017 15:47:09 -0600
Message-ID: <5ce80bd8-c0c8-8ba9-872f-80af844a1ac1@redhat.com>
References: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36768 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdDCVrN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2017 17:47:13 -0400
Received: by mail-qk0-f176.google.com with SMTP id p22so126844131qka.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Apr 2017 14:47:12 -0700 (PDT)
In-Reply-To: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Al Stone <ah3@redhat.com>

On 03/30/2017 10:53 PM, Lv Zheng wrote:
> _LINUX: used to detect a target build is a linux kernel/application.
> __linux__: used to detect a build is on a linux hosts.
> 
> Thus we can see: if a linux kernel build is performed on environments other
> than linux hosts, __linux__ may not be defined by the compiler and _LINUX
> cannot cover linux kernel resident ACPICA files, as it's only defined in
> <linux/acpi.h> and hence only allows non ACPICA kernel files to correctly
> include aclinux.h.
> As a conclusion, we don't actually support such build.
> 
> This patch adds -D_LINUX for ACPICA files so that kernel builds on any
> hosts can use unified _LINUX as a linux kernel target indication to
> correctly include aclinux.h.
> 
> Cc: Al Stone <ah3@redhat.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index 32d93ed..dea6530 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for ACPICA Core interpreter
>  #
>  
> -ccflags-y			:= -Os -DBUILDING_ACPICA
> +ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
>  ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
>  
>  # use acpi.o to put all files here into acpi.o modparam namespace
> 

These patches do solve the particular compilation problem I was having
(targeting an embedded arm64 system), so thank you for that.  The build
test obviously needs fixing, but with the Linaro aarch64-elf compilers,
and the defconfig,

Tested-by: Al Stone <ahs3@redhat.com>

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
