From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH 1/4] IPMI: Add one interface to get more info of
	low-level IPMI device
Date: Mon, 15 Nov 2010 15:52:43 +0800
Message-ID: <1289807563.3769.49.camel@localhost.localdomain>
References: <1288084454-560-1-git-send-email-yakui.zhao@intel.com>
	 <1288084454-560-2-git-send-email-yakui.zhao@intel.com>
	 <4CC84FAA.9040401@acm.org>
	 <1288227644.3885.203.camel@localhost.localdomain>
	 <1288675990.26046.9.camel@localhost.localdomain>  <4CD2012A.20200@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39363 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980Ab0KOH5N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Nov 2010 02:57:13 -0500
In-Reply-To: <4CD2012A.20200@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2010-11-04 at 08:41 +0800, Corey Minyard wrote:
> On 11/02/2010 12:33 AM, ykzhao wrote:
> > On Thu, 2010-10-28 at 09:00 +0800, ykzhao wrote:
> >
> >> On Thu, 2010-10-28 at 00:13 +0800, Corey Minyard wrote:
> >>
> >>> I think you miss the point of a refcount.  The refcount is to kee=
p the
> >>> data structure around even if the device has gone away, so that a=
ny
> >>> users may not crash.  Just having a counter in the IPMI structure=
 and
> >>> then decrementing the device refcount is not going to accomplish =
anything.
> >>>
> >>> And you don't really need to refcount the IPMI structure.  (And i=
f you
> >>> did, you would need to use a refcount structure and you would nee=
d to
> >>> keep from freeing the IPMI structure until the refcount went to z=
ero.)
> >>> You just need to increment the refcount on the device structure, =
and
> >>> whoever gets the device structure needs to be responsible for
> >>> decrementing it's refcount.
> >>>
> >> Yes. After the copy mechanism is used, it is unnecessary to use th=
e
> >> refcount to protect the corresponding data structure.
> >>
> >> In fact the purpose of adding another one refcount is to add/decre=
ase
> >> the refcount of dev in course of calling the function of
> >> ipmi_get_smi_info/ipmi_put_smi_info.
> >>       But after I look at the smi_watcher mechanism, I find that t=
he
> >> refcount of dev is not released correctly in the following case.
> >>          Step 1:  Other driver registers one smi_watcher and the
> >> ipmi_get_smi_info is called in the new_smi callback function. (And=
 the
> >> driver will use the dev pointer before the ipmi_put_smi_info is
> >> called).
> >>          Step 2: for any reason, the IPMI device will be unregiste=
red by calling
> >> cleanup_one_si. This function will remove it from the IPMI device =
list
> >> firstly and then call the smi_gone for every smi_watcher.
> >>          Step 3: the ipmi_put_smi_info is called in smi_gone callb=
ack function.
> >> In such case the ipmi_put_smi_info can't find the corresponding IP=
MI
> >> device based on the given if_num and can't release the pointer of =
dev.
> >>
> >> But after adding another refcount, we can handle the above scenari=
o. At
> >> the same time even when the ipmi_put_smi_info is not called by the
> >> caller, it still can work.
> >> Not sure whether the above thought is redundant?
> >>
> > Corey,
> >      Is the above thought correct? If not, please correct me. In fa=
ct the
> > purpose of adding another refcount is to fix the incorrect inc/dec =
in
> > course of calling ipmi_get_smi_info/ipmi_put_smi_info.
> >
>=20

Hi, Corey
    Sorry for the late response.

> No.  The purpose of a refcount is to keep from freeing a data structu=
re
> while it is in use.
>=20
> Let's say your code gets the device structure for the IPMI device, th=
en
> a task switch occurs.  During the time it is not running, the IPMI
> device is hotplugged away and no longer exists.  The device is delete=
d.
> When your code starts running again, it still has a pointer to that
> device structure.  Sure, the removal code may have run, but your code
> still has a pointer to that device structure.  Which has been freed. =
 Bad.

Thanks for the detailed explanation about the refcount.

