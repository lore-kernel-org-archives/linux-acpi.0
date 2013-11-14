From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2] ACPI / bind: Use (put|get)_device() on ACPI device
 objects too
Date: Thu, 14 Nov 2013 15:20:09 +0800
Message-ID: <528479A9.9020802@intel.com>
References: <3268437.YsusHvklcv@vostro.rjw.lan> <1803808.ghCmmaO2Cj@vostro.rjw.lan> <9712243.It8gvaRCs0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41047 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab3KNHbW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Nov 2013 02:31:22 -0500
In-Reply-To: <9712243.It8gvaRCs0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>

On 2013=E5=B9=B411=E6=9C=8814=E6=97=A5 07:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> When associating a "physical" device with an ACPI device object
> acpi_bind_one() only uses get_device() to increment the reference
> counter of the former, but there is no reason not to do that with
> the latter too.  Among other things, that may help to avoid
> use-after-free when an ACPI device object is freed without calling
> acpi_unbind_one() for all "physical" devices associated with it
> (that only can happen in buggy code, but then it's better if the
> kernel doesn't crash as a result of a bug).
>=20
> For this reason, modify acpi_bind_one() to apply get_device() to
> the ACPI device object too and update acpi_unbind_one() to drop
> that reference using put_device() as appropriate.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/glue.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> Index: linux-pm/drivers/acpi/glue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/glue.c
> +++ linux-pm/drivers/acpi/glue.c
> @@ -217,6 +217,7 @@ int acpi_bind_one(struct device *dev, ac
>  	if (!acpi_dev)
>  		return -EINVAL;
> =20
> +	get_device(&acpi_dev->dev);
>  	get_device(dev);
>  	physical_node =3D kzalloc(sizeof(*physical_node), GFP_KERNEL);
>  	if (!physical_node) {
> @@ -243,6 +244,7 @@ int acpi_bind_one(struct device *dev, ac
>  				goto err;
> =20
>  			put_device(dev);
> +			put_device(&acpi_dev->dev);
>  			return 0;
>  		}
>  		if (pn->node_id =3D=3D node_id) {
> @@ -282,6 +284,7 @@ int acpi_bind_one(struct device *dev, ac
>   err:
>  	ACPI_COMPANION_SET(dev, NULL);
>  	put_device(dev);
> +	put_device(&acpi_dev->dev);
>  	return retval;
>  }
>  EXPORT_SYMBOL_GPL(acpi_bind_one);
> @@ -307,8 +310,9 @@ int acpi_unbind_one(struct device *dev)
>  			sysfs_remove_link(&acpi_dev->dev.kobj, physnode_name);
>  			sysfs_remove_link(&dev->kobj, "firmware_node");
>  			ACPI_COMPANION_SET(dev, NULL);
> -			/* acpi_bind_one() increase refcnt by one. */
> +			/* Drop references taken by acpi_bind_one(). */
>  			put_device(dev);
> +			put_device(&acpi_dev->dev);
>  			kfree(entry);
>  			break;
>  		}
>=20

Reviewed-by: Lan Tianyu <tianyu.lan@intel.com>

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
