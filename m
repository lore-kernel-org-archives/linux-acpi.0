From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 2/2] ACPI: amba bus probing support
Date: Mon, 11 Jan 2016 18:26:00 +0200
Message-ID: <CAHp75VfND6Gq5XW91mbgN+ZQnxh_SCm9LKNz_zNFvaVd1dgvWg@mail.gmail.com>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
	<1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
	<CAHp75Vew8HMMrc2vdKbSVuB2reOCrwZZg3-a4nBUyfiQ=c0Y4A@mail.gmail.com>
	<20160111152732.GU19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34597 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933793AbcAKQ0E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2016 11:26:04 -0500
In-Reply-To: <20160111152732.GU19062@n2100.arm.linux.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Mon, Jan 11, 2016 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 11, 2016 at 05:13:20PM +0200, Andy Shevchenko wrote:
>> On Mon, Jan 11, 2016 at 3:26 PM, Aleksey Makarov
>> <aleksey.makarov@linaro.org> wrote:
>> > From: Graeme Gregory <graeme.gregory@linaro.org>

>> > +static int amba_handler_attach(struct acpi_device *adev,
>> > +                               const struct acpi_device_id *id)
>> > +{
>> > +       struct amba_device *dev;
>> > +       struct resource_entry *rentry;
>> > +       struct list_head resource_list;
>> > +       bool address_found = false;
>> > +       int irq_no = 0;
>> > +       int ret;
>> > +
>> > +       /* If the ACPI node already has a physical device attached, skip it. */
>> > +       if (adev->physical_node_count)
>> > +               return 0;
>> > +
>> > +       dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);
>> > +       if (!dev) {
>> > +               dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
>> > +                       __func__);
>> > +               return -ENOMEM;
>> > +       }
>> > +
>> > +       INIT_LIST_HEAD(&resource_list);
>> > +       ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
>> > +       if (ret < 0)
>> > +               goto err_free;
>> > +
>> > +       list_for_each_entry(rentry, &resource_list, node) {
>> > +               switch (resource_type(rentry->res)) {
>> > +               case IORESOURCE_MEM:
>> > +                       if (!address_found) {
>> > +                               dev->res = *rentry->res;
>>
>> dev->res is 0 before this one, right? Could you use this fact instead
>> of address_found flag?
>
> amba_device_alloc() zero-initialises everything.  However, dev->res is
> a struct resource, and I'd prefer _this_ method that the OT is using
> to testing some random part of struct resource.

So, you mean resource->start = 0 is not enough reliable?

>> > +               default:
>> > +                       dev_warn(&adev->dev, "Invalid resource\n");
>>
>> Why? Isn't possible to have other resources for the devices?
>
> AMBA primecell devices have one memory region, and a number of
> interrupts.  Other resource types don't make sense.

But isn't warning on the other side too noisy?

>> > +       ret = amba_device_add(dev, &iomem_resource);
>> > +       if (ret) {
>>
>> ret < 0?
>>
>> What to do if ret > 0? It will be considered as not error. Please,
>> check what function returns and adjust this.
>
> Non-zero is treated as an error by amba_device_add().

> Doing otherwise
> here puts it at odds to the outcome of that function.  This code is fine.

Yes, and in this case ret > 0 should be converted to an appropriate
error code, otherwise ACPI core will consider this as a normal
execution, right?

-- 
With Best Regards,
Andy Shevchenko
