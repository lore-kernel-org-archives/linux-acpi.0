From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V3] ACPI / OSL: Make acpi_os_map_cleanup() use call_rcu()
 to avoid deadlocks
Date: Thu, 28 Aug 2014 16:27:42 +0800
Message-ID: <53FEE7FE.9080007@intel.com>
References: <20140827022709.GA22064@localhost> <1409123489-11786-1-git-send-email-tianyu.lan@intel.com> <8105997.7zQ9mSfecG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <8105997.7zQ9mSfecG@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, fengguang.wu@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, All applicable <stable@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B408=E6=9C=8828=E6=97=A5 07:37, Rafael J. Wysocki wrote:
> On Wednesday, August 27, 2014 03:11:29 PM Lan Tianyu wrote:
>> Deadlock is possible when CPU hotplug and evaluating ACPI method hap=
pen
>> at the same time.
>>
>> During CPU hotplug, acpi_cpu_soft_notify() is called under the CPU h=
otplug
>> lock.  Then, acpi_cpu_soft_notify() calls acpi_bus_get_device() to o=
btain
>> the struct acpi_device attached to the given ACPI handle.  The ACPIC=
A's
>> namespace lock will be acquired by acpi_bus_get_device() in the proc=
ess.
>> Thus it is possible to hold the ACPICA's namespace lock under the CP=
U
>> hotplug lock.
>>
>> Evaluating an ACPI method may involve accessing an operation region =
in
>> system memory and the associated address space will be unmapped unde=
r
>> the ACPICA's namespace lock after completing the access. Currently, =
osl.c
>> uses RCU to protect memory ranges used by AML.  When unmapping them =
it
>> calls synchronize_rcu() in acpi_os_map_cleanup(), but that blocks
>> CPU hotplug by acquiring the CPU hotplug lock.  Thus it is possible =
to
>> hold the CPU hotplug lock under the ACPICA's namespace lock.
>>
>> This leads to deadlocks like the following one if AML accessing oper=
ation
>> regions in memory is executed in parallel with CPU hotplug.
>=20
> [cut]
>=20
>> To avoid such deadlocks, modify acpi_os_map_cleanup() to use call_rc=
u()
>> to schedule acpi_os_async_umap() asynchronously to umap memory regio=
ns
>> that aren't used any more. The umap operation can't be done in the
>> call_rcu()'s callback directly because the callback will be called i=
n the
>> soft irq context and acpi_unmap() holds mutex lock inside.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> [rjw: Subject and changelog.]
>> Cc: All applicable <stable@vger.kernel.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/osl.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 3abe9b2..9baef71 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -40,6 +40,7 @@
>>  #include <linux/nmi.h>
>>  #include <linux/acpi.h>
>>  #include <linux/efi.h>
>> +#include <linux/async.h>
>>  #include <linux/ioport.h>
>>  #include <linux/list.h>
>>  #include <linux/jiffies.h>
>> @@ -94,6 +95,7 @@ struct acpi_ioremap {
>>  	acpi_physical_address phys;
>>  	acpi_size size;
>>  	unsigned long refcount;
>> +	struct rcu_head rcu;
>>  };
>> =20
>>  static LIST_HEAD(acpi_ioremaps);
>> @@ -423,13 +425,25 @@ static void acpi_os_drop_map_ref(struct acpi_i=
oremap *map)
>>  		list_del_rcu(&map->list);
>>  }
>> =20
>> +static void acpi_os_async_umap(void *data, async_cookie_t cookie)
>> +{
>> +	struct acpi_ioremap *map =3D data;
>> +
>> +	acpi_unmap(map->phys, map->virt);
>> +	kfree(map);
>> +}
>> +
>> +static void acpi_os_map_reclaim(struct rcu_head *rcu)
>> +{
>> +	struct acpi_ioremap *map =3D container_of(rcu, struct acpi_ioremap=
, rcu);
>> +
>> +	async_schedule(acpi_os_async_umap, map);
>> +}
>> +
>>  static void acpi_os_map_cleanup(struct acpi_ioremap *map)
>>  {
>> -	if (!map->refcount) {
>> -		synchronize_rcu();
>> -		acpi_unmap(map->phys, map->virt);
>> -		kfree(map);
>> -	}
>> +	if (!map->refcount)
>> +		call_rcu(&map->rcu, acpi_os_map_reclaim);
>>  }
>> =20
>>  void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
>>
>=20
> This goes a bit too far.  First, if you need to start an async thread=
,
> you can simply do synchronize_rcu() from there. =20

Yes, that will be simple.

> Second, though, perhaps
> we can address the whole deadlock in a different way.
>=20
> For example, if we do something like the patch below (which I haven't
> tested, but it should work if I'm not missing something horribly), we
> won't be taking the ACPI namespace lock under the CPU hotplug lock
> in acpi_cpu_soft_notify() any more.

I considered this before. But the notify callback still will evaluate
ACPI method and may hold ACPICA's namespace lock. E.G "_CST".

Calltrace:
	acpi_cpu_soft_notify()
	acpi_processor_hotplug()
	acpi_processor_get_power_info()=09
	acpi_processor_get_power_info_cst()

>=20
> Rafael
>=20
> ---
>  drivers/acpi/processor_driver.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> Index: linux-pm/drivers/acpi/processor_driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/processor_driver.c
> +++ linux-pm/drivers/acpi/processor_driver.c
> @@ -129,7 +129,11 @@ static int acpi_cpu_soft_notify(struct n
>  	if (action =3D=3D CPU_STARTING || action =3D=3D CPU_DYING)
>  		return NOTIFY_DONE;
> =20
> -	if (!pr || acpi_bus_get_device(pr->handle, &device))
> +	if (!pr || !pr->dev)
> +		return NOTIFY_DONE;
> +
> +	device =3D ACPI_COMPANION(pr->dev);
> +	if (!device)
>  		return NOTIFY_DONE;
> =20
>  	if (action =3D=3D CPU_ONLINE) {
>=20


--=20
Best regards
Tianyu Lan
