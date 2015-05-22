From: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
Subject: RE: [PATCH v3 14/21] libnd: blk labels and namespace instantiation
Date: Fri, 22 May 2015 18:37:31 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B40295A91FBF3@G9W0745.americas.hpqcorp.net>
References: <20150520205536.32249.89779.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150520205727.32249.79684.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:50915 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbbEVSiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2015 14:38:52 -0400
In-Reply-To: <20150520205727.32249.79684.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "neilb@suse.de" <neilb@suse.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>


> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Beha=
lf Of
> Dan Williams
> Sent: Wednesday, May 20, 2015 3:57 PM
> To: axboe@kernel.dk
> Cc: linux-nvdimm@lists.01.org; neilb@suse.de; gregkh@linuxfoundation.=
org;
> linux-kernel@vger.kernel.org; hch@lst.de; linux-acpi@vger.kernel.org;
> mingo@kernel.org
> Subject: [PATCH v3 14/21] libnd: blk labels and namespace instantiati=
on
>=20
=2E..
> @@ -1029,6 +1244,173 @@ static struct device **create_namespace_pmem(=
struct
> nd_region *nd_region)
>  	return NULL;
>  }
>=20
> +struct resource *nsblk_add_resource(struct nd_region *nd_region,
> +		struct nd_dimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
> +		resource_size_t start)
> +{
> +	struct nd_label_id label_id;
> +	struct resource *res;
> +
> +	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
> +	nsblk->res =3D krealloc(nsblk->res,
> +			sizeof(void *) * (nsblk->num_resources + 1),
> +			GFP_KERNEL);
> +	if (!nsblk->res)
> +		return NULL;

scripts/checkpatch.pl doesn't like that:
WARNING: Reusing the krealloc arg is almost always a bug
#1411: FILE: drivers/block/nd/namespace_devs.c:1411:
+       nsblk->res =3D krealloc(nsblk->res,

The reasoning (https://lkml.org/lkml/2013/3/14/558) is:

"If krealloc() returns NULL, it *doesn't* free the original. So any=20
code of the form 'foo =3D krealloc(foo, =85);' is almost certainly a bu=
g."


---
Robert Elliott, HP Server Storage
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
