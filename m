From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] acpi: fix incompatibility with mcount-based function
 graph tracing
Date: Thu, 16 Mar 2017 10:41:48 -0400
Message-ID: <20170316104148.51b78a24@gandalf.local.home>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Mar 2017 08:56:28 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Paul Menzel reported a warning:
> 
>   WARNING: CPU: 0 PID: 774 at /build/linux-ROBWaj/linux-4.9.13/kernel/trace/trace_functions_graph.c:233 ftrace_return_to_handler+0x1aa/0x1e0
>   Bad frame pointer: expected f6919d98, received f6919db0
>     from func acpi_pm_device_sleep_wake return to c43b6f9d
> 
> The warning means that function graph tracing is broken for the
> acpi_pm_device_sleep_wake() function.  That's because the acpi Makefile
> unconditionally sets the '-Os' gcc flag to optimize for size.  That's an
> issue because mcount-based function graph tracing is incompatible with
> '-Os' on x86, thanks to the following gcc bug:
> 
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42109
> 
> I have another patch pending which will ensure that mcount-based
> function graph tracing is never used with CONFIG_CC_OPTIMIZE_FOR_SIZE on
> x86.
> 
> But this patch is needed in addition to that one because the ACPI
> Makefile overrides that config option for no apparent reason.  It has
> had this flag since the beginning of git history, and there's no related
> comment, so I don't know why it's there.  As far as I can tell, there's
> no reason for it to be there.  The appropriate behavior is for it to
> honor CONFIG_CC_OPTIMIZE_FOR_{SIZE,PERFORMANCE} like the rest of the
> kernel.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  drivers/acpi/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index a391bbc..d94f92f 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -2,7 +2,6 @@
>  # Makefile for the Linux ACPI interpreter
>  #
>  
> -ccflags-y			:= -Os

Unless somebody can come up with a real reason to have this,

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
>  
>  #
