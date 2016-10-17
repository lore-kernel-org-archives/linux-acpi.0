From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
Date: Mon, 17 Oct 2016 22:26:47 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A253666@SHSMSX101.ccr.corp.intel.com>
References: <1476402698-40963-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476402698-40963-1-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "wmiles@sgl.com" <wmiles@sgl.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Yisheng

> From: Yisheng Xie [mailto:xieyisheng1@huawei.com]
> Subject: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
> 
> when try to cross compile acpi tool in dir kernel/tools
> for arm64 use command:
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- acpi
> it failed with the following log:
> In file included
>     from ../../../../../include/acpi/acpi.h:58:0,
>     from ../../../../../drivers/acpi/acpica/utstring.c:44:
>     ../../../../../include/acpi/actypes.h:130:34: error: conflicting types for 's64'
>  typedef signed long long s64;
>                            ^
> In file included
>     from /opt/aarch64-linux-gnu/libc/usr/include/asm-generic/types.h:6:0
>     from /opt/aarch64-linux-gnu/libc/usr/include/asm/types.h:1,
>     from ../../../../../include/uapi/linux/types.h:4,
>     from ../../../../../include/linux/types.h:5,
>     from /opt/aarch64-linux-gnu/libc/usr/include/asm/sigcontext.h:19,
>     from /opt/aarch64-linux-gnu/libc/usr/include/bits/sigcontext.h:27,
>     from /opt/aarch64-linux-gnu/libc/usr/include/signal.h:308,
>     from ../../../../../include/acpi/platform/acenv.h:365,
>     from ../../../../../include/acpi/acpi.h:56,
>     from ./acpidump.h:55,
>     from ../../os_specific/service_layers/oslinuxtbl.c:44:
> ../../../../../include/asm-generic/int-ll64.h:24:26: note: previous declaration of 's64' was here
>  typedef signed long long s64;
>                            ^
> Fix this compile problem.

This looks like a conflict between asm-generic/int-ll64.h and actypes.h.

When a build environment actually has s64 definition.
ACPICA shouldn't define it.
ACPICA should define ACPI_USE_SYSTEM_INTTYPES instead.

However it is not clear if a Linux userspace should be aware of s64.
We couldn't see this issue in other arch builds.
So I wonder if this is just a missing "#ifdef __KERNEL__" in asm-generic/int-ll64.h.

If Linux should be aware of s64.
Then ACPICA definition of s64 should be disabled by defining ACPI_USE_SYSTEM_INTTYPES.
Since this is a post-ACPICA-release issue.
You should only fix it in tools/power/acpi/Makefile*.

So I think this patch is not a right fix, but a wrong workaround.
It can easily cause regressions in other ACPICA builds.

> 
> Fixes: e323c02dee59 ("ACPICA: MSVC9: Fix <sys/stat.h> inclusion order issue")
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  include/acpi/platform/acenv.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
> index 34cce72..0089fa0 100644
> --- a/include/acpi/platform/acenv.h
> +++ b/include/acpi/platform/acenv.h
> @@ -361,9 +361,13 @@
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#ifdef __aarch64__
> +#include <sys/stat.h>
> +#else
>  #include <time.h>
>  #include <signal.h>
>  #endif
> +#endif
> 
>  #endif				/* ACPI_USE_STANDARD_HEADERS */


We shouldn't rely on inclusion orders to fix this issue.
It can easily cause order problem on other ACPICA build environment.

Thanks
Lv
