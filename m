From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 0/5] x86: fix hang when AP bringup is too slow
Date: Tue, 29 Apr 2014 10:36:28 +0200
Message-ID: <20140429103628.714e772f@thinkpad>
References: <1397488277-14865-1-git-send-email-imammedo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29281 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbaD2Igg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2014 04:36:36 -0400
In-Reply-To: <1397488277-14865-1-git-send-email-imammedo@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: prarit@redhat.com
Cc: Igor Mammedov <imammedo@redhat.com>, drjones@redhat.com, toshi.kani@hp.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

On Mon, 14 Apr 2014 17:11:12 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> changes since v3:
>  * put simple bugfixes first
>  * move common part of syncing with master CPU in cpu_init()
>    for x32/64 variant into helper function
>  * cpu_init(): WARN_ON if cpu_initialized_mask is set
>  * fix panic on CPU unplug, caused by erroneous removing
>    of "pr->dev = dev;" in drivers/acpi/acpi_processor.c
Hi guys,

It seems there won't be more comments on series,
could you review it, please?

> 
> --
> Hang is observed on virtual machines during CPU hotplug,
> especially in big guests with many CPUs. (It happens more
> often if host is over-committed).
> 
> Hang happens because master CPU timeouts on waiting till
> AP boots and 'cancels' CPU online operation assuming AP
> is not functional but AP may continue run wild later
> causing various hangs or panics in running kernel that
> is assuming that AP was offline.
> 
> This is an alternative approach, that instead of canceling
> in-progress AP bringup (https://lkml.org/lkml/2014/3/6/257),
> removes timeouts so that AP bringup won't be affected by
> poor timing and syncs AP with master CPU at early startup
> making sure that AP won't run wild if master CPU doesn't
> expect AP to come online.
> 
> Series also fixes 3 bugs found during testing CPU bringup
> failure case.
> 
> --
> Below is the detailed description of a more often happening hang:
> ---
> Master CPU may timeout before cpu_callin_mask is set and cancel
> booting CPU, but being onlined CPU still continues to boot, sets
> cpu_active_mask (CPU_STARTING notifiers) and spins in
> check_tsc_sync_target() for master cpu to arrive. Following attempt
> to online another cpu hangs in stop_machine, initiated from here:
> smp_callin ->
>   smp_store_cpu_info ->
>     identify_secondary_cpu ->
>       mtrr_ap_init -> set_mtrr_from_inactive_cpu
> 
> stop_machine waits on completion of stop_work on all CPUs from
> cpu_active_mask including a failed CPU that spins in check_tsc_sync_target().
> 
> 
> Igor Mammedov (5):
>   x86: fix list corruption on CPU hotplug
>   x86: fix memory corruption in acpi_unmap_lsapic()
>   acpi_processor: do not mark present at boot but not onlined CPU as
>     onlined
>   x86: log error on secondary CPU wakeup failure at ERR level
>   x86: initialize secondary CPU only if master CPU will wait for it
> 
>  arch/x86/kernel/cpu/common.c  |   27 ++++++----
>  arch/x86/kernel/smpboot.c     |  103 ++++++++++++----------------------------
>  drivers/acpi/acpi_processor.c |    1 -
>  3 files changed, 47 insertions(+), 84 deletions(-)
> 


-- 
Regards,
  Igor
