From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Lenovo resume from suspends hangs in i915_gpu_busy or so
Date: Fri, 1 Apr 2011 09:08:17 -0700
Message-ID: <20110401090817.01717af0@jbarnes-desktop>
References: <20110401021055.GB6071@gamma.logic.tuwien.ac.at>
	<20110401051511.GE9128@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy2-pub.bluehost.com ([67.222.39.60]:48110 "HELO
	oproxy2-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758075Ab1DAQIY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2011 12:08:24 -0400
In-Reply-To: <20110401051511.GE9128@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 1 Apr 2011 14:15:11 +0900
Norbert Preining <preining@logic.at> wrote:

> Hi all,
> 
> adding dri-devel as I found it is actually not completely dead, 
> but hanging in some i915 problem.
> 
> Copyied from screen:
> Process ips-adjust (....
> Stack:
>   ....
>    ....
>   ...
> Call Trace:
>   <IRQ>
>   ... ? tick_program_event
>   call_sortirq
>   do_softirq
>   irq_exit
>   smp_apic_timer_interrupt
>   apic_timer_interrupt
>   <EOI>
>   ? _raw_spin_lock
>   i915_gpu_busy
>   ips_adjust
>   ? show_cpu_temp
>   kthread
>   kernel_thread_helper
>   ? kthread_worker_fn
>   ? gs_change
> Code: ...
> (once more more or less the same as above)

Hm, ok so on resume we're checking GPU busyness, which is normal, but
end up hanging on the spinlock?  Do you see what scrolls by above the
text you took a picture of (probably a "task hung" message?).

Does this happen reliably?  Does a previous kernel work ok?

-- 
Jesse Barnes, Intel Open Source Technology Center
