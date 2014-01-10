From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 2/2] x86, e820 disable ACPI Memory Hotplug if memory
 mapping is specified by user [v2]
Date: Fri, 10 Jan 2014 14:34:48 -0700
Message-ID: <1389389688.1792.174.camel@misato.fc.hp.com>
References: <1389380698-19361-1-git-send-email-prarit@redhat.com>
	 <1389380698-19361-4-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1389380698-19361-4-git-send-email-prarit@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linn Crosetto <linn@hp.com>, Pekka Enberg <penberg@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Tang Chen <tangchen@cn.fujitsu.com>, Wen Congyang <wency@cn.fujitsu.com>, Vivek Goyal <vgoyal@redhat.com>, kosaki.motohiro@gmail.com, dyoung@redhat.com, linux-acpi@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2014-01-10 at 14:04 -0500, Prarit Bhargava wrote:
 :
>  arch/x86/kernel/e820.c         |   10 +++++++++-
>  drivers/acpi/acpi_memhotplug.c |    7 ++++++-
>  include/linux/memory_hotplug.h |    3 +++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 174da5f..747f36a 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -20,6 +20,7 @@
>  #include <linux/firmware-map.h>
>  #include <linux/memblock.h>
>  #include <linux/sort.h>
> +#include <linux/memory_hotplug.h>
>  
>  #include <asm/e820.h>
>  #include <asm/proto.h>
> @@ -834,6 +835,8 @@ static int __init parse_memopt(char *p)
>  		return -EINVAL;
>  	e820_remove_range(mem_size, ULLONG_MAX - mem_size, E820_RAM, 1);
>  
> +	set_acpi_no_memhotplug();
> +

It won't build when CONFIG_ACPI_HOTPLUG_MEMORY is not defined.

Thanks,
-Toshi




--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
