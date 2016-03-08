From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2-UPDATE 3/4] resource: Add device-managed insert/remove_resource()
Date: Mon, 7 Mar 2016 18:21:28 -0800
Message-ID: <CAPcyv4jA+Lvg6L5WKijg_=xHo-DX-tp14bBtbAoonzcv0a5JcA@mail.gmail.com>
References: <1457108082-4610-1-git-send-email-toshi.kani@hpe.com>
	<CAPcyv4g8+6LBW08JZ3Ym0mAuo1bcwjGTeHrzS0p=QoJb4Mqeag@mail.gmail.com>
	<1457391787.15454.399.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33990 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142AbcCHCVa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2016 21:21:30 -0500
Received: by mail-ob0-f176.google.com with SMTP id ts10so1641672obc.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Mar 2016 18:21:29 -0800 (PST)
In-Reply-To: <1457391787.15454.399.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>

On Mon, Mar 7, 2016 at 3:03 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
> On Mon, 2016-03-07 at 10:14 -0800, Dan Williams wrote:
>  :
>> > +/**
>> > + * devm_insert_resource() - insert an I/O or memory resource
>> > + * @dev: device for which to produce the resource
>> > + * @root: root of the resource tree
>> > + * @new: descriptor of the new resource
>> > + *
>> > + * This is a device-managed version of insert_resource(). There is
>> > usually
>> > + * no need to release resources requested by this function explicitly
>> > since
>> > + * that will be taken care of when the device is unbound from its bus
>> > driver.
>> > + * If for some reason the resource needs to be released explicitly,
>> > because
>> > + * of ordering issues for example, bus drivers must call
>> > devm_remove_resource()
>> > + * rather than the regular remove_resource().
>> > + *
>> > + * devm_insert_resource() is intended for producers of resources, such
>> > as
>> > + * FW modules and bus drivers.
>> > + *
>> > + * Returns 0 on success or a negative error code on failure.
>> > + */
>> > +int devm_insert_resource(struct device *dev, struct resource *root,
>> > +                         struct resource *new)
>> > +{
>> > +       struct resource **ptr;
>> > +       int ret;
>> > +
>> > +       ptr = devres_alloc(__devm_remove_resource, sizeof(*ptr),
>> > GFP_KERNEL);
>> > +       if (!ptr)
>> > +               return -ENOMEM;
>> > +
>> > +       *ptr = new;
>> > +
>> > +       ret = insert_resource(root, new);
>> > +       if (ret) {
>> > +               dev_err(dev, "unable to insert resource: %pR (%d)\n",
>> > new, ret);
>> > +               devres_free(ptr);
>> > +               return -EBUSY;
>> > +       }
>> > +
>> > +       devres_add(dev, ptr);
>> > +       return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(devm_insert_resource);
>>
>> The only hesitation I have with this is that the kernel has gotten by
>> a long time without allowing external modules to insert resources.  If
>> keeping it private all this time was purposeful then maybe we should
>> make this new NVDIMM-need to call insert_resource() private to the
>> nfit driver and built-in-only.
>
> Here is some background info on this:
>
> - External modules can already insert resources via platform_device_add(),
> which is used for inserting resources that may not be enumerated by
> standard FW interfaces.  There are over 200 callers already.
>
> - PCI mmcfg driver and ACPI HPET driver find their resources from ACPI, and
> call insert_resource() to insert them, which is similar to what this
> patchset tries to do with ACPI NFIT.  Both PCI and HPET drivers do not
> support unloading, however.
>   # cat /proc/iomem
>    :
>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
>     80000000-8fffffff : reserved
>    :
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
>
> - Existing FW modules and bus drivers using insert_resource() are built-
> into the kernel, and insert_resource() is not exported.  I think this is
> because these modules did not have to (or may not) support unloading.
>
> - Both the NFIT driver and NVDIMM bus drivers are new and support
> unloading.  This calls for an exported interface for insert_resource().
>
> - devm impl of insert/remove_resource() is added to assure that resources
> are properly released on unloading.  Exporting devm interfaces makes sense
> (to me).
>
> - However, devm_insert/remove_resource() should not be confused with
> devm_request/release_resource().  Hence, this patchset adds comments to
> clarify that they are used for producers of resources.  The same comments
> are added to insert/remove_resource() as well.
>

Thanks Toshi, this satisfies my concerns.  Ingo, any concern with me
taking this series through the nvdimm tree since it touches the nfit
driver?
