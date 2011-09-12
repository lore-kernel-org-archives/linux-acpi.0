From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 5/5] ACPI processor hotplug: Delay most initialization to
 cpu online
Date: Mon, 12 Sep 2011 17:16:27 -0600
Message-ID: <CAErSpo7JfpPrFUYdHviToY_9w7Fa9FApw3OXtxS9ctWzszx67Q@mail.gmail.com>
References: <1315784551-39118-1-git-send-email-trenn@suse.de> <1315784551-39118-6-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:26062 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab1ILXQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2011 19:16:51 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p8CNGnWN029904
	for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 16:16:49 -0700
Received: from gxk3 (gxk3.prod.google.com [10.202.11.3])
	by wpaz37.hot.corp.google.com with ESMTP id p8CNFPqv021669
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 16:16:48 -0700
Received: by gxk3 with SMTP id 3so648169gxk.14
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 16:16:47 -0700 (PDT)
In-Reply-To: <1315784551-39118-6-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Sun, Sep 11, 2011 at 4:42 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> When the CPU hotplug notification comes in via ACPI notify()
> cpu_data of the core is not yet initialized (the core did never
> get booted and set up).

I guess that when we handle the ACPI CPU add notification, we don't
automatically put the CPU online.  When *does* the CPU become online?
Does the user have to do something separate?  Is there a udev rule or
something that puts it online?  Why don't we automatically online it?
If we hot-add a PCI device, I don't think there's a separate step to
make it online, so I'm curious about why CPUs should be different.

I know I'm asking naive questions; I just don't know the expected flow
here.  The start() function was originally separate, and I combined it
with add() in 970b04929a6 because I think that will make it easier to
move the hotplug handling out of drivers and into the ACPI core.  ACPI
is unusual in that the driver ops have both .add() and .start() ops,
and in general I don't think they are both strictly necessary.  These
current patches reintroduce a start() function, but they do not
reintroduce use of the .start() driver entry point, so I'm not worried
about that.  I'm just trying to understand the difference between the
hot-add and online operations.

> This leads to errors in throttling and (if acpi_idle is used
> as cpuidle driver) to not set up cpu idle subsystem.
> -> Only bring up ACPI sysfs at that time
> -> Initialize the rest (throttling, cpuidle,...) when a hotplugged
> core is onlined the first time
>
> Sidenote:
> When starting on this, Xen patches were applied on the code base
> I worked on. I later realized that changing:
> static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int=
 *p_cpu);
> to only passing the processor object:
> static acpi_status acpi_processor_hotadd_init(struct acpi_processor *=
pr);
> came from Xen patches, but is convenient to have for physical cpu hot=
plugging
> and took that over.

