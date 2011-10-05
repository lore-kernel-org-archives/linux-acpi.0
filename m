From: liu ping fan <qemulist@gmail.com>
Subject: Re: [PATCH 2/2] LAPIC: make lapic support cpu hotplug
Date: Wed, 5 Oct 2011 18:09:17 +0800
Message-ID: <CAJnKYQ=97wH_hEjsocu5dG4Ou87PQQGxYr4J1Uo6ZMw_0EZxZg@mail.gmail.com>
References: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
	<1317726818-8514-4-git-send-email-pingfank@linux.vnet.com>
	<4E8B02F7.6020000@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0016e652070ca8f5e404ae8a66a1
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4E8B02F7.6020000@codemonkey.ws>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: aliguori@us.ibm.com, Liu Ping Fan <pingfank@linux.vnet.ibm.com>, kvm@vger.kernel.org, pingfank@linux.vnet.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-acpi@vger.kernel.org, ryanh@us.ibm.com, shaohua.li@intel.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

--0016e652070ca8f5e404ae8a66a1
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Oct 4, 2011 at 8:58 PM, Anthony Liguori <anthony@codemonkey.ws>wrote:

> On 10/04/2011 06:13 AM, pingfank@linux.vnet.com wrote:
>
>> From: Liu Ping Fan<pingfank@linux.vnet.ibm.**com<pingfank@linux.vnet.ibm.com>
>> >
>>
>> Separate apic from qbus to icc bus which supports hotplug feature.
>> And make the creation of apic as part of cpu initialization, so
>> apic's state has been ready, before setting kvm_apic.
>>
>> Signed-off-by: Liu Ping Fan<pingfank@linux.vnet.ibm.**com<pingfank@linux.vnet.ibm.com>
>> >
>> ---
>>  Makefile.target      |    1 +
>>  hw/apic.c            |    7 ++++-
>>  hw/apic.h            |    1 +
>>  hw/icc_bus.c         |   62 ++++++++++++++++++++++++++++++**
>> ++++++++++++++++++++
>>  hw/icc_bus.h         |   24 +++++++++++++++++++
>>  hw/pc.c              |   11 ++++-----
>>  target-i386/cpu.h    |    1 +
>>  target-i386/helper.c |    7 +++++-
>>  target-i386/kvm.c    |    1 -
>>  9 files changed, 105 insertions(+), 10 deletions(-)
>>  create mode 100644 hw/icc_bus.c
>>  create mode 100644 hw/icc_bus.h
>>
>> diff --git a/Makefile.target b/Makefile.target
>> index 9011f28..5607c6d 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -241,6 +241,7 @@ obj-i386-$(CONFIG_KVM) += kvmclock.o
>>  obj-i386-$(CONFIG_SPICE) += qxl.o qxl-logger.o qxl-render.o
>>  obj-i386-y += testdev.o
>>  obj-i386-y += acpi.o acpi_piix4.o
>> +obj-i386-y += icc_bus.o
>>
>>  obj-i386-y += pcspk.o i8254.o
>>  obj-i386-$(CONFIG_KVM_PIT) += i8254-kvm.o
>> diff --git a/hw/apic.c b/hw/apic.c
>> index 69d6ac5..95a1664 100644
>> --- a/hw/apic.c
>> +++ b/hw/apic.c
>> @@ -24,6 +24,7 @@
>>  #include "sysbus.h"
>>  #include "trace.h"
>>  #include "kvm.h"
>> +#include "icc_bus.h"
>>
>>  /* APIC Local Vector Table */
>>  #define APIC_LVT_TIMER   0
>> @@ -304,11 +305,13 @@ void cpu_set_apic_base(DeviceState *d, uint64_t val)
>>
>>      if (!s)
>>          return;
>> +
>>      if (kvm_enabled()&&  kvm_irqchip_in_kernel())
>>
>>          s->apicbase = val;
>>      else
>>          s->apicbase = (val&  0xfffff000) |
>>              (s->apicbase&  (MSR_IA32_APICBASE_BSP |
>> MSR_IA32_APICBASE_ENABLE));
>>
>> +
>>      /* if disabled, cannot be enabled again */
>>      if (!(val&  MSR_IA32_APICBASE_ENABLE)) {
>>          s->apicbase&= ~MSR_IA32_APICBASE_ENABLE;
>>
>> @@ -1075,7 +1078,7 @@ static const VMStateDescription vmstate_apic = {
>>      }
>>  };
>>
>
> Please don't introduce extra whitespace in unrelated code.
>
> Adopt,

