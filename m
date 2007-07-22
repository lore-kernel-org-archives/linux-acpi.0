From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] ACPI: export ACPI events via acpi_mc_group multicast group
Date: Sun, 22 Jul 2007 13:23:27 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE8294D7@pdsmsx414.ccr.corp.intel.com>
References: <200707220101.01278.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7CC20.6EDAA4BA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55308 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbXGVFXb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 01:23:31 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200707220101.01278.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, johannes@sipsolutions.net, hadi@cyberus.ca

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7CC20.6EDAA4BA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Oops. Sorry.
Attached here. :)

Thanks,
Rui

-----Original Message-----
From: Len Brown [mailto:lenb@kernel.org]=20
Sent: Sunday, July 22, 2007 1:01 PM
To: Zhang, Rui
Cc: linux-acpi@vger.kernel.org; johannes@sipsolutions.net;
hadi@cyberus.ca
Subject: Re: [PATCH] ACPI: export ACPI events via acpi_mc_group
multicast group

either my mail client is smarter than I am,
or the new acpi_genl demo program was not attached to your message --=20
can you send it along?

thanks,
-Len

On Friday 20 July 2007 04:41, Zhang Rui wrote:
> This is an incremental patch for the recent genetlink
> multicast changes.
>=20
> Now ACPI events are exported via generic netlink multicast group.
>=20
> Attachment is an refreshed user space demo "acpi_genl"
> that receives genetlink multicast messages from acpi_mc_group.
>=20
> Thanks for Johannes' help on developing this patch and
> the user space demo.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/event.c |   29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>=20
> Index: linux-2.6.22/drivers/acpi/event.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22.orig/drivers/acpi/event.c
> +++ linux-2.6.22/drivers/acpi/event.c
> @@ -132,30 +132,19 @@ enum {
>  };
>  #define ACPI_GENL_CMD_MAX (__ACPI_GENL_CMD_MAX - 1)
> =20
> -#define ACPI_GENL_NAME		"acpi_event"
> -#define ACPI_GENL_VERSION	0x01
> +#define ACPI_GENL_FAMILY_NAME		"acpi_event"
> +#define ACPI_GENL_VERSION		0x01
> +#define ACPI_GENL_MCAST_GROUP_NAME 	"acpi_mc_group"
> =20
>  static struct genl_family acpi_event_genl_family =3D {
>  	.id =3D GENL_ID_GENERATE,
> -	.name =3D ACPI_GENL_NAME,
> +	.name =3D ACPI_GENL_FAMILY_NAME,
>  	.version =3D ACPI_GENL_VERSION,
>  	.maxattr =3D ACPI_GENL_ATTR_MAX,
>  };
> =20
> -/* .doit: standard command callback */
> -static int acpi_genl_cmd_event(struct sk_buff *skb, struct genl_info
*info)
> -{
> -	struct acpi_genl_event *event =3D info->userhdr;
> -
> -	if (!event)
> -		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "ACPI event: NULL\n"));
> -
> -	return 0;
> -}
> -
> -static struct genl_ops acpi_event_genl_ops =3D {
> -	.cmd =3D ACPI_GENL_CMD_EVENT,
> -	.doit =3D acpi_genl_cmd_event,
> +static struct genl_multicast_group acpi_event_mcgrp =3D {
> +	.name =3D ACPI_GENL_MCAST_GROUP_NAME,
>  };
> =20
>  int acpi_bus_generate_genetlink_event(struct acpi_device *device,
> @@ -215,7 +204,7 @@ int acpi_bus_generate_genetlink_event(st
>  	}
> =20
>  	result =3D
> -	    genlmsg_multicast(skb, 0, acpi_event_genl_family.id,
GFP_ATOMIC);
> +	    genlmsg_multicast(skb, 0, acpi_event_mcgrp.id, GFP_ATOMIC);
>  	if (result)
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Failed to send a Genetlink
message!\n"));
> @@ -230,8 +219,8 @@ static int acpi_event_genetlink_init(voi
>  	if (result)
>  		return result;
> =20
> -	result =3D
> -	    genl_register_ops(&acpi_event_genl_family,
&acpi_event_genl_ops);
> +	result =3D genl_register_mc_group(&acpi_event_genl_family,
> +					&acpi_event_mcgrp);
>  	if (result)
>  		genl_unregister_family(&acpi_event_genl_family);
> =20
>=20

------_=_NextPart_001_01C7CC20.6EDAA4BA
Content-Type: application/x-compressed;
	name="acpi_genl.tgz"
Content-Transfer-Encoding: base64
Content-Description: acpi_genl.tgz
Content-Disposition: attachment;
	filename="acpi_genl.tgz"

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
QqFQKBQKhUKhUCgUCoVC8f/gF1LuehAAoAAA

------_=_NextPart_001_01C7CC20.6EDAA4BA--
