From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH 1/4] IPMI: Add one interface to get more info of
	low-level IPMI device
Date: Mon, 06 Dec 2010 09:06:42 +0800
Message-ID: <1291597602.3948.300.camel@localhost.localdomain>
References: <1291076781-9438-1-git-send-email-yakui.zhao@intel.com>
	 <1291076781-9438-2-git-send-email-yakui.zhao@intel.com>
	 <1291077392.3948.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42861 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab0LFBIL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Dec 2010 20:08:11 -0500
In-Reply-To: <1291077392.3948.141.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "minyard@acm.org" <minyard@acm.org>
Cc: "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-11-30 at 08:36 +0800, ykzhao wrote:
> On Tue, 2010-11-30 at 08:26 +0800, yakui.zhao@intel.com wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >=20
> > The IPMI smi_watcher will be used to catch the IPMI interface as th=
ey come or go.
> > In order to communicate with the correct IPMI device, it should be =
confirmed
> >  whether it is what we wanted especially on the system with multipl=
e IPMI
> > devices. But the new_smi callback function of smi_watcher provides =
very
> > limited info(only the interface number and dev pointer) and there i=
s no
> > detailed info about the low level interface. For example: which mec=
hansim
> > registers the IPMI interface(ACPI, PCI, DMI and so on).
> >=20
> > This is to add one interface that can get more info of low-level IP=
MI
> > device. For example: the ACPI device handle will be returned for th=
e pnp_acpi
> > IPMI device.
>=20
> Hi, Corey
>=20
>    The following is updated in the patch set.
>     a. Change the function prototype of ipmi_put_smi_info.
>        The corresponding parameter is changed from "
> 		Ipmi_put_smi_info(int iface) to ipmi_put_smi_info(struct ipmi_smi_i=
nfo
> *data)
>=20
>     b. Remove the incorrect refcount in previous patch set.

>=20
> But for the issues about pulling data from the current source, very
> sorry that I still statically construct them in the corresponding
> smi_info as I meet with the following two issues when trying to pull
> data from the current source.
> 	1. no specific info is contained in smi_info. For example: ACPI hand=
le
> is important to the SI_ACPI type. But the corresponding handle is sto=
red
> in smi_info.=20
>         b. Need to add a lot of If/else macro definitions to handle t=
he
> corresponding IPMI device type.

=EF=BB=BF
Hi, Corey
     Any comments about the updated patch set?