>
>
>> -static void apic_reset(DeviceState *d)
>> +void apic_reset(DeviceState *d)
>>  {
>>      APICState *s = DO_UPCAST(APICState, busdev.qdev, d);
>>      int bsp;
>> @@ -1138,7 +1141,7 @@ static SysBusDeviceInfo apic_info = {
>>
>>  static void apic_register_devices(void)
>>  {
>> -    sysbus_register_withprop(&**apic_info);
>> +    iccbus_register(&apic_info);
>>  }
>>
>>  device_init(apic_register_**devices)
>> diff --git a/hw/apic.h b/hw/apic.h
>> index c857d52..e258efa 100644
>> --- a/hw/apic.h
>> +++ b/hw/apic.h
>> @@ -24,5 +24,6 @@ void apic_sipi(DeviceState *s);
>>  /* pc.c */
>>  int cpu_is_bsp(CPUState *env);
>>  DeviceState *cpu_get_current_apic(void);
>> +void apic_reset(DeviceState *d);
>>
>>  #endif
>> diff --git a/hw/icc_bus.c b/hw/icc_bus.c
>> new file mode 100644
>> index 0000000..360ca2a
>> --- /dev/null
>> +++ b/hw/icc_bus.c
>> @@ -0,0 +1,62 @@
>> +/*
>> +*/
>>
>
> New files need to include copyright/licenses.
>
> Adopt,

 +#define ICC_BUS_PLUG
>> +#ifdef ICC_BUS_PLUG
>>
>
> Drop these guards here and at the end of the file.  We conditionally build
> files by having an:
>
> obj-$(CONFIG_ICC_BUS) += icc_bus.o
>
> In the Makefile.
>
> Adopt,


>  +#include "icc_bus.h"
>>
>
>  +
>> +
>> +
>> +struct icc_bus_info icc_info = {
>> +    .qinfo.name = "icc",
>> +    .qinfo.size = sizeof(struct icc_bus),
>> +    .qinfo.props = (Property[]) {
>> +        DEFINE_PROP_END_OF_LIST(),
>> +    }
>> +
>> +};
>>
>
> Structure name is not following Coding Style.
>
I will fix it.

 +
>> +static const VMStateDescription vmstate_icc_bus = {
>> +    .name = "icc_bus",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .minimum_version_id_old = 1,
>> +    .pre_save = NULL,
>> +    .post_load = NULL,
>> +};
>> +
>> +struct icc_bus *g_iccbus;
>> +
>> +struct icc_bus *icc_init_bus(DeviceState *parent, const char *name)
>> +{
>> +    struct icc_bus *bus;
>> +
>> +    bus = FROM_QBUS(icc_bus, qbus_create(&icc_info.qinfo, parent, name));
>> +    bus->qbus.allow_hotplug = 1; /* Yes, we can */
>> +    bus->qbus.name = "icc";
>> +    vmstate_register(NULL, -1,&vmstate_icc_bus, bus);
>>
>> +    g_iccbus = bus;
>> +    return bus;
>> +}
>> +
>> +
>> +
>> +
>> +
>> +static int iccbus_device_init(DeviceState *dev, DeviceInfo *base)
>> +{
>> +    SysBusDeviceInfo *info = container_of(base, SysBusDeviceInfo, qdev);
>> +
>> +    return info->init(sysbus_from_qdev(**dev));
>> +}
>> +
>> +void iccbus_register(**SysBusDeviceInfo *info)
>> +{
>> +    info->qdev.init = iccbus_device_init;
>> +    info->qdev.bus_info =&icc_info.qinfo;
>> +
>> +    assert(info->qdev.size>= sizeof(SysBusDevice));
>> +    qdev_register(&info->qdev);
>> +}
>> +
>>
>
> It's not obvious to me why you need the g_iccbus variable.
>
>  As ICC bus is used by LAPIC and IOAPIC, so I want to export it as a system
wide variable.


>  +#endif
>> diff --git a/hw/icc_bus.h b/hw/icc_bus.h
>> new file mode 100644
>> index 0000000..94d9242
>> --- /dev/null
>> +++ b/hw/icc_bus.h
>> @@ -0,0 +1,24 @@
>> +#ifndef QEMU_ICC_H
>> +#define QEMU_ICC_H
>>
>
>
> Needs copyright and a blurb explaining what this file is and what the ICC
> bus is.
>
> Same comments re: whitespace below.
>
> Regards,
>
> Anthony Liguori
>
>
>  +#include "qdev.h"
>> +#include "sysbus.h"
>> +
>> +typedef struct icc_bus icc_bus;
>> +typedef struct icc_bus_info icc_bus_info;
>> +
>> +
>> +struct icc_bus {
>> +    BusState qbus;
>> +};
>> +
>> +struct icc_bus_info {
>> +    BusInfo qinfo;
>> +};
>> +
>> +extern struct icc_bus_info icc_info;
>> +extern struct icc_bus *g_iccbus;
>> +extern struct icc_bus *icc_init_bus(DeviceState *parent, const char
>> *name);
>> +extern void iccbus_register(**SysBusDeviceInfo *info);
>>
>
> Functions don't need an 'extern' modifier.  I don't think icc_info needs to
> be exported either.
>
> Instead of exporting g_iccbus, it would be better to have a get_icc_bus()
> method that returned the global iccbus.  That way we can more easily hook
> accesses to the bus.
>
> Adopt,

Thanks and regards,

ping fan





 +#endif
>> diff --git a/hw/pc.c b/hw/pc.c
>> index 6b3662e..10371d8 100644
>> --- a/hw/pc.c
>> +++ b/hw/pc.c
>> @@ -24,6 +24,7 @@
>>  #include "hw.h"
>>  #include "pc.h"
>>  #include "apic.h"
>> +#include "icc_bus.h"
>>  #include "fdc.h"
>>  #include "ide.h"
>>  #include "pci.h"
>> @@ -91,6 +92,7 @@ struct e820_table {
>>  static struct e820_table e820_table;
>>  struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>>
>> +
>>  void isa_irq_handler(void *opaque, int n, int level)
>>  {
>>      IsaIrqState *isa = (IsaIrqState *)opaque;
>> @@ -872,13 +874,13 @@ DeviceState *cpu_get_current_apic(void)
>>      }
>>  }
>>
>> -static DeviceState *apic_init(void *env, uint8_t apic_id)
>> +DeviceState *apic_init(void *env, uint8_t apic_id)
>>  {
>>      DeviceState *dev;
>>      SysBusDevice *d;
>>      static int apic_mapped;
>>
>> -    dev = qdev_create(NULL, "apic");
>> +    dev = qdev_create(&g_iccbus->qbus, "apic");
>>      qdev_prop_set_uint8(dev, "id", apic_id);
>>      qdev_prop_set_ptr(dev, "cpu_env", env);
>>      qdev_init_nofail(dev);
>> @@ -943,10 +945,6 @@ CPUState *pc_new_cpu(const char *cpu_model)
>>          fprintf(stderr, "Unable to find x86 CPU definition\n");
>>          exit(1);
>>      }
>> -    if ((env->cpuid_features&  CPUID_APIC) || smp_cpus>  1) {
>>
>> -        env->cpuid_apic_id = env->cpu_index;
>> -        env->apic_state = apic_init(env, env->cpuid_apic_id);
>> -    }
>>      qemu_register_reset(pc_cpu_**reset, env);
>>      pc_cpu_reset(env);
>>      return env;
>> @@ -956,6 +954,7 @@ void pc_cpus_init(const char *cpu_model)
>>  {
>>      int i;
>>
>> +    icc_init_bus(NULL, "icc");
>>      /* init CPUs */
>>      for(i = 0; i<  smp_cpus; i++) {
>>          pc_new_cpu(cpu_model);
>> diff --git a/target-i386/cpu.h b/target-i386/cpu.h
>> index 2a071f2..0160c55 100644
>> --- a/target-i386/cpu.h
>> +++ b/target-i386/cpu.h
>> @@ -1062,4 +1062,5 @@ void svm_check_intercept(CPUState *env1, uint32_t
>> type);
>>
>>  uint32_t cpu_cc_compute_all(CPUState *env1, int op);
>>
>> +extern DeviceState *apic_init(void *env, uint8_t apic_id);
>>  #endif /* CPU_I386_H */
>> diff --git a/target-i386/helper.c b/target-i386/helper.c
>> index 5df40d4..551a8a2 100644
>> --- a/target-i386/helper.c
>> +++ b/target-i386/helper.c
>> @@ -30,6 +30,7 @@
>>  #include "monitor.h"
>>  #endif
>>
>> +
>>  //#define DEBUG_MMU
>>
>>  /* NOTE: must be called outside the CPU execute loop */
>> @@ -1257,7 +1258,11 @@ CPUX86State *cpu_x86_init(const char *cpu_model)
>>          return NULL;
>>      }
>>      mce_init(env);
>> -
>> +    if ((env->cpuid_features&  CPUID_APIC)
>>
>> +        || smp_cpus>  1) {
>> +        env->cpuid_apic_id = env->cpu_index;
>> +        env->apic_state = apic_init(env, env->cpuid_apic_id);
>> +    }
>>      qemu_init_vcpu(env);
>>
>>      return env;
>> diff --git a/target-i386/kvm.c b/target-i386/kvm.c
>> index 571d792..407dba6 100644
>> --- a/target-i386/kvm.c
>> +++ b/target-i386/kvm.c
>> @@ -880,7 +880,6 @@ static int kvm_put_sregs(CPUState *env)
>>
>>      sregs.cr8 = cpu_get_apic_tpr(env->apic_**state);
>>      sregs.apic_base = cpu_get_apic_base(env->apic_**state);
>> -
>>      sregs.efer = env->efer;
>>
>>      return kvm_vcpu_ioctl(env, KVM_SET_SREGS,&sregs);
>>
>
>
>

--0016e652070ca8f5e404ae8a66a1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Oct 4, 2011 at 8:58 PM, Anthony =
Liguori <span dir=3D"ltr">&lt;<a href=3D"mailto:anthony@codemonkey.ws">anth=
ony@codemonkey.ws</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, =
204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">On 10/04/2011 06:13 AM, <a href=3D"mailto=
:pingfank@linux.vnet.com" target=3D"_blank">pingfank@linux.vnet.com</a> wro=
te:<br>
</div></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt =
0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div>=
<div></div><div class=3D"h5">
From: Liu Ping Fan&lt;<a href=3D"mailto:pingfank@linux.vnet.ibm.com" target=
=3D"_blank">pingfank@linux.vnet.ibm.<u></u>com</a>&gt;<br>
<br>
Separate apic from qbus to icc bus which supports hotplug feature.<br>
And make the creation of apic as part of cpu initialization, so<br>
apic&#39;s state has been ready, before setting kvm_apic.<br>
<br>
Signed-off-by: Liu Ping Fan&lt;<a href=3D"mailto:pingfank@linux.vnet.ibm.co=
m" target=3D"_blank">pingfank@linux.vnet.ibm.<u></u>com</a>&gt;<br>
---<br>
 =A0Makefile.target =A0 =A0 =A0| =A0 =A01 +<br>
 =A0hw/apic.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++++-<br>
 =A0hw/apic.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +<br>
 =A0hw/icc_bus.c =A0 =A0 =A0 =A0 | =A0 62 ++++++++++++++++++++++++++++++<u>=
</u>++++++++++++++++++++<br>
 =A0hw/icc_bus.h =A0 =A0 =A0 =A0 | =A0 24 +++++++++++++++++++<br>
 =A0hw/pc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ++++-----<br>
 =A0target-i386/cpu.h =A0 =A0| =A0 =A01 +<br>
 =A0target-i386/helper.c | =A0 =A07 +++++-<br>
 =A0target-i386/kvm.c =A0 =A0| =A0 =A01 -<br>
 =A09 files changed, 105 insertions(+), 10 deletions(-)<br>
 =A0create mode 100644 hw/icc_bus.c<br>
 =A0create mode 100644 hw/icc_bus.h<br>
<br>
diff --git a/Makefile.target b/Makefile.target<br>
index 9011f28..5607c6d 100644<br>
--- a/Makefile.target<br>
+++ b/Makefile.target<br>
@@ -241,6 +241,7 @@ obj-i386-$(CONFIG_KVM) +=3D kvmclock.o<br>
 =A0obj-i386-$(CONFIG_SPICE) +=3D qxl.o qxl-logger.o qxl-render.o<br>
 =A0obj-i386-y +=3D testdev.o<br>
 =A0obj-i386-y +=3D acpi.o acpi_piix4.o<br>
+obj-i386-y +=3D icc_bus.o<br>
<br>
 =A0obj-i386-y +=3D pcspk.o i8254.o<br>
 =A0obj-i386-$(CONFIG_KVM_PIT) +=3D i8254-kvm.o<br>
diff --git a/hw/apic.c b/hw/apic.c<br>
index 69d6ac5..95a1664 100644<br>
--- a/hw/apic.c<br>
+++ b/hw/apic.c<br>
@@ -24,6 +24,7 @@<br>
 =A0#include &quot;sysbus.h&quot;<br>
 =A0#include &quot;trace.h&quot;<br>
 =A0#include &quot;kvm.h&quot;<br>
+#include &quot;icc_bus.h&quot;<br>
<br>
 =A0/* APIC Local Vector Table */<br>
 =A0#define APIC_LVT_TIMER =A0 0<br>
@@ -304,11 +305,13 @@ void cpu_set_apic_base(DeviceState *d, uint64_t val)<=
br>
<br>
 =A0 =A0 =A0if (!s)<br>
 =A0 =A0 =A0 =A0 =A0return;<br>
+<br></div></div>
 =A0 =A0 =A0if (kvm_enabled()&amp;&amp; =A0kvm_irqchip_in_kernel())<div cla=
ss=3D"im"><br>
 =A0 =A0 =A0 =A0 =A0s-&gt;apicbase =3D val;<br>
 =A0 =A0 =A0else<br>
 =A0 =A0 =A0 =A0 =A0s-&gt;apicbase =3D (val&amp; =A00xfffff000) |<br></div>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(s-&gt;apicbase&amp; =A0(MSR_IA32_APICBASE_BSP =
| MSR_IA32_APICBASE_ENABLE));<div class=3D"im"><br>
+<br>
 =A0 =A0 =A0/* if disabled, cannot be enabled again */<br>
 =A0 =A0 =A0if (!(val&amp; =A0MSR_IA32_APICBASE_ENABLE)) {<br></div>
 =A0 =A0 =A0 =A0 =A0s-&gt;apicbase&amp;=3D ~MSR_IA32_APICBASE_ENABLE;<div c=
lass=3D"im"><br>
@@ -1075,7 +1078,7 @@ static const VMStateDescription vmstate_apic =3D {<br=
>
 =A0 =A0 =A0}<br>
 =A0};<br>
</div></blockquote>
<br>
Please don&#39;t introduce extra whitespace in unrelated code.<div><div cla=
ss=3D"h5"><br></div></div></blockquote><div>Adopt, <br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px so=
lid rgb(204, 204, 204); padding-left: 1ex;">
<div><div class=3D"h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
-static void apic_reset(DeviceState *d)<br>
+void apic_reset(DeviceState *d)<br>
 =A0{<br>
 =A0 =A0 =A0APICState *s =3D DO_UPCAST(APICState, busdev.qdev, d);<br>
 =A0 =A0 =A0int bsp;<br>
@@ -1138,7 +1141,7 @@ static SysBusDeviceInfo apic_info =3D {<br>
<br>
 =A0static void apic_register_devices(void)<br>
 =A0{<br>
- =A0 =A0sysbus_register_withprop(&amp;<u></u>apic_info);<br>
+ =A0 =A0iccbus_register(&amp;apic_info);<br>
 =A0}<br>
<br>
 =A0device_init(apic_register_<u></u>devices)<br>
diff --git a/hw/apic.h b/hw/apic.h<br>
index c857d52..e258efa 100644<br>
--- a/hw/apic.h<br>
+++ b/hw/apic.h<br>
@@ -24,5 +24,6 @@ void apic_sipi(DeviceState *s);<br>
 =A0/* pc.c */<br>
 =A0int cpu_is_bsp(CPUState *env);<br>
 =A0DeviceState *cpu_get_current_apic(void);<br>
+void apic_reset(DeviceState *d);<br>
<br>
 =A0#endif<br>
diff --git a/hw/icc_bus.c b/hw/icc_bus.c<br>
new file mode 100644<br>
index 0000000..360ca2a<br>
--- /dev/null<br>
+++ b/hw/icc_bus.c<br>
@@ -0,0 +1,62 @@<br>
+/*<br>
+*/<br>
</blockquote>
<br></div></div>
New files need to include copyright/licenses.<br>
<br></blockquote><div>Adopt,=A0 <br><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
+#define ICC_BUS_PLUG<br>
+#ifdef ICC_BUS_PLUG<br>
</blockquote>
<br>
Drop these guards here and at the end of the file. =A0We conditionally buil=
d files by having an:<br>
<br>
obj-$(CONFIG_ICC_BUS) +=3D icc_bus.o<br>
<br>
In the Makefile.<div class=3D"im"><br></div></blockquote><div>Adopt,=A0 <br=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=
.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div c=
lass=3D"im">

<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
+#include &quot;icc_bus.h&quot;<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
+<br>
+<br>
+<br>
+struct icc_bus_info icc_info =3D {<br>
+ =A0 =A0.<a href=3D"http://qinfo.name" target=3D"_blank">qinfo.name</a> =
=3D &quot;icc&quot;,<br>
+ =A0 =A0.qinfo.size =3D sizeof(struct icc_bus),<br>
+ =A0 =A0.qinfo.props =3D (Property[]) {<br>
+ =A0 =A0 =A0 =A0DEFINE_PROP_END_OF_LIST(),<br>
+ =A0 =A0}<br>
+<br>
+};<br>
</blockquote>
<br></div>
Structure name is not following Coding Style.<br></blockquote><div>I will f=
ix it. <br><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt=
 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1e=
x;">

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>
+<br>
+static const VMStateDescription vmstate_icc_bus =3D {<br>
+ =A0 =A0.name =3D &quot;icc_bus&quot;,<br>
+ =A0 =A0.version_id =3D 1,<br>
+ =A0 =A0.minimum_version_id =3D 1,<br>
+ =A0 =A0.minimum_version_id_old =3D 1,<br>
+ =A0 =A0.pre_save =3D NULL,<br>
+ =A0 =A0.post_load =3D NULL,<br>
+};<br>
+<br>
+struct icc_bus *g_iccbus;<br>
+<br>
+struct icc_bus *icc_init_bus(DeviceState *parent, const char *name)<br>
+{<br>
+ =A0 =A0struct icc_bus *bus;<br>
+<br>
+ =A0 =A0bus =3D FROM_QBUS(icc_bus, qbus_create(&amp;icc_info.qinfo, parent=
, name));<br>
+ =A0 =A0bus-&gt;qbus.allow_hotplug =3D 1; /* Yes, we can */<br>
+ =A0 =A0bus-&gt;<a href=3D"http://qbus.name" target=3D"_blank">qbus.name</=
a> =3D &quot;icc&quot;;<br></div>
+ =A0 =A0vmstate_register(NULL, -1,&amp;vmstate_icc_bus, bus);<div class=3D=
"im"><br>
+ =A0 =A0g_iccbus =3D bus;<br>
+ =A0 =A0return bus;<br>
+}<br>
+<br>
+<br>
+<br>
+<br>
+<br>
+static int iccbus_device_init(DeviceState *dev, DeviceInfo *base)<br>
+{<br>
+ =A0 =A0SysBusDeviceInfo *info =3D container_of(base, SysBusDeviceInfo, qd=
ev);<br>
+<br>
+ =A0 =A0return info-&gt;init(sysbus_from_qdev(<u></u>dev));<br>
+}<br>
+<br>
+void iccbus_register(<u></u>SysBusDeviceInfo *info)<br>
+{<br>
+ =A0 =A0info-&gt;qdev.init =3D iccbus_device_init;<br>
+ =A0 =A0info-&gt;qdev.bus_info =3D&amp;icc_info.qinfo;<br>
+<br>
+ =A0 =A0assert(info-&gt;qdev.size&gt;=3D sizeof(SysBusDevice));<br>
+ =A0 =A0qdev_register(&amp;info-&gt;qdev);<br>
+}<br>
+<br>
</div></blockquote>
<br>
It&#39;s not obvious to me why you need the g_iccbus variable.<div class=3D=
"im"><br></div></blockquote><div>=A0As ICC bus is used by LAPIC and IOAPIC,=
 so I want to export it as a system wide variable.<br><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px=
 solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
+#endif<br>
diff --git a/hw/icc_bus.h b/hw/icc_bus.h<br>
new file mode 100644<br>
index 0000000..94d9242<br>
--- /dev/null<br>
+++ b/hw/icc_bus.h<br>
@@ -0,0 +1,24 @@<br>
+#ifndef QEMU_ICC_H<br>
+#define QEMU_ICC_H<br>
</blockquote>
<br>
<br></div>
Needs copyright and a blurb explaining what this file is and what the ICC b=
us is.<br>
<br>
Same comments re: whitespace below.<br>
<br>
Regards,<br>
<br>
Anthony Liguori<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
+#include &quot;qdev.h&quot;<br>
+#include &quot;sysbus.h&quot;<br>
+<br>
+typedef struct icc_bus icc_bus;<br>
+typedef struct icc_bus_info icc_bus_info;<br>
+<br>
+<br>
+struct icc_bus {<br>
+ =A0 =A0BusState qbus;<br>
+};<br>
+<br>
+struct icc_bus_info {<br>
+ =A0 =A0BusInfo qinfo;<br>
+};<br>
+<br>
+extern struct icc_bus_info icc_info;<br>
+extern struct icc_bus *g_iccbus;<br>
+extern struct icc_bus *icc_init_bus(DeviceState *parent, const char *name)=
;<br>
+extern void iccbus_register(<u></u>SysBusDeviceInfo *info);<br>
</blockquote>
<br></div>
Functions don&#39;t need an &#39;extern&#39; modifier. =A0I don&#39;t think=
 icc_info needs to be exported either.<br>
<br>
Instead of exporting g_iccbus, it would be better to have a get_icc_bus() m=
ethod that returned the global iccbus. =A0That way we can more easily hook =
accesses to the bus.<br>
<br></blockquote><div>Adopt,<br><br>Thanks and regards,<br><br>ping fan <br=
><br><br><br><br><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">
+#endif<br>
diff --git a/hw/pc.c b/hw/pc.c<br>
index 6b3662e..10371d8 100644<br>
--- a/hw/pc.c<br>
+++ b/hw/pc.c<br>
@@ -24,6 +24,7 @@<br>
 =A0#include &quot;hw.h&quot;<br>
 =A0#include &quot;pc.h&quot;<br>
 =A0#include &quot;apic.h&quot;<br>
+#include &quot;icc_bus.h&quot;<br>
 =A0#include &quot;fdc.h&quot;<br>
 =A0#include &quot;ide.h&quot;<br>
 =A0#include &quot;pci.h&quot;<br>
@@ -91,6 +92,7 @@ struct e820_table {<br>
 =A0static struct e820_table e820_table;<br>
 =A0struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};<br>
<br>
+<br>
 =A0void isa_irq_handler(void *opaque, int n, int level)<br>
 =A0{<br>
 =A0 =A0 =A0IsaIrqState *isa =3D (IsaIrqState *)opaque;<br>
@@ -872,13 +874,13 @@ DeviceState *cpu_get_current_apic(void)<br>
 =A0 =A0 =A0}<br>
 =A0}<br>
<br>
-static DeviceState *apic_init(void *env, uint8_t apic_id)<br>
+DeviceState *apic_init(void *env, uint8_t apic_id)<br>
 =A0{<br>
 =A0 =A0 =A0DeviceState *dev;<br>
 =A0 =A0 =A0SysBusDevice *d;<br>
 =A0 =A0 =A0static int apic_mapped;<br>
<br>
- =A0 =A0dev =3D qdev_create(NULL, &quot;apic&quot;);<br>
+ =A0 =A0dev =3D qdev_create(&amp;g_iccbus-&gt;qbus, &quot;apic&quot;);<br>
 =A0 =A0 =A0qdev_prop_set_uint8(dev, &quot;id&quot;, apic_id);<br>
 =A0 =A0 =A0qdev_prop_set_ptr(dev, &quot;cpu_env&quot;, env);<br>
 =A0 =A0 =A0qdev_init_nofail(dev);<br>
@@ -943,10 +945,6 @@ CPUState *pc_new_cpu(const char *cpu_model)<br>
 =A0 =A0 =A0 =A0 =A0fprintf(stderr, &quot;Unable to find x86 CPU definition=
\n&quot;);<br>
 =A0 =A0 =A0 =A0 =A0exit(1);<br>
 =A0 =A0 =A0}<br></div></div>
- =A0 =A0if ((env-&gt;cpuid_features&amp; =A0CPUID_APIC) || smp_cpus&gt; =
=A01) {<div><div></div><div class=3D"h5"><br>
- =A0 =A0 =A0 =A0env-&gt;cpuid_apic_id =3D env-&gt;cpu_index;<br>
- =A0 =A0 =A0 =A0env-&gt;apic_state =3D apic_init(env, env-&gt;cpuid_apic_i=
d);<br>
- =A0 =A0}<br>
 =A0 =A0 =A0qemu_register_reset(pc_cpu_<u></u>reset, env);<br>
 =A0 =A0 =A0pc_cpu_reset(env);<br>
 =A0 =A0 =A0return env;<br>
@@ -956,6 +954,7 @@ void pc_cpus_init(const char *cpu_model)<br>
 =A0{<br>
 =A0 =A0 =A0int i;<br>
<br>
+ =A0 =A0icc_init_bus(NULL, &quot;icc&quot;);<br>
 =A0 =A0 =A0/* init CPUs */<br>
 =A0 =A0 =A0for(i =3D 0; i&lt; =A0smp_cpus; i++) {<br>
 =A0 =A0 =A0 =A0 =A0pc_new_cpu(cpu_model);<br>
diff --git a/target-i386/cpu.h b/target-i386/cpu.h<br>
index 2a071f2..0160c55 100644<br>
--- a/target-i386/cpu.h<br>
+++ b/target-i386/cpu.h<br>
@@ -1062,4 +1062,5 @@ void svm_check_intercept(CPUState *env1, uint32_t typ=
e);<br>
<br>
 =A0uint32_t cpu_cc_compute_all(CPUState *env1, int op);<br>
<br>
+extern DeviceState *apic_init(void *env, uint8_t apic_id);<br>
 =A0#endif /* CPU_I386_H */<br>
diff --git a/target-i386/helper.c b/target-i386/helper.c<br>
index 5df40d4..551a8a2 100644<br>
--- a/target-i386/helper.c<br>
+++ b/target-i386/helper.c<br>
@@ -30,6 +30,7 @@<br>
 =A0#include &quot;monitor.h&quot;<br>
 =A0#endif<br>
<br>
+<br>
 =A0//#define DEBUG_MMU<br>
<br>
 =A0/* NOTE: must be called outside the CPU execute loop */<br>
@@ -1257,7 +1258,11 @@ CPUX86State *cpu_x86_init(const char *cpu_model)<br>
 =A0 =A0 =A0 =A0 =A0return NULL;<br>
 =A0 =A0 =A0}<br>
 =A0 =A0 =A0mce_init(env);<br>
-<br></div></div>
+ =A0 =A0if ((env-&gt;cpuid_features&amp; =A0CPUID_APIC)<div class=3D"im"><=
br>
+ =A0 =A0 =A0 =A0|| smp_cpus&gt; =A01) {<br>
+ =A0 =A0 =A0 =A0env-&gt;cpuid_apic_id =3D env-&gt;cpu_index;<br>
+ =A0 =A0 =A0 =A0env-&gt;apic_state =3D apic_init(env, env-&gt;cpuid_apic_i=
d);<br>
+ =A0 =A0}<br>
 =A0 =A0 =A0qemu_init_vcpu(env);<br>
<br>
 =A0 =A0 =A0return env;<br>
diff --git a/target-i386/kvm.c b/target-i386/kvm.c<br>
index 571d792..407dba6 100644<br>
--- a/target-i386/kvm.c<br>
+++ b/target-i386/kvm.c<br>
@@ -880,7 +880,6 @@ static int kvm_put_sregs(CPUState *env)<br>
<br>
 =A0 =A0 =A0sregs.cr8 =3D cpu_get_apic_tpr(env-&gt;apic_<u></u>state);<br>
 =A0 =A0 =A0sregs.apic_base =3D cpu_get_apic_base(env-&gt;apic_<u></u>state=
);<br>
-<br>
 =A0 =A0 =A0sregs.efer =3D env-&gt;efer;<br>
<br>
 =A0 =A0 =A0return kvm_vcpu_ioctl(env, KVM_SET_SREGS,&amp;sregs);<br>
</div></blockquote>
<br>
<br>
</blockquote></div><br>

--0016e652070ca8f5e404ae8a66a1--
