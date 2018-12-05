From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date: Wed, 5 Dec 2018 22:49:06 +0900
Message-ID: <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
References: <20181205101131.28996-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205101131.28996-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Banman <andrew.banman@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Travis <mike.travis@hpe.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Borislav,

On Wed,  5 Dec 2018 11:11:31 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> ... with the goal of eventually enabling -Wmissing-prototypes by
> default. At least on x86.
> 
> Make functions static where possible, otherwise add prototypes or make
> them visible through includes.

OK, and I have some comments for kprobe's parts.

[...]
> diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
> index 2b949f4fd4d8..f0fc628c4bb7 100644
> --- a/arch/x86/kernel/kprobes/common.h
> +++ b/arch/x86/kernel/kprobes/common.h
> @@ -91,6 +91,8 @@ extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn);
>  extern void synthesize_reljump(void *dest, void *from, void *to);
>  extern void synthesize_relcall(void *dest, void *from, void *to);
>  
> +extern void *trampoline_handler(struct pt_regs *regs);
> +

I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
since that is locally used.

>  #ifdef	CONFIG_OPTPROBES
>  extern int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter);
>  extern unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr);
[...]
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e909413e4e38..91d19d6a2892 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -379,6 +379,9 @@ int enable_kprobe(struct kprobe *kp);
>  
>  void dump_kprobe(struct kprobe *kp);
>  
> +void __weak *alloc_insn_page(void);
> +void __weak free_insn_page(void *page);

Should we declare prototypes for __weak functions? Anyway, we should remove
__weak from the prototypes.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