> This is what refcounts (well, krefs) do.  In the above scenario, your
> code will get the device with the kref incremented.  All the above
> happens, but since you have incremented the refcount on the device
> structure, it will not be deleted.  It will wait until you put
> (decrement) the refcount before performing the free.

The above consideration is based on the assumption that the function of
ipmi_put_smi_info is called in the function of smi_watcher smi_gone
callback function. Not sure whether it is correct? Or is there any
problem about the definition of ipmi_put_smi_info?

=EF=BB=BF void ipmi_put_smi_info(int if_num)
+{
+       ipmi_smi_t    intf;
+       struct ipmi_smi_handlers *handlers;
+
+       mutex_lock(&ipmi_interfaces_mutex);
+       list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+               if (intf->intf_num =3D=3D if_num)
+                       goto found;
+       }
+       /* Not found, return */
+       mutex_unlock(&ipmi_interfaces_mutex);
+       return;
+
+found:
+       handlers =3D intf->handlers;
+       handlers->put_smi_info(intf->send_info);
+       mutex_unlock(&ipmi_interfaces_mutex);
+}



The refcount of kref can't be decreased correctly in the following two
cases:
	a. When one smi_watcher is unregistered by calling
ipmi_smi_watcher_unregister, we only delete it from the smi_watcher lis=
t
and won't call the smi_gone callback function.
	b. The function of cleanup_one_si is to unregister one IPMI interface.
It will remove the ipmi interface from the corresponding ipmi list and
then call smi_gone callback function for every smi_watcher. As the
corresponding IPMI interface is already removed from the IPMI interface
list, it can't find the corresponding IPMI interface based on the
interface number. In such case the refcount of dev can't be released
correctly.=20

>=20
> >
> >>
> >>
> >>> I'd also prefer to not have a struct ipmi_smi_info in the IPMI da=
ta
> >>> structure.  Just pull the data from existing sources.
> >>>
> >> At most cases the requirement is different for the different addr =
source
> >> type. If we don't put the ipmi_smi_info in the IPMI data structure=
, I am
> >> afraid that we will have to fill the corresponding info based on t=
he
> >> addr source type. Maybe it will be more complex.
> >>
> > If only pull data from the existing source, it can save some
> > memory-space. But it seems a bit complex as we have to fill the inf=
o
> > based on the corresponding addr source type. And this should be don=
e
> > every time the function of ipmi_get_smi_info is called.
> >
>=20
> I don't think it's that complex, and I doubt that function is called
> that often.

Ok. I will refresh the patch set and fill the corresponding data
structure from the existing source. But as I don't know what info is
required for the other ipmi type except the SI_ACPI type, I will only
add the info of SI_ACPI type.

>=20
> -corey
> >
> >> Thanks.
> >>          Yakui
> >>
> >>
> >>> -corey
> >>>
> >>> On 10/26/2010 04:14 AM, yakui.zhao@intel.com wrote:
> >>>
> >>>> From: Zhao Yakui<yakui.zhao@intel.com>
> >>>>
> >>>> The IPMI smi_watcher will be used to catch the IPMI interface as=
 they come or go.
> >>>> In order to communicate with the correct IPMI device, it should =
be confirmed
> >>>>    whether it is what we wanted especially on the system with mu=
ltiple IPMI
> >>>> devices. But the new_smi callback function of smi_watcher provid=
es very
> >>>> limited info(only the interface number and dev pointer) and ther=
e is no
> >>>> detailed info about the low level interface. For example: which =
mechansim
> >>>> registers the IPMI interface(ACPI, PCI, DMI and so on).
> >>>>
> >>>> This is to add one interface that can get more info of low-level=
 IPMI
> >>>> device. For example: the ACPI device handle will be returned for=
 the pnp_acpi
