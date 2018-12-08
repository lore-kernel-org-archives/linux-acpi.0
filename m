From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date: Sat, 8 Dec 2018 14:56:58 +0900
Message-ID: <20181208145658.4de9cfedcd265bcba4b252d0@kernel.org>
References: <20181205101131.28996-1-bp@alien8.de>
        <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
        <20181205142448.GH29510@zn.tnic>
        <20181205162526.GB109259@gmail.com>
        <20181205171547.GM29510@zn.tnic>
        <20181207234210.c29731b7a481c74a4e57220c@kernel.org>
        <20181207194847.GG9385@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207194847.GG9385@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Banman <andrew.banman@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mike Travis <mike.travis@hpe.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 7 Dec 2018 20:48:47 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Dec 07, 2018 at 11:42:10PM +0900, Masami Hiramatsu wrote:
> > Hmm, I just thought that the symbol only referred from inline asm should
> > be visible. But if it is OK for any version of supported gcc and clang,
> > I'm good to remove it. :-) (IOW, I just concerned about older gcc)
> 
> I just tried two gcc versions: 8.2 and 4.8.5. Both asms looks good:
> 
> ffffffff81044690 <kretprobe_trampoline>:
> ...
> 
> 
> ffffffff810446ab:       41 57                   push   %r15
> ffffffff810446ad:       48 89 e7                mov    %rsp,%rdi
> ffffffff810446b0:       e8 db 01 00 00          callq  ffffffff81044890 <trampoline_handler>
> 
> there's the CALL...
> 
> ffffffff810446b5:       48 89 84 24 98 00 00    mov    %rax,0x98(%rsp)
> ffffffff810446bc:       00
> 
> ... and the handler is at the expected address.
> 
> ffffffff81044890 <trampoline_handler>:
> ffffffff81044890:       e8 ab c9 7b 00          callq  ffffffff81801240 <__fentry__>
> ffffffff81044895:       41 57                   push   %r15
> ffffffff81044897:       41 56                   push   %r14
> ffffffff81044899:       41 55                   push   %r13
> ffffffff8104489b:       49 89 fd                mov    %rdi,%r13
> 
> Dunno, if you feel like there might be some trouble with some compilers,
> I can keep the hunk below as a separate patch and revert it when it
> explodes somewhere...?

OK, then please remove it. :-) Even if any problem occurs, which must be
build error, so we can revert it in that case.

Thank you!

> 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you,
> > 
> > > 
> > > ---
> > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > index 6480056d370f..308bf103cc73 100644
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -66,8 +66,6 @@
> > >  
> > >  #include "common.h"
> > >  
> > > -void *trampoline_handler(struct pt_regs *regs);
> > > -
> > >  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> > >  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> > >  
> > > @@ -753,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > >  /*
> > >   * Called from kretprobe_trampoline
> > >   */
> > > -__visible __used void *trampoline_handler(struct pt_regs *regs)
> > > +static __used void *trampoline_handler(struct pt_regs *regs)
> > >  {
> > >  	struct kretprobe_instance *ri = NULL;
> > >  	struct hlist_head *head, empty_rp;
> > > 
> > > -- 
> > > Regards/Gruss,
> > >     Boris.
> > > 
> > > Good mailing practices for 400: avoid top-posting and trim the reply.
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