I think it'd be nice to have this acpi_processor_hotadd_init()
interface change as a separate patch, especially since it overlaps a
Xen change.

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/processor_driver.c | =A0 75 +++++++++++++++++++++++++=
++++---------
> =A0include/acpi/processor.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A02 files changed, 58 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index 546951a..16f26b8 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -82,9 +82,9 @@ MODULE_LICENSE("GPL");
> =A0static int acpi_processor_add(struct acpi_device *device);
> =A0static int acpi_processor_remove(struct acpi_device *device, int t=
ype);
> =A0static void acpi_processor_notify(struct acpi_device *device, u32 =
event);
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, in=
t *p_cpu);
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor =
*pr);
> =A0static int acpi_processor_handle_eject(struct acpi_processor *pr);
> -
> +static int acpi_processor_start(struct acpi_processor *pr);
>
> =A0static const struct acpi_device_id processor_device_ids[] =3D {
> =A0 =A0 =A0 =A0{ACPI_PROCESSOR_OBJECT_HID, 0},
> @@ -324,10 +324,8 @@ static int acpi_processor_get_info(struct acpi_d=
evice *device)
> =A0 =A0 =A0 =A0 * =A0they are physically not present.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (pr->id =3D=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (acpi_processor_hotadd_init(pr-=
>handle, &pr->id))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(acpi_processor_hotadd_=
init(pr)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * On some boxes several processors use the same proce=
ssor bus id.
> @@ -425,10 +423,28 @@ static int acpi_cpu_soft_notify(struct notifier=
_block *nfb,
> =A0 =A0 =A0 =A0struct acpi_processor *pr =3D per_cpu(processors, cpu)=
;
>
> =A0 =A0 =A0 =A0if (action =3D=3D CPU_ONLINE && pr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_ppc_has_changed(pr, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_cst_has_changed(pr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_reevaluate_tstate(pr, ac=
tion);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_tstate_has_changed(pr);

I'm trying to figure out when this stuff (acpi_processor_ppc_has
changed(), _cst_has changed(), etc) now happens.  It used to happen
when a hot-added CPU came online.  Now it happens when a hot-added CPU
comes online *and* need_hotplug_init =3D=3D 0.  But need_hotplug_init i=
s
set to 1 in the acpi_processor_add() -> acpi_processor_get_info() ->
acpi_processor_hotadd_init() path.

And I don't understand this weird interaction of "idle driver is
intel_idle" with all of this.  If acpi_processor_ppc_has_changed(), et
al. are mutually exclusive with intel_idle, maybe we need a new idle
driver entry point or something.  As it is, this is kind of a mess.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CPU got hotplugged and onlined the f=
irst time
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Initialize missing things
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pr->flags.need_hotplug_init) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *=
idle_driver =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle=
_get_driver();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Will =
online and init hotplugged "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"CPU: %d=
\n", pr->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(acpi_processor_sta=
rt(pr), "Failed to start CPU:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " %d\n"=
, pr->id);

Maybe I'm the only one, but I think the acpi_processor_start() call is
easy to miss when it's inside the WARN().  I'd rather see something
like:

    ret =3D acpi_processor_start(pr);
    if (ret)
        dev_warn(...);

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr->flags.need_hotplug_=
init =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (idle_driver && !str=
cmp(idle_driver->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"intel_idle")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 intel_i=
dle_cpu_init(pr->id);

Checking the driver name here seems pretty ugly, and I think
intel_idle_cpu_init() is conditionally compiled, so it looks like this
will break if CONFIG_INTEL_IDLE=3Dn.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_ppc_has_=
changed(pr, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_cst_has_=
changed(pr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_reevalua=
te_tstate(pr, action);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_processor_tstate_h=
as_changed(pr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (action =3D=3D CPU_DEAD && pr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* invalidate the flag.throttling afte=
r one CPU is offline */
> @@ -442,7 +458,15 @@ static struct notifier_block acpi_cpu_notifier =3D
> =A0 =A0 =A0 =A0 =A0 =A0.notifier_call =3D acpi_cpu_soft_notify,
> =A0};
>
> -static int __cpuinit acpi_processor_start(struct acpi_processor *pr)
> +/*
> + * acpi_processor_start() is called by the cpu_hotplug_notifier func=
:
> + * acpi_cpu_soft_notify(). Getting it __cpuinit{data} is difficult, =
the
> + * root cause seem to be that acpi_processor_uninstall_hotplug_notif=
y()
> + * is in the module_exit (__exit) func. Allowing acpi_processor_star=
t()
> + * to not be in __cpuinit section, but being called from __cpuinit f=
uncs
> + * via __ref looks like the right thing to do here.
> + */
> +static __ref int acpi_processor_start(struct acpi_processor *pr)

This comment seems hand-wavey, and hence is a red flag :)  As I
understand it, __ref is for use when non-init code references init
data.  What initdata does acpi_processor_start() reference, and how do
we know that's always safe?  (Maybe you just need to remove the
__cpuinit/__ref annotation completely?)

> =A0{
> =A0 =A0 =A0 =A0struct acpi_device *device =3D per_cpu(processor_devic=
e_array, pr->id);
> =A0 =A0 =A0 =A0int result =3D 0;
> @@ -548,6 +572,13 @@ static int __cpuinit acpi_processor_add(struct a=
cpi_device *device)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -EFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_cpumask;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Do not start hotplugged CPUs now, but when they
> + =A0 =A0 =A0 =A0* are onlined the first time
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pr->flags.need_hotplug_init)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0result =3D acpi_processor_start(pr);
> =A0 =A0 =A0 =A0if (result)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_remove_sysfs;
> @@ -737,20 +768,28 @@ processor_walk_namespace_cb(acpi_handle handle,
> =A0 =A0 =A0 =A0return (AE_OK);
> =A0}
>
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, in=
t *p_cpu)
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor =
*pr)
> =A0{
> -
> - =A0 =A0 =A0 if (!is_processor_present(handle)) {
> + =A0 =A0 =A0 if (!is_processor_present(pr->handle))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return AE_ERROR;
> - =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 if (acpi_map_lsapic(handle, p_cpu))
> + =A0 =A0 =A0 if (acpi_map_lsapic(pr->handle, &pr->id))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return AE_ERROR;
>
> - =A0 =A0 =A0 if (arch_register_cpu(*p_cpu)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_unmap_lsapic(*p_cpu);
> + =A0 =A0 =A0 if (arch_register_cpu(pr->id)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_unmap_lsapic(pr->id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return AE_ERROR;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 /* CPU got hot-plugged, but cpu_data is not initialized=
 yet
> + =A0 =A0 =A0 =A0* Set flag to delay cpu_idle/throttling initializati=
on
> + =A0 =A0 =A0 =A0* in:
> + =A0 =A0 =A0 =A0* acpi_processor_add()
> + =A0 =A0 =A0 =A0* =A0 acpi_processor_get_info()
> + =A0 =A0 =A0 =A0* and do it when the CPU gets online the first time
> + =A0 =A0 =A0 =A0* TBD: Cleanup above functions and try to do this mo=
re elegant.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 printk(KERN_INFO "CPU %d got hotplugged\n", pr->id);
> + =A0 =A0 =A0 pr->flags.need_hotplug_init =3D 1;
>
> =A0 =A0 =A0 =A0return AE_OK;
> =A0}
> @@ -765,7 +804,7 @@ static int acpi_processor_handle_eject(struct acp=
i_processor *pr)
> =A0 =A0 =A0 =A0return (0);
> =A0}
> =A0#else
> -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, in=
t *p_cpu)
> +static acpi_status acpi_processor_hotadd_init(struct acpi_processor =
*pr)
> =A0{
> =A0 =A0 =A0 =A0return AE_ERROR;
> =A0}
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 67055f1..2a2d3ab 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -195,6 +195,7 @@ struct acpi_processor_flags {
> =A0 =A0 =A0 =A0u8 has_cst:1;
> =A0 =A0 =A0 =A0u8 power_setup_done:1;
> =A0 =A0 =A0 =A0u8 bm_rld_set:1;
> + =A0 =A0 =A0 u8 need_hotplug_init:1;
> =A0};
>
> =A0struct acpi_processor {
> --
> 1.7.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