> >>>> IPMI device.
> >>>>
> >>>> Signed-off-by: Zhao Yakui<yakui.zhao@intel.com>
> >>>> ---
> >>>>    drivers/char/ipmi/ipmi_msghandler.c |   46 ++++++++++++++++++=
++++++++++++++
> >>>>    drivers/char/ipmi/ipmi_si_intf.c    |   49 ++++++++++++++++++=
+++++++++++++---
> >>>>    include/linux/ipmi.h                |   29 ++++++++++++++++++=
++
> >>>>    include/linux/ipmi_smi.h            |    8 +++++
> >>>>    4 files changed, 127 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/=
ipmi/ipmi_msghandler.c
> >>>> index 4f3f8c9..e323edb 100644
> >>>> --- a/drivers/char/ipmi/ipmi_msghandler.c
> >>>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> >>>> @@ -970,6 +970,52 @@ out_kfree:
> >>>>    }
> >>>>    EXPORT_SYMBOL(ipmi_create_user);
> >>>>
> >>>> +int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data)
> >>>> +{
> >>>> +   int           rv =3D 0;
> >>>> +   ipmi_smi_t    intf;
> >>>> +   struct ipmi_smi_handlers *handlers;
> >>>> +
> >>>> +   mutex_lock(&ipmi_interfaces_mutex);
> >>>> +   list_for_each_entry_rcu(intf,&ipmi_interfaces, link) {
> >>>> +           if (intf->intf_num =3D=3D if_num)
> >>>> +                   goto found;
> >>>> +   }
> >>>> +   /* Not found, return an error */
> >>>> +   rv =3D -EINVAL;
> >>>> +   mutex_unlock(&ipmi_interfaces_mutex);
> >>>> +   return rv;
> >>>> +
> >>>> +found:
> >>>> +   handlers =3D intf->handlers;
> >>>> +   rv =3D handlers->get_smi_info(intf->send_info, data);
> >>>> +   mutex_unlock(&ipmi_interfaces_mutex);
> >>>> +
> >>>> +   return rv;
> >>>> +}
> >>>> +EXPORT_SYMBOL(ipmi_get_smi_info);
> >>>> +
> >>>> +void ipmi_put_smi_info(int if_num)
> >>>> +{
> >>>> +   ipmi_smi_t    intf;
> >>>> +   struct ipmi_smi_handlers *handlers;
> >>>> +
> >>>> +   mutex_lock(&ipmi_interfaces_mutex);
> >>>> +   list_for_each_entry_rcu(intf,&ipmi_interfaces, link) {
> >>>> +           if (intf->intf_num =3D=3D if_num)
> >>>> +                   goto found;
> >>>> +   }
> >>>> +   /* Not found, return */
> >>>> +   mutex_unlock(&ipmi_interfaces_mutex);
> >>>> +   return;
> >>>> +
> >>>> +found:
> >>>> +   handlers =3D intf->handlers;
> >>>> +   handlers->put_smi_info(intf->send_info);
> >>>> +   mutex_unlock(&ipmi_interfaces_mutex);
> >>>> +}
> >>>> +EXPORT_SYMBOL(ipmi_put_smi_info);
> >>>> +
> >>>>    static void free_user(struct kref *ref)
> >>>>    {
> >>>>      ipmi_user_t user =3D container_of(ref, struct ipmi_user, re=
fcount);
> >>>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipm=
i/ipmi_si_intf.c
> >>>> index 7bd7c45..d313018 100644
> >>>> --- a/drivers/char/ipmi/ipmi_si_intf.c
> >>>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> >>>> @@ -57,6 +57,7 @@
> >>>>    #include<asm/irq.h>
> >>>>    #include<linux/interrupt.h>
> >>>>    #include<linux/rcupdate.h>
> >>>> +#include<linux/ipmi.h>
> >>>>    #include<linux/ipmi_smi.h>
> >>>>    #include<asm/io.h>
> >>>>    #include "ipmi_si_sm.h"
> >>>> @@ -107,10 +108,6 @@ enum si_type {
> >>>>    };
> >>>>    static char *si_to_str[] =3D { "kcs", "smic", "bt" };
> >>>>
> >>>> -enum ipmi_addr_src {
> >>>> -   SI_INVALID =3D 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI,=
 SI_SMBIOS,
> >>>> -   SI_PCI, SI_DEVICETREE, SI_DEFAULT
> >>>> -};
> >>>>    static char *ipmi_addr_src_to_str[] =3D { NULL, "hotmod", "ha=
rdcoded", "SPMI",
> >>>>                                      "ACPI", "SMBIOS", "PCI",
> >>>>                                      "device-tree", "default" };
> >>>> @@ -291,6 +288,12 @@ struct smi_info {
> >>>>      struct task_struct *thread;
> >>>>
> >>>>      struct list_head link;
> >>>> +   /*
> >>>> +    * Count the refcount of smi_data->dev related with the func=
tion
> >>>> +    * of ipmi_get_smi_info/ipmi_put_smi_info.
> >>>> +    */
> >>>> +   atomic_t        smi_info_ref;
> >>>> +   struct ipmi_smi_info smi_data;
> >>>>    };
> >>>>
> >>>>    #define smi_inc_stat(smi, stat) \
> >>>> @@ -1186,6 +1189,27 @@ static int smi_start_processing(void     =
  *send_info,
> >>>>      return 0;
> >>>>    }
> >>>>
> >>>> +static int get_smi_info(void *send_info, struct ipmi_smi_info *=
data)
> >>>> +{
> >>>> +   struct smi_info *new_smi =3D send_info;
> >>>> +   struct ipmi_smi_info *smi_data =3D&new_smi->smi_data;
> >>>> +
> >>>> +   get_device(new_smi->dev);
> >>>> +   memcpy(data, smi_data, sizeof(*smi_data));
> >>>> +   smi_data->addr_src =3D new_smi->addr_source;
> >>>> +   atomic_inc(&new_smi->smi_info_ref);
> >>>> +
> >>>> +   return 0;
> >>>> +}
> >>>> +
> >>>> +static void put_smi_info(void *send_info)
> >>>> +{
> >>>> +   struct smi_info *new_smi =3D send_info;
> >>>> +
> >>>> +   put_device(new_smi->dev);
> >>>> +   atomic_dec(&new_smi->smi_info_ref);
> >>>> +}
> >>>> +
> >>>>    static void set_maintenance_mode(void *send_info, int enable)
> >>>>    {
> >>>>      struct smi_info   *smi_info =3D send_info;
> >>>> @@ -1197,6 +1221,8 @@ static void set_maintenance_mode(void *sen=
d_info, int enable)
> >>>>    static struct ipmi_smi_handlers handlers =3D {
> >>>>      .owner                  =3D THIS_MODULE,
> >>>>      .start_processing       =3D smi_start_processing,
> >>>> +   .get_smi_info           =3D get_smi_info,
> >>>> +   .put_smi_info           =3D put_smi_info,
> >>>>      .sender                 =3D sender,
> >>>>      .request_events         =3D request_events,
> >>>>      .set_maintenance_mode   =3D set_maintenance_mode,
> >>>> @@ -2143,6 +2169,8 @@ static int __devinit ipmi_pnp_probe(struct=
 pnp_dev *dev,
> >>>>              return -ENOMEM;
> >>>>
> >>>>      info->addr_source =3D SI_ACPI;
> >>>> +   info->smi_data.addr_info.acpi_info.acpi_handle =3D
> >>>> +                           acpi_dev->handle;
> >>>>      printk(KERN_INFO PFX "probing via ACPI\n");
> >>>>
> >>>>      handle =3D acpi_dev->handle;
> >>>> @@ -3092,6 +3120,7 @@ static int try_smi_init(struct smi_info *n=
ew_smi)
> >>>>    {
> >>>>      int rv =3D 0;
> >>>>      int i;
> >>>> +   struct ipmi_smi_info *smi_data;
> >>>>
> >>>>      printk(KERN_INFO PFX "Trying %s-specified %s state"
> >>>>             " machine at %s address 0x%lx, slave address 0x%x,"
> >>>> @@ -3255,6 +3284,9 @@ static int try_smi_init(struct smi_info *n=
ew_smi)
> >>>>
> >>>>      dev_info(new_smi->dev, "IPMI %s interface initialized\n",
> >>>>               si_to_str[new_smi->si_type]);
> >>>> +   smi_data =3D&new_smi->smi_data;
> >>>> +   smi_data->dev =3D new_smi->dev;
> >>>> +   atomic_set(&new_smi->smi_info_ref, 0);
> >>>>
> >>>>      return 0;
> >>>>
> >>>> @@ -3501,7 +3533,14 @@ static void cleanup_one_si(struct smi_inf=
o *to_clean)
> >>>>              printk(KERN_ERR PFX "Unable to unregister device: e=
rrno=3D%d\n",
> >>>>                     rv);
> >>>>      }
> >>>> -
> >>>> +   /* maybe the caller doesn't release the refcount of dev, whi=
ch is
> >>>> +    * increased by calling the function of ipmi_get_smi_info. S=
o try
> >>>> +    * to help it.
> >>>> +    */
> >>>> +   while (atomic_read(&to_clean->smi_info_ref)) {
> >>>> +           put_device(to_clean->dev);
> >>>> +           atomic_dec(&to_clean->smi_info_ref);
> >>>> +   }
> >>>>      if (to_clean->handlers)
> >>>>              to_clean->handlers->cleanup(to_clean->si_sm);
> >>>>
> >>>> diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
> >>>> index 65aae34..9a0c72e 100644
> >>>> --- a/include/linux/ipmi.h
> >>>> +++ b/include/linux/ipmi.h
> >>>> @@ -454,6 +454,35 @@ unsigned int ipmi_addr_length(int addr_type=
);
> >>>>    /* Validate that the given IPMI address is valid. */
> >>>>    int ipmi_validate_addr(struct ipmi_addr *addr, int len);
> >>>>
> >>>> +enum ipmi_addr_src {
> >>>> +   SI_INVALID =3D 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI,=
 SI_SMBIOS,
> >>>> +   SI_PCI, SI_DEVICETREE, SI_DEFAULT
> >>>> +};
> >>>> +struct ipmi_smi_info {
> >>>> +   enum ipmi_addr_src addr_src;
> >>>> +   struct device *dev;
> >>>> +   /*
> >>>> +    * The addr_info can provide more detailed info of one IPMI =
device.
> >>>> +    * Now only SI_ACPI info is provided. And it depends on the =
SI_ACPI
> >>>> +    * address type. If the info is required for other address t=
ype, please
> >>>> +    * add it.
> >>>> +    */
> >>>> +   union {
> >>>> +           /* the acpi_info element is defined for the SI_ACPI
> >>>> +            * address type
> >>>> +            */
> >>>> +           struct {
> >>>> +                   void *acpi_handle;
> >>>> +           } acpi_info;
> >>>> +   } addr_info;
> >>>> +};
> >>>> +
> >>>> +/* This is to get the private info of ipmi_smi_t */
> >>>> +extern int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *=
data);
> >>>> +/* This is to decrease refcount of dev added in the function of
> >>>> + * ipmi_get_smi_info
> >>>> + */
> >>>> +extern void ipmi_put_smi_info(int if_num);
> >>>>    #endif /* __KERNEL__ */
> >>>>
> >>>>
> >>>> diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
> >>>> index 4b48318..b99942d 100644
> >>>> --- a/include/linux/ipmi_smi.h
> >>>> +++ b/include/linux/ipmi_smi.h
> >>>> @@ -86,6 +86,14 @@ struct ipmi_smi_handlers {
> >>>>      int (*start_processing)(void       *send_info,
> >>>>                              ipmi_smi_t new_intf);
> >>>>
> >>>> +   /*
> >>>> +    * Get the detailed private info of the low level interface =
and store
> >>>> +    * it into the structure of ipmi_smi_data. For example: the
> >>>> +    * ACPI device handle will be returned for the pnp_acpi IPMI=
 device.
> >>>> +    */
> >>>> +   int (*get_smi_info)(void *send_info, struct ipmi_smi_info *d=
ata);
> >>>> +
> >>>> +   void (*put_smi_info)(void *send_info);
> >>>>      /* Called to enqueue an SMI message to be sent.  This
> >>>>         operation is not allowed to fail.  If an error occurs, i=
t
> >>>>         should report back the error in a received message.  It =
may
> >>>>
> >>>>
> >>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
