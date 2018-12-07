From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date: Sat, 8 Dec 2018 00:21:22 +0900
Message-ID: <20181208002122.b84a40b86f4225c9e0795ff2@kernel.org>
References: <20181205101131.28996-1-bp@alien8.de>
        <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
        <20181205142448.GH29510@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205142448.GH29510@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Banman <andrew.banman@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mike Travis <mike.travis@hpe.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 5 Dec 2018 15:24:48 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 10:49:06PM +0900, Masami Hiramatsu wrote:
> > I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
> > since that is locally used.
> 
> Done.
> 
> > Should we declare prototypes for __weak functions? Anyway, we should remove
> > __weak from the prototypes.
> 
> And done.
> 
> Thx.

OK, I think it is good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
