From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date: Wed, 5 Dec 2018 17:25:26 +0100
Message-ID: <20181205162526.GB109259@gmail.com>
References: <20181205101131.28996-1-bp@alien8.de>
 <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
 <20181205142448.GH29510@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205142448.GH29510@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Banman <andrew.banman@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mike Travis <mike.travis@hpe.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 10:49:06PM +0900, Masami Hiramatsu wrote:
> > I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
> > since that is locally used.
> 
> Done.

Also, preferably the prototype should be eliminated via proper ordering 
of functions from lower level to higher levels.

On the rest:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
