From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 5/5] printk: Allocate kernel log buffer earlier
Date: Thu, 17 Feb 2011 15:21:36 -0800
Message-ID: <AANLkTin4cqM6FFOk73NWXKFQK9s0daj8-VsL0fGyERZ+@mail.gmail.com>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
	<20110217185132.735139933@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54598 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1BQXVi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Feb 2011 18:21:38 -0500
In-Reply-To: <20110217185132.735139933@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 17, 2011 at 10:51 AM, Mike Travis <travis@sgi.com> wrote:
> On larger systems, because of the numerous ACPI, Bootmem and EFI
> messages, the static log buffer overflows before the larger one
> specified by the log_buf_len param is allocated. =A0Minimize the
> overflow by allocating the new log buffer as soon as possible.
>
> All arch's are covered by the "setup_log_buf" in start_kernel().
> The x86 arch allocates it right after bootmem is created.
>
> v1: Added pertinent __init & __initdata specifiers.
> v2: updated to apply to x86-tip
>
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Jack Steiner <steiner@sgi.com>
> Reviewed-by: Robin Holt <holt@sgi.com>
> ---
> =A0arch/x86/kernel/setup.c | =A0 =A05 ++
> =A0include/linux/printk.h =A0| =A0 =A04 ++
> =A0init/main.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01
> =A0kernel/printk.c =A0 =A0 =A0 =A0 | =A0 81 +++++++++++++++++++++++++=
++++-------------------
> =A04 files changed, 60 insertions(+), 31 deletions(-)
>
> --- linux.orig/arch/x86/kernel/setup.c
> +++ linux/arch/x86/kernel/setup.c
> @@ -1007,6 +1007,11 @@ void __init setup_arch(char **cmdline_p)
> =A0 =A0 =A0 =A0memblock_find_dma_reserve();
> =A0 =A0 =A0 =A0dma32_reserve_bootmem();
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Allocate bigger log buffer as early as possible
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 setup_log_buf();
> +
> =A0#ifdef CONFIG_KVM_CLOCK
> =A0 =A0 =A0 =A0kvmclock_init();
> =A0#endif
> --- linux.orig/include/linux/printk.h
> +++ linux/include/linux/printk.h
> @@ -1,6 +1,8 @@
> =A0#ifndef __KERNEL_PRINTK__
> =A0#define __KERNEL_PRINTK__
>
> +#include <linux/init.h>
> +
> =A0extern const char linux_banner[];
> =A0extern const char linux_proc_banner[];
>
> @@ -89,6 +91,8 @@ int no_printk(const char *fmt, ...)
> =A0extern asmlinkage __attribute__ ((format (printf, 1, 2)))
> =A0void early_printk(const char *fmt, ...);
>
> +void __init setup_log_buf(void);
> +
> =A0extern int printk_needs_cpu(int cpu);
> =A0extern void printk_tick(void);
>
> --- linux.orig/init/main.c
> +++ linux/init/main.c
> @@ -592,6 +592,7 @@ asmlinkage void __init start_kernel(void
> =A0 =A0 =A0 =A0 * These use large bootmem allocations and must preced=
e
> =A0 =A0 =A0 =A0 * kmem_cache_init()
> =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 setup_log_buf();
> =A0 =A0 =A0 =A0pidhash_init();
> =A0 =A0 =A0 =A0vfs_caches_init_early();
> =A0 =A0 =A0 =A0sort_main_extable();
> --- linux.orig/kernel/printk.c
> +++ linux/kernel/printk.c
> @@ -162,46 +162,65 @@ void log_buf_kexec_setup(void)
> =A0}
> =A0#endif
>
> +static unsigned long __initdata new_log_buf_len;
> =A0static int __init log_buf_len_setup(char *str)
> =A0{
> =A0 =A0 =A0 =A0unsigned size =3D memparse(str, &str);
> - =A0 =A0 =A0 unsigned long flags;
>
> =A0 =A0 =A0 =A0if (size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D roundup_pow_of_two(size);
> - =A0 =A0 =A0 if (size > log_buf_len) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned start, dest_idx, offset;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *new_log_buf;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_log_buf =3D alloc_bootmem(size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!new_log_buf) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "lo=
g_buf_len: allocation failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&logbuf_lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_buf_len =3D size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_buf =3D new_log_buf;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D start =3D min(con_start, log=
_start);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dest_idx =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (start !=3D log_end) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_buf[dest_idx] =3D _=
_log_buf[start & (__LOG_BUF_LEN - 1)];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dest_idx++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_start -=3D offset;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_start -=3D offset;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_end -=3D offset;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&logbuf_lock, fl=
ags);
> + =A0 =A0 =A0 if (size > log_buf_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_log_buf_len =3D size;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_NOTICE "log_buf_len: %d\n",=
 log_buf_len);
> - =A0 =A0 =A0 }
> -out:
> - =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 return 0;
> =A0}
> +early_param("log_buf_len", log_buf_len_setup);
>
> -__setup("log_buf_len=3D", log_buf_len_setup);
> +void __init setup_log_buf(void)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned start, dest_idx, offset;
> + =A0 =A0 =A0 char *new_log_buf;
> + =A0 =A0 =A0 char first_line[64], *first_nl;
> +
> + =A0 =A0 =A0 if (!new_log_buf_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 new_log_buf =3D alloc_bootmem(new_log_buf_len);
> + =A0 =A0 =A0 memset(first_line, 0, sizeof(first_line));

use x86_memblock_find_range in x86 code?

you can do that much earlier before SRAT etc is parsed.

Thanks

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
