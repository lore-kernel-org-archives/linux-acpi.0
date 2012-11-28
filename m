From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Acpi deadlocks with 3.7.0-rc4
Date: Wed, 28 Nov 2012 08:01:03 -0800
Message-ID: <CA+55aFyLMmKuEvY6T2=vSHp_R4=ndqFEFNJsc3Axze2vYknKhg@mail.gmail.com>
References: <50A513A8.9010404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A513A8.9010404@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zdenek Kabelac <zkabelac@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Adding more people (and the acpi list) to this report.

I'm seeing *very* few changes to the core suspend/resume path in 3.7,
and while there are some acpia updates, they seem to be pretty mild
too.

I think the acpi_os_wait_semaphore thing is a red herring - that's
just stale on the stack.

Do you have the register state from the oops? Or at least the "Code:"
line? It would be nice to see exactly where the oops happens, and I
cannot line up your "acpi_ns_lookup  + 0xa1/0x5b9" with any code due
to different compilers (and configurations etc).

               Linus


On Thu, Nov 15, 2012 at 8:09 AM, Zdenek Kabelac <zkabelac@redhat.com> wrote:
> Hello
>
>
> I've already seen twice this oops after resuming my Lenovo T61 in docking
> station.
>
> Since for some reason currently the serial line doesn't work correctly after
> resume
> (while I'm pretty sure it used to work in past) here is at least
> hand-written oops
> message from mobile camera picture.
>
> From the trace it seem os_wait semaphore is accessed twice.
> Unsure which device is behind it - but it seem docking station is need to
> hit this issue.
>
>
> kernel 3.7.0-rc4
>
> Pid:  pm-suspend
>
> RIP:   acpi_ns_lookup  + 0xa1/0x5b9
>
> Call Trace:
>
> ? acpi_os_wait_semaphore + 0x136/0x149
> acpi_ns_get_mode + 0x96/0x102
> ? __lock_is_held +0x5f/0x90
> acpi_ns_evaluate +0x47/0x2de
> ? _raw_spin_lock_irqsave
> ? acpi_ut_evaluate_object
> ? sub_preempt_count
> ? pnpacpi_can_wakeup
> acpi_rs_get_method_data
> ? acpi_os_signal_semaphore
> acpi_walk_resources
> ? acpi_ut_release_mutex
> pnpacpi_build_resource_template
> ? acpi_bus_get_device
> pnpacpi_set_resources
> ? pnp_device_shutdown
> pnp_start_dev
> pnp_bus_resume
> dpm_run_callback
> device_resume
> dpm_resume
> dpm_resume_end
> ? acpi_suspend_begin_old
> suspend_devices_and_enter
> pm_suspend
> state_store
> kobj_attr_store
> sysfs_write_file
> vgs_write
> sys_write
> system_call_fastpath
>
> Zdenek
>
>
> PS: jpg on request
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
