From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH RFC v2 1/3] drivers/platform/x86: add cpu physically
 hotplug driver
Date: Thu, 06 Jun 2013 11:03:47 +0800
Message-ID: <1370487827.17798.89.camel@liguang.fnst.cn.fujitsu.com>
References: <1370482835-764-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1370482835-764-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <51AFF2FB.6020007@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:9355 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753628Ab3FFDE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jun 2013 23:04:56 -0400
In-Reply-To: <51AFF2FB.6020007@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>

=E5=9C=A8 2013-06-06=E5=9B=9B=E7=9A=84 10:24 +0800=EF=BC=8CGu Zheng=E5=86=
=99=E9=81=93=EF=BC=9A
> On 06/06/2013 09:40 AM, liguang wrote:
>=20
> > this driver will support cpu phyical add/removal automatically
> > after online/offline. if cpu hotpluged, cpu will not
> > online automatically, and for cpu offline, we try to
> > do actually eject if allowed for cpu like
> > "echo 1 > /sys/bus/acpi/devices/LNXCPU\:0X/eject"
> > this "echo ..." is only present for recent kernel
> > (sorry, can't figure out since when), for a little
> > older kernel, there's not such approach AFAICS.
> >=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> > ---
> >  drivers/platform/x86/Kconfig              |    8 ++++
> >  drivers/platform/x86/Makefile             |    1 +
> >  drivers/platform/x86/cpu_physic_hotplug.c |   60 +++++++++++++++++=
++++++++++++
> >  3 files changed, 69 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/platform/x86/cpu_physic_hotplug.c
> >=20
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kc=
onfig
> > index 8577261..39b2392 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -789,4 +789,12 @@ config PVPANIC
> >  	  a paravirtualized device provided by QEMU; it lets a virtual ma=
chine
> >  	  (guest) communicate panic events to the host.
> > =20
> > +config QEMU_CPU_PHYSIC_HOTPLUG
> > +	tristate "physically add/remove cpu after cpu onlined/offlined"
> > +	depends on ACPI_HOTPLUG_CPU
> > +	---help---
> > +	  This driver will support physically remove a cpu after
> > +	  it offlined for QEMU automatically. someone may require this fe=
ature
> > +	  to do a physically removal for a cpu.
> > +
> >  endif # X86_PLATFORM_DEVICES
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/M=
akefile
> > index ef0ec74..2e669b0 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -53,3 +53,4 @@ obj-$(CONFIG_APPLE_GMUX)	+=3D apple-gmux.o
> >  obj-$(CONFIG_CHROMEOS_LAPTOP)	+=3D chromeos_laptop.o
> > =20
> >  obj-$(CONFIG_PVPANIC)           +=3D pvpanic.o
> > +obj-$(CONFIG_QEMU_CPU_PHYSIC_HOTPLUG)	+=3D cpu_physic_hotplug.o
> > diff --git a/drivers/platform/x86/cpu_physic_hotplug.c b/drivers/pl=
atform/x86/cpu_physic_hotplug.c
> > new file mode 100644
> > index 0000000..a52c042
> > --- /dev/null
> > +++ b/drivers/platform/x86/cpu_physic_hotplug.c
> > @@ -0,0 +1,60 @@
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +#include <linux/cpu.h>
> > +#include <linux/notifier.h>
> > +#include <acpi/processor.h>
> > +
> > +MODULE_AUTHOR("Li Guang");
> > +MODULE_DESCRIPTION("CPU physically hot-plug/unplug Driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +static int cpu_logic_hotplug_notify(struct notifier_block *nfb,
> > +				unsigned long action, void *hcpu)
> > +{
> > +	unsigned int cpu =3D (unsigned long)hcpu;
> > +	struct acpi_processor *pr =3D per_cpu(processors, cpu);
> > +
> > +	if (pr) {
> > +		switch (action) {
> > +		case CPU_ONLINE:
> > +			break;
> > +		case CPU_DEAD:
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block cpu_logic_hotplug_notifier =3D
> > +{
> > +	.notifier_call =3D cpu_logic_hotplug_notify,
> > +};
> > +
> > +static int cpu_physic_hotplug_notify(struct notifier_block *nfb,
> > +				 unsigned char *s)
> > +{
> > +}
>=20
> Hi guang,
> 	Maybe you need to define the callback function in the right format a=
t the beginning,
> if so, no need to correct it later.:)
>=20

right,

Thanks!

>=20
> > +
> > +static struct notifier_block cpu_physic_hotplug_notifier =3D
> > +{
> > +	.notifier_call =3D cpu_physic_hotplug_notify,
> > +};
> > +
> > +static int __init cpu_qemu_hotplug_init(void)
> > +{
> > +	register_hotcpu_notifier(&cpu_logic_hotplug_notifier);
> > +	register_ec_gpe_notifier(&cpu_physic_hotplug_notifier);
>=20
>=20
> As the [PATCH 2/3] has no dependence on this one, so you can set [PAT=
CH 2/3] to [PATCH 1/3] and this one
> to [PATCH 2/3]. Then you can use the xxx_ec_space_notifier directly h=
ere.
>=20
> > +	return 0;
> > +}
> > +
> > +static void __exit cpu_qemu_hotplug_exit(void)
> > +{
> > +	unregister_hotcpu_notifier(&cpu_logic_hotplug_notifier);
> > +	unregister_ec_gpe_notifier(&cpu_physic_hotplug_notifier);
> > +}
> > +
> > +module_init(cpu_qemu_hotplug_init);
> > +module_exit(cpu_qemu_hotplug_exit);
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
