From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/8] ACPI, APEI, Resolve false conflict between ACPI NVS
 and APEI
Date: Mon, 19 Sep 2011 20:09:14 -0600
Message-ID: <CAErSpo4_syhxOi8jGo5oyrWBimsO7PdsXEky1vwPY_130OuPMA@mail.gmail.com>
References: <1316482741-21799-1-git-send-email-ying.huang@intel.com> <1316482741-21799-5-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:5836 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1ITCJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2011 22:09:37 -0400
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id p8K29Zak006841
	for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2011 19:09:36 -0700
Received: from gxk26 (gxk26.prod.google.com [10.202.11.26])
	by wpaz17.hot.corp.google.com with ESMTP id p8K29YUh002961
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2011 19:09:34 -0700
Received: by gxk26 with SMTP id 26so155883gxk.32
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2011 19:09:34 -0700 (PDT)
In-Reply-To: <1316482741-21799-5-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

On Mon, Sep 19, 2011 at 7:38 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> Some firmware will access memory in ACPI NVS region via APEI. =A0That
> is, instructions in APEI ERST/EINJ table will read/write ACPI NVS
> region. =A0The original resource conflict checking in APEI code will
> check memory/ioport accessed by APEI via general resource management
> mech. =A0But ACPI NVS region is marked as busy already, so that the
> false resource conflict will prevent APEI ERST/EINJ to work.
>
> To fix this, this patch excludes ACPI NVS regions when APEI component=
s
> request resources. =A0So that they will not conflict with ACPI NVS
> regions.

I think this is much, much too complicated.

Yinghai's three-line e820.c patch to leave ACPI NVS regions in the
iomem_resource tree, but as not busy, is far better.

Bjorn

> Reported-and-tested-by: Pavel Ivanov <paivanof@gmail.com>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> ---
> =A0drivers/acpi/apei/apei-base.c | =A0 29 +++++++++++++++++++++++++++=
+-
> =A01 file changed, 28 insertions(+), 1 deletion(-)
>
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -438,8 +438,19 @@ int apei_resources_sub(struct apei_resou
> =A0}
> =A0EXPORT_SYMBOL_GPL(apei_resources_sub);
>
> +static int apei_get_nvs_callback(__u64 start, __u64 size, void *data=
)
> +{
> + =A0 =A0 =A0 struct apei_resources *resources =3D data;
> + =A0 =A0 =A0 return apei_res_add(&resources->iomem, start, size);
> +}
> +
> +static int apei_get_nvs_resources(struct apei_resources *resources)
> +{
> + =A0 =A0 =A0 return acpi_nvs_for_each_region(apei_get_nvs_callback, =
resources);
> +}
> +
> =A0/*
> - * IO memory/port rersource management mechanism is used to check
> + * IO memory/port resource management mechanism is used to check
> =A0* whether memory/port area used by GARs conflicts with normal memo=
ry
> =A0* or IO memory/port of devices.
> =A0*/
> @@ -448,12 +459,26 @@ int apei_resources_request(struct apei_r
> =A0{
> =A0 =A0 =A0 =A0struct apei_res *res, *res_bak =3D NULL;
> =A0 =A0 =A0 =A0struct resource *r;
> + =A0 =A0 =A0 struct apei_resources nvs_resources;
> =A0 =A0 =A0 =A0int rc;
>
> =A0 =A0 =A0 =A0rc =3D apei_resources_sub(resources, &apei_resources_a=
ll);
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return rc;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Some firmware uses ACPI NVS region, that has been =
marked as
> + =A0 =A0 =A0 =A0* busy, so exclude it from APEI resources to avoid f=
alse
> + =A0 =A0 =A0 =A0* conflict.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 apei_resources_init(&nvs_resources);
> + =A0 =A0 =A0 rc =3D apei_get_nvs_resources(&nvs_resources);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto res_fini;
> + =A0 =A0 =A0 rc =3D apei_resources_sub(resources, &nvs_resources);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto res_fini;
> +
> =A0 =A0 =A0 =A0rc =3D -EINVAL;
> =A0 =A0 =A0 =A0list_for_each_entry(res, &resources->iomem, list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D request_mem_region(res->start, r=
es->end - res->start,
> @@ -500,6 +525,8 @@ err_unmap_iomem:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0release_mem_region(res->start, res->en=
d - res->start);
> =A0 =A0 =A0 =A0}
> +res_fini:
> + =A0 =A0 =A0 apei_resources_fini(&nvs_resources);
> =A0 =A0 =A0 =A0return rc;
> =A0}
> =A0EXPORT_SYMBOL_GPL(apei_resources_request);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
