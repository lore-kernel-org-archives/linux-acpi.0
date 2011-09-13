From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] ACPI processor hotplug: Delay most initialization to cpu online
Date: Tue, 13 Sep 2011 14:40:22 +0200
Message-ID: <201109131440.23436.trenn@suse.de>
References: <1315784551-39118-1-git-send-email-trenn@suse.de> <1315784551-39118-6-git-send-email-trenn@suse.de> <CAErSpo7JfpPrFUYdHviToY_9w7Fa9FApw3OXtxS9ctWzszx67Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33646 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab1IMMk1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Sep 2011 08:40:27 -0400
In-Reply-To: <CAErSpo7JfpPrFUYdHviToY_9w7Fa9FApw3OXtxS9ctWzszx67Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday 13 September 2011 01:16:27 Bjorn Helgaas wrote:
> On Sun, Sep 11, 2011 at 4:42 PM, Thomas Renninger <trenn@suse.de> wrote:
> > When the CPU hotplug notification comes in via ACPI notify()
> > cpu_data of the core is not yet initialized (the core did never
> > get booted and set up).
> 
> I guess that when we handle the ACPI CPU add notification, we don't
> automatically put the CPU online.  When *does* the CPU become online?
echo 1 >/sys/devices/system/cpu/cpu[0-9]*/online
arch_register_cpu(*p_cpu)
only creates above sysfs entry.
The CPU is booted and set up when it gets online the first time.

> Does the user have to do something separate?  Is there a udev rule or
> something that puts it online?
Yes, I have a rule working, but there still seem to be a lock/race issue
, maybe related to microcode loading if the CPUs are onlined immediately.
I currently see about 1 minute delays between each core gets onlined
(only in udev "immediately online" case).

> Why don't we automatically online it?
> If we hot-add a PCI device, I don't think there's a separate step to
> make it online, so I'm curious about why CPUs should be different.
Looks like a systemwide (not x86) design for CPUs and memory as well.
Hm. One solution could be to add:
arch_prepare_cpu()
to the generic kernel layer which boots up and initializes the CPU in x86 case
, but still keep it (soft) offline.
Some code how this could be done pasted in the end. Not sure whether
the critical part of booting the core should get directly connected to the
hotplug event. Makes it at least more difficult to debug if things go wrong.

> I know I'm asking naive questions; I just don't know the expected flow
> here.
Sure.
It cost me some time to realize that the hotadd event (and the acpi bus
register) call could come from the container driver as well. I first wanted
to do it differently.

> The start() function was originally separate, and I combined it
> with add() in 970b04929a6 because I think that will make it easier to
> move the hotplug handling out of drivers and into the ACPI core.  ACPI
> is unusual in that the driver ops have both .add() and .start() ops,
> and in general I don't think they are both strictly necessary.  These
> current patches reintroduce a start() function, but they do not
> reintroduce use of the .start() driver entry point, so I'm not worried
> about that.  I'm just trying to understand the difference between the
> hot-add and online operations.
>
> > This leads to errors in throttling and (if acpi_idle is used
> > as cpuidle driver) to not set up cpu idle subsystem.
> > -> Only bring up ACPI sysfs at that time
> > -> Initialize the rest (throttling, cpuidle,...) when a hotplugged
> > core is onlined the first time
> >
> > Sidenote:
> > When starting on this, Xen patches were applied on the code base
> > I worked on. I later realized that changing:
> > static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
> > to only passing the processor object:
> > static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
> > came from Xen patches, but is convenient to have for physical cpu hotplugging
> > and took that over.
> 
> I think it'd be nice to have this acpi_processor_hotadd_init()
> interface change as a separate patch, especially since it overlaps a
> Xen change.
Makes sense.
 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: Len Brown <lenb@kernel.org>
