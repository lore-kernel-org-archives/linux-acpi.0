From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 07/18] ACPI: Adjust system_state check
Date: Mon, 15 May 2017 10:27:00 -0400
Message-ID: <20170515102700.0037d156@gandalf.local.home>
References: <20170514182716.347236777@linutronix.de>
        <20170514183613.002084749@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170514183613.002084749@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


[ added linux-acpi and took off arm list ;-) ]

On Sun, 14 May 2017 20:27:23 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> 
> Make the decision wether a pci root is hotplugged depend on SYSTEM_RUNNING
> instead of !SYSTEM_BOOTING.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/acpi/pci_root.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -523,7 +523,7 @@ static int acpi_pci_root_add(struct acpi
>  	struct acpi_pci_root *root;
>  	acpi_handle handle = device->handle;
>  	int no_aspm = 0;
> -	bool hotadd = system_state != SYSTEM_BOOTING;
> +	bool hotadd = system_state == SYSTEM_RUNNING;

What about the other boot states greater than SYSTEM_RUNNING? Can this
be called then too?

IOW, should it be:

	bool hotadd = system_state >= SYSTEM_RUNNING;

?

-- Steve

>  
>  	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>  	if (!root)
> 