Thanks.
>=20
> Thanks.
>=20
> >=20
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c |   31 +++++++++++++++++++++++=
++++++++
> >  drivers/char/ipmi/ipmi_si_intf.c    |   24 ++++++++++++++++++++---=
-
> >  include/linux/ipmi.h                |   29 +++++++++++++++++++++++=
++++++
> >  include/linux/ipmi_smi.h            |    7 +++++++
> >  4 files changed, 87 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipm=
i/ipmi_msghandler.c
> > index 2fe72f8..a90b3ec 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -970,6 +970,37 @@ out_kfree:
> >  }
> >  EXPORT_SYMBOL(ipmi_create_user);
> > =20
> > +int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data)
> > +{
> > +	int           rv =3D 0;
> > +	ipmi_smi_t    intf;
> > +	struct ipmi_smi_handlers *handlers;
> > +
> > +	mutex_lock(&ipmi_interfaces_mutex);
> > +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> > +		if (intf->intf_num =3D=3D if_num)
> > +			goto found;
> > +	}
> > +	/* Not found, return an error */
> > +	rv =3D -EINVAL;
> > +	mutex_unlock(&ipmi_interfaces_mutex);
> > +	return rv;
> > +
> > +found:
> > +	handlers =3D intf->handlers;
> > +	rv =3D handlers->get_smi_info(intf->send_info, data);
> > +	mutex_unlock(&ipmi_interfaces_mutex);
> > +
> > +	return rv;
> > +}
> > +EXPORT_SYMBOL(ipmi_get_smi_info);
> > +
> > +void ipmi_put_smi_info(struct ipmi_smi_info *data)
> > +{
> > +	put_device(data->dev);
> > +}
> > +EXPORT_SYMBOL(ipmi_put_smi_info);
> > +
> >  static void free_user(struct kref *ref)
> >  {
> >  	ipmi_user_t user =3D container_of(ref, struct ipmi_user, refcount=
);
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/i=
pmi_si_intf.c
> > index 035da9e..a41afca 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -57,6 +57,7 @@
> >  #include <asm/irq.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/ipmi.h>
> >  #include <linux/ipmi_smi.h>
> >  #include <asm/io.h>
> >  #include "ipmi_si_sm.h"
> > @@ -107,10 +108,6 @@ enum si_type {
> >  };
> >  static char *si_to_str[] =3D { "kcs", "smic", "bt" };
> > =20
> > -enum ipmi_addr_src {
> > -	SI_INVALID =3D 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_S=
MBIOS,
> > -	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
> > -};
> >  static char *ipmi_addr_src_to_str[] =3D { NULL, "hotmod", "hardcod=
ed", "SPMI",
> >  					"ACPI", "SMBIOS", "PCI",
> >  					"device-tree", "default" };
> > @@ -291,6 +288,7 @@ struct smi_info {
> >  	struct task_struct *thread;
> > =20
> >  	struct list_head link;
> > +	struct ipmi_smi_info smi_data;
> >  };
> > =20
> >  #define smi_inc_stat(smi, stat) \
> > @@ -1186,6 +1184,18 @@ static int smi_start_processing(void       *=
send_info,
> >  	return 0;
> >  }
> > =20
> > +static int get_smi_info(void *send_info, struct ipmi_smi_info *dat=
a)
> > +{
> > +	struct smi_info *new_smi =3D send_info;
> > +	struct ipmi_smi_info *smi_data =3D &new_smi->smi_data;
> > +
> > +	memcpy(data, smi_data, sizeof(*smi_data));
> > +	data->addr_src =3D new_smi->addr_source;
> > +	get_device(new_smi->dev);
> > +
> > +	return 0;
> > +}
> > +
> >  static void set_maintenance_mode(void *send_info, int enable)
> >  {
> >  	struct smi_info   *smi_info =3D send_info;
> > @@ -1197,6 +1207,7 @@ static void set_maintenance_mode(void *send_i=
nfo, int enable)
> >  static struct ipmi_smi_handlers handlers =3D {
> >  	.owner                  =3D THIS_MODULE,
> >  	.start_processing       =3D smi_start_processing,
> > +	.get_smi_info		=3D get_smi_info,
> >  	.sender			=3D sender,
> >  	.request_events		=3D request_events,
> >  	.set_maintenance_mode   =3D set_maintenance_mode,
> > @@ -2153,6 +2164,8 @@ static int __devinit ipmi_pnp_probe(struct pn=
p_dev *dev,
> >  		return -ENOMEM;
> > =20
> >  	info->addr_source =3D SI_ACPI;
> > +	info->smi_data.addr_info.acpi_info.acpi_handle =3D
> > +				acpi_dev->handle;
> >  	printk(KERN_INFO PFX "probing via ACPI\n");
> > =20
> >  	handle =3D acpi_dev->handle;
> > @@ -3102,6 +3115,7 @@ static int try_smi_init(struct smi_info *new_=
smi)
> >  {
> >  	int rv =3D 0;
> >  	int i;
> > +	struct ipmi_smi_info *smi_data;
> > =20
> >  	printk(KERN_INFO PFX "Trying %s-specified %s state"
> >  	       " machine at %s address 0x%lx, slave address 0x%x,"
> > @@ -3263,6 +3277,8 @@ static int try_smi_init(struct smi_info *new_=
smi)
> >  	dev_info(new_smi->dev, "IPMI %s interface initialized\n",
> >  		 si_to_str[new_smi->si_type]);
> > =20
> > +	smi_data =3D &new_smi->smi_data;
> > +	smi_data->dev =3D new_smi->dev;
> >  	return 0;
> > =20
> >   out_err_stop_timer:
> > diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
> > index 65aae34..956bd41 100644
> > --- a/include/linux/ipmi.h
> > +++ b/include/linux/ipmi.h
> > @@ -454,6 +454,35 @@ unsigned int ipmi_addr_length(int addr_type);
> >  /* Validate that the given IPMI address is valid. */
> >  int ipmi_validate_addr(struct ipmi_addr *addr, int len);
> > =20
> > +enum ipmi_addr_src {
> > +	SI_INVALID =3D 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_S=
MBIOS,
> > +	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
> > +};
> > +struct ipmi_smi_info {
> > +	enum ipmi_addr_src addr_src;
> > +	struct device *dev;
> > +	/*
> > +	 * The addr_info can provide more detailed info of one IPMI devic=
e.
> > +	 * Now only SI_ACPI info is provided. And it depends on the SI_AC=
PI
> > +	 * address type. If the info is required for other address type, =
please
> > +	 * add it.
> > +	 */
> > +	union {
> > +		/* the acpi_info element is defined for the SI_ACPI
> > +		 * address type
> > +		 */
> > +		struct {
> > +			void *acpi_handle;
> > +		} acpi_info;
> > +	} addr_info;
> > +};
> > +
> > +/* This is to get the private info of ipmi_smi_t */
> > +extern int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *dat=
a);
> > +/* This is to decrease refcount of dev added in the function of
> > + * ipmi_get_smi_info
> > + */
> > +extern void ipmi_put_smi_info(struct ipmi_smi_info *data);
> >  #endif /* __KERNEL__ */
> > =20
> >=20
> > diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
> > index 4b48318..deabdcc 100644
> > --- a/include/linux/ipmi_smi.h
> > +++ b/include/linux/ipmi_smi.h
> > @@ -86,6 +86,13 @@ struct ipmi_smi_handlers {
> >  	int (*start_processing)(void       *send_info,
> >  				ipmi_smi_t new_intf);
> > =20
> > +	/*
> > +	 * Get the detailed private info of the low level interface and s=
tore
> > +	 * it into the structure of ipmi_smi_data. For example: the
> > +	 * ACPI device handle will be returned for the pnp_acpi IPMI devi=
ce.
> > +	 */
> > +	int (*get_smi_info)(void *send_info, struct ipmi_smi_info *data);
> > +
> >  	/* Called to enqueue an SMI message to be sent.  This
> >  	   operation is not allowed to fail.  If an error occurs, it
> >  	   should report back the error in a received message.  It may
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