> > CC: linux-acpi@vger.kernel.org
> > ---
> >  drivers/acpi/processor_driver.c |   75 +++++++++++++++++++++++++++++---------
> >  include/acpi/processor.h        |    1 +
> >  2 files changed, 58 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> > index 546951a..16f26b8 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -82,9 +82,9 @@ MODULE_LICENSE("GPL");
> >  static int acpi_processor_add(struct acpi_device *device);
> >  static int acpi_processor_remove(struct acpi_device *device, int type);
> >  static void acpi_processor_notify(struct acpi_device *device, u32 event);
> > -static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
> > +static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
> >  static int acpi_processor_handle_eject(struct acpi_processor *pr);
> > -
> > +static int acpi_processor_start(struct acpi_processor *pr);
> >
> >  static const struct acpi_device_id processor_device_ids[] = {
> >        {ACPI_PROCESSOR_OBJECT_HID, 0},
> > @@ -324,10 +324,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >         *  they are physically not present.
> >         */
> >        if (pr->id == -1) {
> > -               if (ACPI_FAILURE
> > -                   (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
> > +               if (ACPI_FAILURE(acpi_processor_hotadd_init(pr)))
> >                        return -ENODEV;
> > -               }
> >        }
> >        /*
> >         * On some boxes several processors use the same processor bus id.
> > @@ -425,10 +423,28 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
> >        struct acpi_processor *pr = per_cpu(processors, cpu);
> >
> >        if (action == CPU_ONLINE && pr) {
> > -               acpi_processor_ppc_has_changed(pr, 0);
> > -               acpi_processor_cst_has_changed(pr);
> > -               acpi_processor_reevaluate_tstate(pr, action);
> > -               acpi_processor_tstate_has_changed(pr);
> 
> I'm trying to figure out when this stuff (acpi_processor_ppc_has
> changed(), _cst_has changed(), etc) now happens.  It used to happen
> when a hot-added CPU came online.  Now it happens when a hot-added CPU
> comes online *and* need_hotplug_init == 0.  But need_hotplug_init is
> set to 1 in the acpi_processor_add() -> acpi_processor_get_info() ->
> acpi_processor_hotadd_init() path.
If a core is (soft) onlined:
If need_hotplug_init ==1, you have to initialize everything from scratch
-> call .start()
-> No need to check *_changed() states
If need_hotplug_init == 0
the core was already active/booted, just check for possibly changed state
info as before.
 
> And I don't understand this weird interaction of "idle driver is
> intel_idle" with all of this.  If acpi_processor_ppc_has_changed(), et
> al. are mutually exclusive with intel_idle, maybe we need a new idle
> driver entry point or something.  As it is, this is kind of a mess.
I agree that this could need some cleanup.
I'll wait a bit for further comments.
Hm, I agree that this patch needs more discussion.
Possibly the rest could get added already and I could come up
with a new version of this one and an additional cleanup patch
which addresses the already existing (intel_idle,..) things.
This would make things easier for me...

> > +               /* CPU got hotplugged and onlined the first time
> > +                * Initialize missing things
> > +                */
> > +               if (pr->flags.need_hotplug_init) {
> > +                       struct cpuidle_driver *idle_driver =
> > +                               cpuidle_get_driver();
> > +
> > +                       printk(KERN_INFO "Will online and init hotplugged "
> > +                              "CPU: %d\n", pr->id);
> > +                       WARN(acpi_processor_start(pr), "Failed to start CPU:"
> > +                               " %d\n", pr->id);
> 
> Maybe I'm the only one, but I think the acpi_processor_start() call is
> easy to miss when it's inside the WARN().  I'd rather see something
> like:
> 
>     ret = acpi_processor_start(pr);
>     if (ret)
>         dev_warn(...);
Ok.
 
> > +                       pr->flags.need_hotplug_init = 0;
> > +                       if (idle_driver && !strcmp(idle_driver->name,
> > +                                                  "intel_idle")) {
> > +                               intel_idle_cpu_init(pr->id);
> 
> Checking the driver name here seems pretty ugly, and I think
> intel_idle_cpu_init() is conditionally compiled, so it looks like this
> will break if CONFIG_INTEL_IDLE=n.
Should work, compare with patch 3/5:
+#ifdef CONFIG_INTEL_IDLE
+extern int intel_idle_cpu_init(int cpu);
 #else
+static inline int intel_idle_cpu_init(int cpu) { return -1; }
+#endif
+
+#else
+static inline int intel_idle_cpu_init(int cpu) { return -1; }

> 
> > +                       }
> > +               } else {
> > +                       acpi_processor_ppc_has_changed(pr, 0);
> > +                       acpi_processor_cst_has_changed(pr);
> > +                       acpi_processor_reevaluate_tstate(pr, action);
> > +                       acpi_processor_tstate_has_changed(pr);
> > +               }
> >        }
> >        if (action == CPU_DEAD && pr) {
> >                /* invalidate the flag.throttling after one CPU is offline */
> > @@ -442,7 +458,15 @@ static struct notifier_block acpi_cpu_notifier =
> >            .notifier_call = acpi_cpu_soft_notify,
> >  };
> >
> > -static int __cpuinit acpi_processor_start(struct acpi_processor *pr)
> > +/*
> > + * acpi_processor_start() is called by the cpu_hotplug_notifier func:
> > + * acpi_cpu_soft_notify(). Getting it __cpuinit{data} is difficult, the
> > + * root cause seem to be that acpi_processor_uninstall_hotplug_notify()
> > + * is in the module_exit (__exit) func. Allowing acpi_processor_start()
> > + * to not be in __cpuinit section, but being called from __cpuinit funcs
> > + * via __ref looks like the right thing to do here.
> > + */
> > +static __ref int acpi_processor_start(struct acpi_processor *pr)
> 
> This comment seems hand-wavey, and hence is a red flag :)  As I
> understand it, __ref is for use when non-init code references init
> data.  What initdata does acpi_processor_start() reference, and how do
> we know that's always safe?  (Maybe you just need to remove the
> __cpuinit/__ref annotation completely?)
Yep. I fear I have to remove quite some __cpuinit then.
I wasn't sure what the best way to handle this is, therefore the somewhat
longer comment.
But calling a non __init function from __init context should be safe?
That's what happens here and produces a warning if __ref is missing.


        Thomas

