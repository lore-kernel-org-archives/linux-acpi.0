From: liu ping fan <qemulist@gmail.com>
Subject: Re: [PATCH 2/2] LAPIC: make lapic support cpu hotplug
Date: Wed, 5 Oct 2011 18:26:03 +0800
Message-ID: <CAJnKYQn69-CcUZRHFZgeB=PQj43kTQmSEpE=XTz3LHWNMQTKnQ@mail.gmail.com>
References: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
	<1317726818-8514-4-git-send-email-pingfank@linux.vnet.com>
	<4E8B3794.9040301@web.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf307ca03092c59a04ae8aa271
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4E8B3794.9040301@web.de>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: aliguori@us.ibm.com, pingfank@linux.vnet.ibm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ryanh@us.ibm.com, shaohua.li@intel.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

--20cf307ca03092c59a04ae8aa271
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 5, 2011 at 12:43 AM, Jan Kiszka <jan.kiszka@web.de> wrote:

> On 2011-10-04 13:13, pingfank@linux.vnet.com wrote:
> > From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> >
> > Separate apic from qbus to icc bus which supports hotplug feature.
>
> Modeling the ICC bus looks like a step in the right direction. The
> IOAPIC could be attached to it as well to get rid of
> "ioapics[MAX_IOAPICS]".


Yes, but it will be the next step.  But I introduce it because with current
code,
the hotplug creation of apic instance by apic_init() will hit the following
assert
 "qdev_create_from_info: Assertion `bus->allow_hotplug' failed."
So I want to separate apic and create ICC-bus which connects LAPICs
together.
Most of all, it can support hotplug just like we can hotplug x86 physical
CPU in real machine.



>  > And make the creation of apic as part of cpu initialization, so
> > apic's state has been ready, before setting kvm_apic.
>
> There is no kvm-apic upstream yet, so it's hard to judge why we need
> this here. If we do, this has to be a separate patch. But I seriously
> doubt we need it (my hack worked without it, and that was not because of
> its hack nature).
>
> Sorry, I did not explain it clearly. What I mean is that =93env->apic_sta=
te=94
must be prepared
before qemu_kvm_cpu_thread_fn() -> ... -> kvm_put_sregs(), where we get
apic_base by
=93 sregs.apic_base =3D cpu_get_apic_base(env->apic_state);=94
and then call =93kvm_vcpu_ioctl(env, KVM_SET_SREGS, &sregs);=94 which will
finally affect the
kvm_apic structure in kernel.

But as current code, in pc_new_cpu(), we call apic_init() to initialize
apic_state, after cpu_init(),
so we can not guarantee the order of apic_state initializaion and the
setting to kernel.

Because LAPIC is part of x86 chip, I want to move it into cpu_x86_init(),
and ensure apic_init()
called before thread =93qemu_kvm_cpu_thread_fn()=94 creation.

 >
> > Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> > ---
> >  Makefile.target      |    1 +
> >  hw/apic.c            |    7 ++++-
> >  hw/apic.h            |    1 +
> >  hw/icc_bus.c         |   62
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/icc_bus.h         |   24 +++++++++++++++++++
> >  hw/pc.c              |   11 ++++-----
> >  target-i386/cpu.h    |    1 +
> >  target-i386/helper.c |    7 +++++-
> >  target-i386/kvm.c    |    1 -
> >  9 files changed, 105 insertions(+), 10 deletions(-)
> >  create mode 100644 hw/icc_bus.c
> >  create mode 100644 hw/icc_bus.h
> >
> > diff --git a/Makefile.target b/Makefile.target
> > index 9011f28..5607c6d 100644
> > --- a/Makefile.target
> > +++ b/Makefile.target
> > @@ -241,6 +241,7 @@ obj-i386-$(CONFIG_KVM) +=3D kvmclock.o
> >  obj-i386-$(CONFIG_SPICE) +=3D qxl.o qxl-logger.o qxl-render.o
> >  obj-i386-y +=3D testdev.o
> >  obj-i386-y +=3D acpi.o acpi_piix4.o
> > +obj-i386-y +=3D icc_bus.o
> >
> >  obj-i386-y +=3D pcspk.o i8254.o
> >  obj-i386-$(CONFIG_KVM_PIT) +=3D i8254-kvm.o
> > diff --git a/hw/apic.c b/hw/apic.c
> > index 69d6ac5..95a1664 100644
> > --- a/hw/apic.c
> > +++ b/hw/apic.c
> > @@ -24,6 +24,7 @@
> >  #include "sysbus.h"
> >  #include "trace.h"
> >  #include "kvm.h"
> > +#include "icc_bus.h"
> >
> >  /* APIC Local Vector Table */
> >  #define APIC_LVT_TIMER   0
> > @@ -304,11 +305,13 @@ void cpu_set_apic_base(DeviceState *d, uint64_t
> val)
> >
> >      if (!s)
> >          return;
> > +
> >      if (kvm_enabled() && kvm_irqchip_in_kernel())
> >          s->apicbase =3D val;
> >      else
> >          s->apicbase =3D (val & 0xfffff000) |
> >              (s->apicbase & (MSR_IA32_APICBASE_BSP |
> MSR_IA32_APICBASE_ENABLE));
> > +
> >      /* if disabled, cannot be enabled again */
> >      if (!(val & MSR_IA32_APICBASE_ENABLE)) {
> >          s->apicbase &=3D ~MSR_IA32_APICBASE_ENABLE;
> > @@ -1075,7 +1078,7 @@ static const VMStateDescription vmstate_apic =3D =
{
> >      }
> >  };
> >
> > -static void apic_reset(DeviceState *d)
> > +void apic_reset(DeviceState *d)
>
> Still unused outside of this file, so keep it private.
>
> >  {
> >      APICState *s =3D DO_UPCAST(APICState, busdev.qdev, d);
> >      int bsp;
> > @@ -1138,7 +1141,7 @@ static SysBusDeviceInfo apic_info =3D {
> >
> >  static void apic_register_devices(void)
> >  {
> > -    sysbus_register_withprop(&apic_info);
> > +    iccbus_register(&apic_info);
> >  }
> >
> >  device_init(apic_register_devices)
> > diff --git a/hw/apic.h b/hw/apic.h
> > index c857d52..e258efa 100644
> > --- a/hw/apic.h
> > +++ b/hw/apic.h
> > @@ -24,5 +24,6 @@ void apic_sipi(DeviceState *s);
> >  /* pc.c */
> >  int cpu_is_bsp(CPUState *env);
> >  DeviceState *cpu_get_current_apic(void);
> > +void apic_reset(DeviceState *d);
> >
> >  #endif
> > diff --git a/hw/icc_bus.c b/hw/icc_bus.c
> > new file mode 100644
> > index 0000000..360ca2a
> > --- /dev/null
> > +++ b/hw/icc_bus.c
> > @@ -0,0 +1,62 @@
> > +/*
> > +*/
> > +#define ICC_BUS_PLUG
> > +#ifdef ICC_BUS_PLUG
> > +#include "icc_bus.h"
> > +
> > +
> > +
> > +struct icc_bus_info icc_info =3D {
> > +    .qinfo.name =3D "icc",
> > +    .qinfo.size =3D sizeof(struct icc_bus),
> > +    .qinfo.props =3D (Property[]) {
> > +        DEFINE_PROP_END_OF_LIST(),
> > +    }
> > +
> > +};
> > +
> > +
> > +static const VMStateDescription vmstate_icc_bus =3D {
> > +    .name =3D "icc_bus",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .minimum_version_id_old =3D 1,
> > +    .pre_save =3D NULL,
> > +    .post_load =3D NULL,
> > +};
> > +
> > +struct icc_bus *g_iccbus;
> > +
> > +struct icc_bus *icc_init_bus(DeviceState *parent, const char *name)
> > +{
> > +    struct icc_bus *bus;
> > +
> > +    bus =3D FROM_QBUS(icc_bus, qbus_create(&icc_info.qinfo, parent,
> name));
> > +    bus->qbus.allow_hotplug =3D 1; /* Yes, we can */
> > +    bus->qbus.name =3D "icc";
> > +    vmstate_register(NULL, -1, &vmstate_icc_bus, bus);
>
> The chipset is the owner of this bus and instantiates it. So it also
> provides a vmstate. You can drop this unneeded one here (it's created
> via an obsolete API anyway).
>

No familiar with Qemu bus emulation, keep on learning :) . But what I
thought is,
the x86-ICC bus is not the same as bus like PCI.
For a PCI bus, it lies behind a host bridge, but ICC is shared by all x86
processors in SMP system,
so there is not a outstanding owner.  And I right?

>
> > +    g_iccbus =3D bus;
> > +    return bus;
> > +}
> > +
> > +
> > +
> > +
> > +
> > +static int iccbus_device_init(DeviceState *dev, DeviceInfo *base)
> > +{
> > +    SysBusDeviceInfo *info =3D container_of(base, SysBusDeviceInfo, qd=
ev);
> > +
> > +    return info->init(sysbus_from_qdev(dev));
> > +}
> > +
> > +void iccbus_register(SysBusDeviceInfo *info)
> > +{
> > +    info->qdev.init =3D iccbus_device_init;
> > +    info->qdev.bus_info =3D &icc_info.qinfo;
> > +
> > +    assert(info->qdev.size >=3D sizeof(SysBusDevice));
> > +    qdev_register(&info->qdev);
> > +}
>
> This service should be unneeded when the bus is properly embedded into
> its parent (ie. the chipset).
>
> > +
> > +#endif
> > diff --git a/hw/icc_bus.h b/hw/icc_bus.h
> > new file mode 100644
> > index 0000000..94d9242
> > --- /dev/null
> > +++ b/hw/icc_bus.h
> > @@ -0,0 +1,24 @@
> > +#ifndef QEMU_ICC_H
> > +#define QEMU_ICC_H
> > +
> > +#include "qdev.h"
> > +#include "sysbus.h"
> > +
> > +typedef struct icc_bus icc_bus;
> > +typedef struct icc_bus_info icc_bus_info;
> > +
> > +
> > +struct icc_bus {
> > +    BusState qbus;
> > +};
> > +
> > +struct icc_bus_info {
> > +    BusInfo qinfo;
> > +};
> > +
> > +extern struct icc_bus_info icc_info;
> > +extern struct icc_bus *g_iccbus;
> > +extern struct icc_bus *icc_init_bus(DeviceState *parent, const char
> *name);
> > +extern void iccbus_register(SysBusDeviceInfo *info);
> > +
> > +#endif
> > diff --git a/hw/pc.c b/hw/pc.c
> > index 6b3662e..10371d8 100644
> > --- a/hw/pc.c
> > +++ b/hw/pc.c
> > @@ -24,6 +24,7 @@
> >  #include "hw.h"
> >  #include "pc.h"
> >  #include "apic.h"
> > +#include "icc_bus.h"
> >  #include "fdc.h"
> >  #include "ide.h"
> >  #include "pci.h"
> > @@ -91,6 +92,7 @@ struct e820_table {
> >  static struct e820_table e820_table;
> >  struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
> >
> > +
> >  void isa_irq_handler(void *opaque, int n, int level)
> >  {
> >      IsaIrqState *isa =3D (IsaIrqState *)opaque;
> > @@ -872,13 +874,13 @@ DeviceState *cpu_get_current_apic(void)
> >      }
> >  }
> >
> > -static DeviceState *apic_init(void *env, uint8_t apic_id)
> > +DeviceState *apic_init(void *env, uint8_t apic_id)
> >  {
> >      DeviceState *dev;
> >      SysBusDevice *d;
> >      static int apic_mapped;
> >
> > -    dev =3D qdev_create(NULL, "apic");
> > +    dev =3D qdev_create(&g_iccbus->qbus, "apic");
> >      qdev_prop_set_uint8(dev, "id", apic_id);
> >      qdev_prop_set_ptr(dev, "cpu_env", env);
> >      qdev_init_nofail(dev);
> > @@ -943,10 +945,6 @@ CPUState *pc_new_cpu(const char *cpu_model)
> >          fprintf(stderr, "Unable to find x86 CPU definition\n");
> >          exit(1);
> >      }
> > -    if ((env->cpuid_features & CPUID_APIC) || smp_cpus > 1) {
> > -        env->cpuid_apic_id =3D env->cpu_index;
> > -        env->apic_state =3D apic_init(env, env->cpuid_apic_id);
> > -    }
> >      qemu_register_reset(pc_cpu_reset, env);
> >      pc_cpu_reset(env);
> >      return env;
> > @@ -956,6 +954,7 @@ void pc_cpus_init(const char *cpu_model)
> >  {
> >      int i;
> >
> > +    icc_init_bus(NULL, "icc");
> >      /* init CPUs */
> >      for(i =3D 0; i < smp_cpus; i++) {
> >          pc_new_cpu(cpu_model);
> > diff --git a/target-i386/cpu.h b/target-i386/cpu.h
> > index 2a071f2..0160c55 100644
> > --- a/target-i386/cpu.h
> > +++ b/target-i386/cpu.h
> > @@ -1062,4 +1062,5 @@ void svm_check_intercept(CPUState *env1, uint32_t
> type);
> >
> >  uint32_t cpu_cc_compute_all(CPUState *env1, int op);
> >
> > +extern DeviceState *apic_init(void *env, uint8_t apic_id);
> >  #endif /* CPU_I386_H */
> > diff --git a/target-i386/helper.c b/target-i386/helper.c
> > index 5df40d4..551a8a2 100644
> > --- a/target-i386/helper.c
> > +++ b/target-i386/helper.c
> > @@ -30,6 +30,7 @@
> >  #include "monitor.h"
> >  #endif
> >
> > +
> >  //#define DEBUG_MMU
> >
> >  /* NOTE: must be called outside the CPU execute loop */
> > @@ -1257,7 +1258,11 @@ CPUX86State *cpu_x86_init(const char *cpu_model)
> >          return NULL;
> >      }
> >      mce_init(env);
> > -
> > +    if ((env->cpuid_features & CPUID_APIC)
> > +        || smp_cpus > 1) {
> > +        env->cpuid_apic_id =3D env->cpu_index;
> > +        env->apic_state =3D apic_init(env, env->cpuid_apic_id);
> > +    }
> >      qemu_init_vcpu(env);
> >
> >      return env;
> > diff --git a/target-i386/kvm.c b/target-i386/kvm.c
> > index 571d792..407dba6 100644
> > --- a/target-i386/kvm.c
> > +++ b/target-i386/kvm.c
> > @@ -880,7 +880,6 @@ static int kvm_put_sregs(CPUState *env)
> >
> >      sregs.cr8 =3D cpu_get_apic_tpr(env->apic_state);
> >      sregs.apic_base =3D cpu_get_apic_base(env->apic_state);
> > -
> >      sregs.efer =3D env->efer;
> >
> >      return kvm_vcpu_ioctl(env, KVM_SET_SREGS, &sregs);
>
> Would be good to see the full series, i.e. everything that is required
> to make CPU hotplug work. First for QEMU upstream without in-kernel
> irqchips and then the qemu-kvm bits.
>
> OK, I will try that.

Thanks and regards,
ping fan



> Jan
>
>

--20cf307ca03092c59a04ae8aa271
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Oct 5, 2011 at 12:43 AM, Jan Kis=
zka <span dir=3D"ltr">&lt;<a href=3D"mailto:jan.kiszka@web.de" target=3D"_b=
lank">jan.kiszka@web.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(204,=
 204, 204); padding-left: 1ex;">

<div>On 2011-10-04 13:13, <a href=3D"mailto:pingfank@linux.vnet.com" target=
=3D"_blank">pingfank@linux.vnet.com</a> wrote:<br>
&gt; From: Liu Ping Fan &lt;<a href=3D"mailto:pingfank@linux.vnet.ibm.com" =
target=3D"_blank">pingfank@linux.vnet.ibm.com</a>&gt;<br>
&gt;<br>
&gt; Separate apic from qbus to icc bus which supports hotplug feature.<br>
<br>
</div>Modeling the ICC bus looks like a step in the right direction. The<br=
>
IOAPIC could be attached to it as well to get rid of &quot;ioapics[MAX_IOAP=
ICS]&quot;.</blockquote><div><br></div><div>Yes, but it will be the next st=
ep.=A0 But I introduce it because with current code, <br>the hotplug creati=
on of apic instance by apic_init() will hit the following assert<br>
=A0&quot;qdev_create_from_info: Assertion
`bus-&gt;allow_hotplug&#39; failed.&quot;=A0 <br>So I want to separate apic=
 and create ICC-bus which connects LAPICs together. <br>Most of all, it can=
 support hotplug just like we can hotplug x86 physical CPU in real machine.=
=A0 <br>
</div>

=09
=09
=09


<div>=A0=A0=A0=A0</div><div>=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204); =
padding-left: 1ex;">
<div>
&gt; And make the creation of apic as part of cpu initialization, so<br>
&gt; apic&#39;s state has been ready, before setting kvm_apic.<br>
<br>
</div>There is no kvm-apic upstream yet, so it&#39;s hard to judge why we n=
eed<br>
this here. If we do, this has to be a separate patch. But I seriously<br>
doubt we need it (my hack worked without it, and that was not because of<br=
>
its hack nature).<br>
<div><div></div><div><br></div></div></blockquote>


=09
=09
=09
	<style type=3D"text/css">p { margin-bottom: 0.08in; }</style>Sorry, I did =
not explain it clearly. What I mean is that =93env-&gt;apic_state=94 must b=
e prepared<br>before qemu_kvm_cpu_thread_fn() -&gt; ... -&gt; kvm_put_sregs=
(), where we get apic_base by<br>
=93 sregs.apic_base =3D cpu_get_apic_base(env-&gt;apic_state);=94<br>and th=
en call =93kvm_vcpu_ioctl(env, KVM_SET_SREGS, &amp;sregs);=94 which will fi=
nally affect the <br>kvm_apic structure in kernel.<br><br>But as current co=
de, in pc_new_cpu(), we call apic_init() to initialize apic_state, after cp=
u_init(),<br>
so we can not guarantee the order of apic_state initializaion and the setti=
ng to kernel.<br><br>Because LAPIC is part of x86 chip, I want to move it i=
nto cpu_x86_init(), and ensure apic_init()<br>called before thread =93qemu_=
kvm_cpu_thread_fn()=94 creation.<br>
<br><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; b=
order-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div>
&gt;<br>
&gt; Signed-off-by: Liu Ping Fan &lt;<a href=3D"mailto:pingfank@linux.vnet.=
ibm.com" target=3D"_blank">pingfank@linux.vnet.ibm.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0Makefile.target =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0hw/apic.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++++-<br>
&gt; =A0hw/apic.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0hw/icc_bus.c =A0 =A0 =A0 =A0 | =A0 62 +++++++++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt; =A0hw/icc_bus.h =A0 =A0 =A0 =A0 | =A0 24 +++++++++++++++++++<br>
&gt; =A0hw/pc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ++++-----<br>
&gt; =A0target-i386/cpu.h =A0 =A0| =A0 =A01 +<br>
&gt; =A0target-i386/helper.c | =A0 =A07 +++++-<br>
&gt; =A0target-i386/kvm.c =A0 =A0| =A0 =A01 -<br>
&gt; =A09 files changed, 105 insertions(+), 10 deletions(-)<br>
&gt; =A0create mode 100644 hw/icc_bus.c<br>
&gt; =A0create mode 100644 hw/icc_bus.h<br>
&gt;<br>
&gt; diff --git a/Makefile.target b/Makefile.target<br>
&gt; index 9011f28..5607c6d 100644<br>
&gt; --- a/Makefile.target<br>
&gt; +++ b/Makefile.target<br>
&gt; @@ -241,6 +241,7 @@ obj-i386-$(CONFIG_KVM) +=3D kvmclock.o<br>
&gt; =A0obj-i386-$(CONFIG_SPICE) +=3D qxl.o qxl-logger.o qxl-render.o<br>
&gt; =A0obj-i386-y +=3D testdev.o<br>
&gt; =A0obj-i386-y +=3D acpi.o acpi_piix4.o<br>
&gt; +obj-i386-y +=3D icc_bus.o<br>
&gt;<br>
&gt; =A0obj-i386-y +=3D pcspk.o i8254.o<br>
&gt; =A0obj-i386-$(CONFIG_KVM_PIT) +=3D i8254-kvm.o<br>
&gt; diff --git a/hw/apic.c b/hw/apic.c<br>
&gt; index 69d6ac5..95a1664 100644<br>
&gt; --- a/hw/apic.c<br>
&gt; +++ b/hw/apic.c<br>
&gt; @@ -24,6 +24,7 @@<br>
&gt; =A0#include &quot;sysbus.h&quot;<br>
&gt; =A0#include &quot;trace.h&quot;<br>
&gt; =A0#include &quot;kvm.h&quot;<br>
&gt; +#include &quot;icc_bus.h&quot;<br>
&gt;<br>
&gt; =A0/* APIC Local Vector Table */<br>
&gt; =A0#define APIC_LVT_TIMER =A0 0<br>
&gt; @@ -304,11 +305,13 @@ void cpu_set_apic_base(DeviceState *d, uint64_t =
val)<br>
&gt;<br>
&gt; =A0 =A0 =A0if (!s)<br>
&gt; =A0 =A0 =A0 =A0 =A0return;<br>
&gt; +<br>
&gt; =A0 =A0 =A0if (kvm_enabled() &amp;&amp; kvm_irqchip_in_kernel())<br>
&gt; =A0 =A0 =A0 =A0 =A0s-&gt;apicbase =3D val;<br>
&gt; =A0 =A0 =A0else<br>
&gt; =A0 =A0 =A0 =A0 =A0s-&gt;apicbase =3D (val &amp; 0xfffff000) |<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0(s-&gt;apicbase &amp; (MSR_IA32_APICBASE_BS=
P | MSR_IA32_APICBASE_ENABLE));<br>
&gt; +<br>
&gt; =A0 =A0 =A0/* if disabled, cannot be enabled again */<br>
&gt; =A0 =A0 =A0if (!(val &amp; MSR_IA32_APICBASE_ENABLE)) {<br>
&gt; =A0 =A0 =A0 =A0 =A0s-&gt;apicbase &amp;=3D ~MSR_IA32_APICBASE_ENABLE;<=
br>
&gt; @@ -1075,7 +1078,7 @@ static const VMStateDescription vmstate_apic =3D=
 {<br>
&gt; =A0 =A0 =A0}<br>
&gt; =A0};<br>
&gt;<br>
&gt; -static void apic_reset(DeviceState *d)<br>
&gt; +void apic_reset(DeviceState *d)<br>
<br>
</div></div>Still unused outside of this file, so keep it private.<br>
<div><div></div><div><br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0APICState *s =3D DO_UPCAST(APICState, busdev.qdev, d);<br>
&gt; =A0 =A0 =A0int bsp;<br>
&gt; @@ -1138,7 +1141,7 @@ static SysBusDeviceInfo apic_info =3D {<br>
&gt;<br>
&gt; =A0static void apic_register_devices(void)<br>
&gt; =A0{<br>
&gt; - =A0 =A0sysbus_register_withprop(&amp;apic_info);<br>
&gt; + =A0 =A0iccbus_register(&amp;apic_info);<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0device_init(apic_register_devices)<br>
&gt; diff --git a/hw/apic.h b/hw/apic.h<br>
&gt; index c857d52..e258efa 100644<br>
&gt; --- a/hw/apic.h<br>
&gt; +++ b/hw/apic.h<br>
&gt; @@ -24,5 +24,6 @@ void apic_sipi(DeviceState *s);<br>
&gt; =A0/* pc.c */<br>
&gt; =A0int cpu_is_bsp(CPUState *env);<br>
&gt; =A0DeviceState *cpu_get_current_apic(void);<br>
&gt; +void apic_reset(DeviceState *d);<br>
&gt;<br>
&gt; =A0#endif<br>
&gt; diff --git a/hw/icc_bus.c b/hw/icc_bus.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..360ca2a<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/icc_bus.c<br>
&gt; @@ -0,0 +1,62 @@<br>
&gt; +/*<br>
&gt; +*/<br>
&gt; +#define ICC_BUS_PLUG<br>
&gt; +#ifdef ICC_BUS_PLUG<br>
&gt; +#include &quot;icc_bus.h&quot;<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +struct icc_bus_info icc_info =3D {<br>
&gt; + =A0 =A0.<a href=3D"http://qinfo.name" target=3D"_blank">qinfo.name</=
a> =3D &quot;icc&quot;,<br>
&gt; + =A0 =A0.qinfo.size =3D sizeof(struct icc_bus),<br>
&gt; + =A0 =A0.qinfo.props =3D (Property[]) {<br>
&gt; + =A0 =A0 =A0 =A0DEFINE_PROP_END_OF_LIST(),<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_icc_bus =3D {<br>
&gt; + =A0 =A0.name =3D &quot;icc_bus&quot;,<br>
&gt; + =A0 =A0.version_id =3D 1,<br>
&gt; + =A0 =A0.minimum_version_id =3D 1,<br>
&gt; + =A0 =A0.minimum_version_id_old =3D 1,<br>
&gt; + =A0 =A0.pre_save =3D NULL,<br>
&gt; + =A0 =A0.post_load =3D NULL,<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct icc_bus *g_iccbus;<br>
&gt; +<br>
&gt; +struct icc_bus *icc_init_bus(DeviceState *parent, const char *name)<b=
r>
&gt; +{<br>
&gt; + =A0 =A0struct icc_bus *bus;<br>
&gt; +<br>
&gt; + =A0 =A0bus =3D FROM_QBUS(icc_bus, qbus_create(&amp;icc_info.qinfo, p=
arent, name));<br>
&gt; + =A0 =A0bus-&gt;qbus.allow_hotplug =3D 1; /* Yes, we can */<br>
&gt; + =A0 =A0bus-&gt;<a href=3D"http://qbus.name" target=3D"_blank">qbus.n=
ame</a> =3D &quot;icc&quot;;<br>
&gt; + =A0 =A0vmstate_register(NULL, -1, &amp;vmstate_icc_bus, bus);<br>
<br>
</div></div>The chipset is the owner of this bus and instantiates it. So it=
 also<br>
provides a vmstate. You can drop this unneeded one here (it&#39;s created<b=
r>
via an obsolete API anyway).<br></blockquote><div><br>No familiar with Qemu=
 bus emulation, keep on learning :) . But what I thought is, <br>the x86-IC=
C bus is not the same as bus like PCI.<br>For a PCI bus, it lies behind a h=
ost bridge, but ICC is shared by all x86 processors in SMP system, <br>
so there is not a outstanding owner.=A0 And I right?<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px s=
olid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0g_iccbus =3D bus;<br>
&gt; + =A0 =A0return bus;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +static int iccbus_device_init(DeviceState *dev, DeviceInfo *base)<br>
&gt; +{<br>
&gt; + =A0 =A0SysBusDeviceInfo *info =3D container_of(base, SysBusDeviceInf=
o, qdev);<br>
&gt; +<br>
&gt; + =A0 =A0return info-&gt;init(sysbus_from_qdev(dev));<br>
&gt; +}<br>
&gt; +<br>
&gt; +void iccbus_register(SysBusDeviceInfo *info)<br>
&gt; +{<br>
&gt; + =A0 =A0info-&gt;qdev.init =3D iccbus_device_init;<br>
&gt; + =A0 =A0info-&gt;qdev.bus_info =3D &amp;icc_info.qinfo;<br>
&gt; +<br>
&gt; + =A0 =A0assert(info-&gt;qdev.size &gt;=3D sizeof(SysBusDevice));<br>
&gt; + =A0 =A0qdev_register(&amp;info-&gt;qdev);<br>
&gt; +}<br>
<br>
</div>This service should be unneeded when the bus is properly embedded int=
o<br>
its parent (ie. the chipset).<br>
<div><div></div><div><br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/hw/icc_bus.h b/hw/icc_bus.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..94d9242<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/icc_bus.h<br>
&gt; @@ -0,0 +1,24 @@<br>
&gt; +#ifndef QEMU_ICC_H<br>
&gt; +#define QEMU_ICC_H<br>
&gt; +<br>
&gt; +#include &quot;qdev.h&quot;<br>
&gt; +#include &quot;sysbus.h&quot;<br>
&gt; +<br>
&gt; +typedef struct icc_bus icc_bus;<br>
&gt; +typedef struct icc_bus_info icc_bus_info;<br>
&gt; +<br>
&gt; +<br>
&gt; +struct icc_bus {<br>
&gt; + =A0 =A0BusState qbus;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct icc_bus_info {<br>
&gt; + =A0 =A0BusInfo qinfo;<br>
&gt; +};<br>
&gt; +<br>
&gt; +extern struct icc_bus_info icc_info;<br>
&gt; +extern struct icc_bus *g_iccbus;<br>
&gt; +extern struct icc_bus *icc_init_bus(DeviceState *parent, const char *=
name);<br>
&gt; +extern void iccbus_register(SysBusDeviceInfo *info);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/hw/pc.c b/hw/pc.c<br>
&gt; index 6b3662e..10371d8 100644<br>
&gt; --- a/hw/pc.c<br>
&gt; +++ b/hw/pc.c<br>
&gt; @@ -24,6 +24,7 @@<br>
&gt; =A0#include &quot;hw.h&quot;<br>
&gt; =A0#include &quot;pc.h&quot;<br>
&gt; =A0#include &quot;apic.h&quot;<br>
&gt; +#include &quot;icc_bus.h&quot;<br>
&gt; =A0#include &quot;fdc.h&quot;<br>
&gt; =A0#include &quot;ide.h&quot;<br>
&gt; =A0#include &quot;pci.h&quot;<br>
&gt; @@ -91,6 +92,7 @@ struct e820_table {<br>
&gt; =A0static struct e820_table e820_table;<br>
&gt; =A0struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};<br>
&gt;<br>
&gt; +<br>
&gt; =A0void isa_irq_handler(void *opaque, int n, int level)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0IsaIrqState *isa =3D (IsaIrqState *)opaque;<br>
&gt; @@ -872,13 +874,13 @@ DeviceState *cpu_get_current_apic(void)<br>
&gt; =A0 =A0 =A0}<br>
&gt; =A0}<br>
&gt;<br>
&gt; -static DeviceState *apic_init(void *env, uint8_t apic_id)<br>
&gt; +DeviceState *apic_init(void *env, uint8_t apic_id)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0DeviceState *dev;<br>
&gt; =A0 =A0 =A0SysBusDevice *d;<br>
&gt; =A0 =A0 =A0static int apic_mapped;<br>
&gt;<br>
&gt; - =A0 =A0dev =3D qdev_create(NULL, &quot;apic&quot;);<br>
&gt; + =A0 =A0dev =3D qdev_create(&amp;g_iccbus-&gt;qbus, &quot;apic&quot;)=
;<br>
&gt; =A0 =A0 =A0qdev_prop_set_uint8(dev, &quot;id&quot;, apic_id);<br>
&gt; =A0 =A0 =A0qdev_prop_set_ptr(dev, &quot;cpu_env&quot;, env);<br>
&gt; =A0 =A0 =A0qdev_init_nofail(dev);<br>
&gt; @@ -943,10 +945,6 @@ CPUState *pc_new_cpu(const char *cpu_model)<br>
&gt; =A0 =A0 =A0 =A0 =A0fprintf(stderr, &quot;Unable to find x86 CPU defini=
tion\n&quot;);<br>
&gt; =A0 =A0 =A0 =A0 =A0exit(1);<br>
&gt; =A0 =A0 =A0}<br>
&gt; - =A0 =A0if ((env-&gt;cpuid_features &amp; CPUID_APIC) || smp_cpus &gt=
; 1) {<br>
&gt; - =A0 =A0 =A0 =A0env-&gt;cpuid_apic_id =3D env-&gt;cpu_index;<br>
&gt; - =A0 =A0 =A0 =A0env-&gt;apic_state =3D apic_init(env, env-&gt;cpuid_a=
pic_id);<br>
&gt; - =A0 =A0}<br>
&gt; =A0 =A0 =A0qemu_register_reset(pc_cpu_reset, env);<br>
&gt; =A0 =A0 =A0pc_cpu_reset(env);<br>
&gt; =A0 =A0 =A0return env;<br>
&gt; @@ -956,6 +954,7 @@ void pc_cpus_init(const char *cpu_model)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0int i;<br>
&gt;<br>
&gt; + =A0 =A0icc_init_bus(NULL, &quot;icc&quot;);<br>
&gt; =A0 =A0 =A0/* init CPUs */<br>
&gt; =A0 =A0 =A0for(i =3D 0; i &lt; smp_cpus; i++) {<br>
&gt; =A0 =A0 =A0 =A0 =A0pc_new_cpu(cpu_model);<br>
&gt; diff --git a/target-i386/cpu.h b/target-i386/cpu.h<br>
&gt; index 2a071f2..0160c55 100644<br>
&gt; --- a/target-i386/cpu.h<br>
&gt; +++ b/target-i386/cpu.h<br>
&gt; @@ -1062,4 +1062,5 @@ void svm_check_intercept(CPUState *env1, uint32_=
t type);<br>
&gt;<br>
&gt; =A0uint32_t cpu_cc_compute_all(CPUState *env1, int op);<br>
&gt;<br>
&gt; +extern DeviceState *apic_init(void *env, uint8_t apic_id);<br>
&gt; =A0#endif /* CPU_I386_H */<br>
&gt; diff --git a/target-i386/helper.c b/target-i386/helper.c<br>
&gt; index 5df40d4..551a8a2 100644<br>
&gt; --- a/target-i386/helper.c<br>
&gt; +++ b/target-i386/helper.c<br>
&gt; @@ -30,6 +30,7 @@<br>
&gt; =A0#include &quot;monitor.h&quot;<br>
&gt; =A0#endif<br>
&gt;<br>
&gt; +<br>
&gt; =A0//#define DEBUG_MMU<br>
&gt;<br>
&gt; =A0/* NOTE: must be called outside the CPU execute loop */<br>
&gt; @@ -1257,7 +1258,11 @@ CPUX86State *cpu_x86_init(const char *cpu_model=
)<br>
&gt; =A0 =A0 =A0 =A0 =A0return NULL;<br>
&gt; =A0 =A0 =A0}<br>
&gt; =A0 =A0 =A0mce_init(env);<br>
&gt; -<br>
&gt; + =A0 =A0if ((env-&gt;cpuid_features &amp; CPUID_APIC)<br>
&gt; + =A0 =A0 =A0 =A0|| smp_cpus &gt; 1) {<br>
&gt; + =A0 =A0 =A0 =A0env-&gt;cpuid_apic_id =3D env-&gt;cpu_index;<br>
&gt; + =A0 =A0 =A0 =A0env-&gt;apic_state =3D apic_init(env, env-&gt;cpuid_a=
pic_id);<br>
&gt; + =A0 =A0}<br>
&gt; =A0 =A0 =A0qemu_init_vcpu(env);<br>
&gt;<br>
&gt; =A0 =A0 =A0return env;<br>
&gt; diff --git a/target-i386/kvm.c b/target-i386/kvm.c<br>
&gt; index 571d792..407dba6 100644<br>
&gt; --- a/target-i386/kvm.c<br>
&gt; +++ b/target-i386/kvm.c<br>
&gt; @@ -880,7 +880,6 @@ static int kvm_put_sregs(CPUState *env)<br>
&gt;<br>
&gt; =A0 =A0 =A0sregs.cr8 =3D cpu_get_apic_tpr(env-&gt;apic_state);<br>
&gt; =A0 =A0 =A0sregs.apic_base =3D cpu_get_apic_base(env-&gt;apic_state);<=
br>
&gt; -<br>
&gt; =A0 =A0 =A0sregs.efer =3D env-&gt;efer;<br>
&gt;<br>
&gt; =A0 =A0 =A0return kvm_vcpu_ioctl(env, KVM_SET_SREGS, &amp;sregs);<br>
<br>
</div></div>Would be good to see the full series, i.e. everything that is r=
equired<br>
to make CPU hotplug work. First for QEMU upstream without in-kernel<br>
irqchips and then the qemu-kvm bits.<br>
<font color=3D"#888888"><br></font></blockquote><div>OK, I will try that.<b=
r><br>Thanks and regards,<br>ping fan<br><br>=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">
<font color=3D"#888888">
Jan<br>
<br>
</font></blockquote></div><br>

--20cf307ca03092c59a04ae8aa271--
