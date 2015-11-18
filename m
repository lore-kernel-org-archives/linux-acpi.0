From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [RFC PATCH] Fix _FIT vs. NFIT processing breakage
Date: Wed, 18 Nov 2015 16:28:48 -0500
Message-ID: <564CED90.5000501@hpe.com>
References: <20151118175359.GA2209@ljk840.redhat.com> <1447880848.30346.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4620.austin.hp.com ([15.73.212.81]:43284 "EHLO
	g2t4620.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033AbbKRV2w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2015 16:28:52 -0500
In-Reply-To: <1447880848.30346.9.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "elliott@hpe.com" <elliott@hpe.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On 11/18/2015 4:07 PM, Verma, Vishal L wrote:
> On Wed, 2015-11-18 at 12:54 -0500, Linda Knippers wrote:
>> Since commit 209851649dc4f7900a6bfe1de5e2640ab2c7d931, we no longer
>> see NVDIMM devices on our systems.  The NFIT/_FIT processing at
>> initialization gets a table from _FIT but doesn't like it.
>>
>> When support for _FIT was added, the code presumed that the data
>> returned by the _FIT method is identical to the NFIT table, which
>> starts with an acpi_table_header.  However, the _FIT is defined
>> to return a data in the format of a series of NFIT type structure
>> entries and as a method, has an acpi_object header rather tahn
>> an acpi_table_header.
>
> Hm, I couldn't find any reference to this in the spec - that NFIT wil=
l
> have the acpi_table_header but _FIT will have a different header - bu=
t
> I'm no ACPI expert - is this usual convention? Any pointers where I
> could look at?

I'm no ACPI expert either so maybe Toshi or someone else will help me
here but according to the FW developer, the convention is that there is
no ACPI table header because you already know what the table is.

Also, if you look at the NFIT definition (table 5-126) , the definition
explicitly includes the APCI table header but the _FIT definition does =
not.
It just says it's a series of NFIT Types structure entries.

-- ljk

>
>>
>> To address the differences, explicitly save the acpi_table_header
>> from the NFIT, since it is accessible through /sys, and change
>> the nfit pointer in the acpi_desc structure to point to the
>> table entries rather than the headers.
>>
>> This is an RFC patch for several reasons.
>> 1) I've only tested the boot path, not the code path gets
>> gets a _FIT later.
>> 2) There is some debug information that we probably don't
>> want to keep in there.
>> 3) I'm not even sure we should be checking _FIT at boot time
>
> I think there is good reason to. If the driver is reloaded after a
> hotplug event but prior to a full system reboot, if we don't check _F=
IT,
> we will get the stale NFIT.
>
>> 4) While this fixes my platform, it probably breaks the tests
>> that were used to test the original commit.
>>
>> If we need to have a long discussion about whether our firmware
>> is correct, then perhaps we can remove the _FIT code from
>> acpi_nfit_add()
>> while we sort it out.
>>
>> Reported-by: Jeff Moyer (jmoyer@redhat.com>
>> Signed-off-by: Linda Knippers <linda.knippers@hp.com>
>> ---
>>   drivers/acpi/nfit.c | 55 +++++++++++++++++++++++++++++++++++++++++=
---
>> ---------
>>   drivers/acpi/nfit.h |  3 ++-
>>   2 files changed, 45 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
>> index f7dab53..ad95113 100644
>> --- a/drivers/acpi/nfit.c
>> +++ b/drivers/acpi/nfit.c
>> @@ -655,7 +655,7 @@ static ssize_t revision_show(struct device *dev,
>>   	struct nvdimm_bus_descriptor *nd_desc =3D
>> to_nd_desc(nvdimm_bus);
>>   	struct acpi_nfit_desc *acpi_desc =3D to_acpi_desc(nd_desc);
>>
>> -	return sprintf(buf, "%d\n", acpi_desc->nfit-
>>> header.revision);
>> +	return sprintf(buf, "%d\n", acpi_desc->acpi_header.revision);
>>   }
>>   static DEVICE_ATTR_RO(revision);
>>
>> @@ -1652,7 +1652,6 @@ int acpi_nfit_init(struct acpi_nfit_desc
>> *acpi_desc, acpi_size sz)
>>
>>   	data =3D (u8 *) acpi_desc->nfit;
>>   	end =3D data + sz;
>> -	data +=3D sizeof(struct acpi_table_nfit);
>>   	while (!IS_ERR_OR_NULL(data))
>>   		data =3D add_table(acpi_desc, &prev, data, end);
>>
>> @@ -1748,13 +1747,34 @@ static int acpi_nfit_add(struct acpi_device
>> *adev)
>>   		return PTR_ERR(acpi_desc);
>>   	}
>>
>> -	acpi_desc->nfit =3D (struct acpi_table_nfit *) tbl;
>> +	/*
>> +	 * Save the acpi header for later and then skip it, make
>> +	 * nfit point to the first nfit table header.
>> +	 */
>> +	acpi_desc->acpi_header =3D *tbl;
>> +	acpi_desc->nfit =3D (void *) tbl + sizeof(struct
>> acpi_table_nfit);
>> +	sz -=3D sizeof(struct acpi_table_nfit);
>>
>>   	/* Evaluate _FIT and override with that if present */
>>   	status =3D acpi_evaluate_object(adev->handle, "_FIT", NULL,
>> &buf);
>>   	if (ACPI_SUCCESS(status) && buf.length > 0) {
>> -		acpi_desc->nfit =3D (struct acpi_table_nfit
>> *)buf.pointer;
>> -		sz =3D buf.length;
>> +		union acpi_object *obj;
>> +
>> +		dev_dbg(dev, "%s _FIT ptr %p, length: %d\n",
>> +			__func__, buf.pointer, (int)buf.length);
>> +		print_hex_dump_debug("_FIT: ", DUMP_PREFIX_OFFSET,
>> 16, 1,
>> +			buf.pointer, buf.length, true);
>> +
>> +		/*
>> +		 * Adjust for the acpi_object header of the _FIT
>> +		 */
>> +		obj =3D buf.pointer;
>> +		if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
>> +			acpi_desc->nfit =3D (struct acpi_nfit_header
>> *)obj->buffer.pointer;
>> +			sz =3D obj->buffer.length;
>> +		} else
>> +			dev_dbg(dev, "%s invalid type %d, ignoring
>> _FIT\n",
>> +				__func__, (int) obj->type);
>>   	}
>>
>>   	rc =3D acpi_nfit_init(acpi_desc, sz);
>> @@ -1777,8 +1796,9 @@ static void acpi_nfit_notify(struct acpi_devic=
e
>> *adev, u32 event)
>>   {
>>   	struct acpi_nfit_desc *acpi_desc =3D dev_get_drvdata(&adev-
>>> dev);
>>   	struct acpi_buffer buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> -	struct acpi_table_nfit *nfit_saved;
>> +	struct acpi_nfit_header *nfit_saved;
>>   	struct device *dev =3D &adev->dev;
>> +	union acpi_object *obj;
>>   	acpi_status status;
>>   	int ret;
>>
>> @@ -1807,13 +1827,24 @@ static void acpi_nfit_notify(struct
>> acpi_device *adev, u32 event)
>>   		goto out_unlock;
>>   	}
>>
>> +	dev_dbg(dev, "%s _FIT ptr %p, length: %d\n",
>> +		__func__, buf.pointer, (int)buf.length);
>> +	print_hex_dump_debug("_FIT: ", DUMP_PREFIX_OFFSET, 16, 1,
>> +		buf.pointer, buf.length, true);
>> +
>>   	nfit_saved =3D acpi_desc->nfit;
>> -	acpi_desc->nfit =3D (struct acpi_table_nfit *)buf.pointer;
>> -	ret =3D acpi_nfit_init(acpi_desc, buf.length);
>> -	if (!ret) {
>> -		/* Merge failed, restore old nfit, and exit */
>> -		acpi_desc->nfit =3D nfit_saved;
>> -		dev_err(dev, "failed to merge updated NFIT\n");
>> +	obj =3D buf.pointer;
>> +	if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
>> +		acpi_desc->nfit =3D (struct acpi_nfit_header *)obj-
>>> buffer.pointer;
>> +		ret =3D acpi_nfit_init(acpi_desc, obj->buffer.length);
>> +		if (!ret) {
>> +			/* Merge failed, restore old nfit, and exit
>> */
>> +			acpi_desc->nfit =3D nfit_saved;
>> +			dev_err(dev, "failed to merge updated
>> NFIT\n");
>> +		}
>> +	} else {
>> +		/* Bad _FIT, restore old nfit */
>> +		dev_err(dev, "Invalid _FIT\n");
>>   	}
>>   	kfree(buf.pointer);
>>
>> diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
>> index 2ea5c07..3d549a3 100644
>> --- a/drivers/acpi/nfit.h
>> +++ b/drivers/acpi/nfit.h
>> @@ -96,7 +96,8 @@ struct nfit_mem {
>>
>>   struct acpi_nfit_desc {
>>   	struct nvdimm_bus_descriptor nd_desc;
>> -	struct acpi_table_nfit *nfit;
>> +	struct acpi_table_header acpi_header;
>> +	struct acpi_nfit_header *nfit;
>>   	struct mutex spa_map_mutex;
>>   	struct mutex init_mutex;
>>   	struct list_head spa_maps;N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=
=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD{=EF=BF=BDi=EF=BF=BDb=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=
=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=
=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=
=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=
=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!tml=3D

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