---
The flags should get unsigned at the end...:

 drivers/acpi/processor_driver.c |    2 ++
 drivers/base/cpu.c              |    2 ++
 include/linux/cpu.h             |    3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-3.0-SLE11-SP2-3.0/drivers/acpi/processor_driver.c
===================================================================
--- linux-3.0-SLE11-SP2-3.0.orig/drivers/acpi/processor_driver.c
+++ linux-3.0-SLE11-SP2-3.0/drivers/acpi/processor_driver.c
@@ -811,6 +811,8 @@ static acpi_status acpi_processor_hotadd
 	if (acpi_map_lsapic(handle, p_cpu))
 		return AE_ERROR;
 
+	per_cpu(cpu_devices, *p_cpu).cpu.hotplugged = 1;
+
 	if (arch_register_cpu(*p_cpu)) {
 		acpi_unmap_lsapic(*p_cpu);
 		return AE_ERROR;
Index: linux-3.0-SLE11-SP2-3.0/drivers/base/cpu.c
===================================================================
--- linux-3.0-SLE11-SP2-3.0.orig/drivers/base/cpu.c
+++ linux-3.0-SLE11-SP2-3.0/drivers/base/cpu.c
@@ -224,6 +224,8 @@ int __cpuinit register_cpu(struct cpu *c
 
 	error = sysdev_register(&cpu->sysdev);
 
+	if (!error && cpu->hotplugged)
+		{ /* arch_prepare_cpu() -> boot up and init CPU if necessary */ }
 	if (!error && cpu->hotpluggable)
 		register_cpu_control(cpu);
 	if (!error)
Index: linux-3.0-SLE11-SP2-3.0/include/linux/cpu.h
===================================================================
--- linux-3.0-SLE11-SP2-3.0.orig/include/linux/cpu.h
+++ linux-3.0-SLE11-SP2-3.0/include/linux/cpu.h
@@ -21,7 +21,8 @@
 
 struct cpu {
 	int node_id;		/* The node which contains the CPU */
-	int hotpluggable;	/* creates sysfs control file if hotpluggable */
+	int hotpluggable:1;	/* creates sysfs control file if hotpluggable */
+	int hotplugged:1;	/* will boot the cpu if registered */
 	struct sys_device sysdev;
 };
 
