From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] libnvdimm, test: add mock SMART data payload
Date: Thu, 07 Apr 2016 10:27:54 +0200
Message-ID: <32455510.OFm6LAzW1p@c203>
References: <20160407005349.30117.44157.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52961 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbcDGI14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2016 04:27:56 -0400
In-Reply-To: <20160407005349.30117.44157.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mittwoch, 6. April 2016 17:53:49 CEST Dan Williams wrote:
> Provide simulated SMART data to enable the ndctl implementation of SM=
ART
> data retrieval and parsing.
>=20
> The payload is defined here, "Section 4.1 SMART and Health Info
> (Function Index 1)":
>=20
>     http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

[...]

> @@ -20,6 +20,35 @@ struct nd_cmd_smart {
>  	__u8 data[128];
>  } __packed;
>=20
> +enum {
> +	ND_SMART_HEALTH_VALID	=3D 1 << 0,
> +	ND_SMART_TEMP_VALID 	=3D 1 << 1,
> +	ND_SMART_SPARES_VALID	=3D 1 << 2,
> +	ND_SMART_ALARM_VALID	=3D 1 << 3,
> +	ND_SMART_USED_VALID	=3D 1 << 4,
> +	ND_SMART_SHUTDOWN_VALID	=3D 1 << 5,
> +	ND_SMART_VENDOR_VALID	=3D 1 << 6,
> +	ND_SMART_TEMP_TRIP	=3D 1 << 0,
> +	ND_SMART_SPARE_TRIP	=3D 1 << 1,
> +	ND_SMART_NON_CRITICAL_HEALTH	=3D 1 << 0,
> +	ND_SMART_CRITICAL_HEALTH	=3D 1 << 1,
> +	ND_SMART_FATAL_HEALTH		=3D 1 << 2,
> +};

Why not use BIT() instead of that 1 << x stuff and #define instead of t=
he=20
abstract enum?

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
