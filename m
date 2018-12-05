From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date: Wed, 5 Dec 2018 18:15:47 +0100
Message-ID: <20181205171547.GM29510@zn.tnic>
References: <20181205101131.28996-1-bp@alien8.de>
 <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
 <20181205142448.GH29510@zn.tnic>
 <20181205162526.GB109259@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205162526.GB109259@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Banman <andrew.banman@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mike Travis <mike.travis@hpe.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 05, 2018 at 05:25:26PM +0100, Ingo Molnar wrote:
> Also, preferably the prototype should be eliminated via proper ordering 
> of functions from lower level to higher levels.

Well, that trampoline_handler() is special as we call it from inline asm
and I see Masami has marked it __visible etc.

So doing this below still builds and the trampoline_handler doesn't get
discarded but maybe there's a reason for it not being static.

Masami?

---
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6480056d370f..308bf103cc73 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -66,8 +66,6 @@
 
 #include "common.h"
 
-void *trampoline_handler(struct pt_regs *regs);
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -753,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 /*
  * Called from kretprobe_trampoline
  */
-__visible __used void *trampoline_handler(struct pt_regs *regs)
+static __used void *trampoline_handler(struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
