From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Mon, 9 Nov 2015 10:23:56 -0800
Message-ID: <CAPcyv4iK9qAzOJETWG21KTB3kDRxiVmmxQi8TVG3kHBH9QpBsg@mail.gmail.com>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
	<1445986707-15395-3-git-send-email-vishal.l.verma@intel.com>
	<CAPcyv4gytTTVgU6evY9d+EoxD0wRs4J1D_LS+ucJ5vOju0Kd2A@mail.gmail.com>
	<CAPcyv4gYG7aa0SvpfKNPGC-dNO+4gq6-uNrJ17fckJ4uX36=jQ@mail.gmail.com>
	<1447092724.32525.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37475 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbKISX5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 13:23:57 -0500
Received: by wmww144 with SMTP id w144so44152544wmw.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2015 10:23:56 -0800 (PST)
In-Reply-To: <1447092724.32525.1.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "elliott@hpe.com" <elliott@hpe.com>

On Mon, Nov 9, 2015 at 10:12 AM, Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
> On Sat, 2015-11-07 at 13:20 -0800, Dan Williams wrote:
>> On Sat, Nov 7, 2015 at 10:57 AM, Dan Williams <dan.j.williams@intel.co
>> m> wrote:
>> > Rafael, awaiting your ack...
>> >
>> > Vishal, one thing I'll fix up on applying...
>> >
>> > On Tue, Oct 27, 2015 at 3:58 PM, Vishal Verma <vishal.l.verma@intel.
>> > com> wrote:
>> > > Add a .notify callback to the acpi_nfit_driver that gets called on
>> > > a
>> > > hotplug event. From this, evaluate the _FIT ACPI method which
>> > > returns
>> > > the updated NFIT with handles for the hot-plugged NVDIMM.
>> > >
>> > > Iterate over the new NFIT, and add any new tables found, and
>> > > register/enable the corresponding regions.
>> > >
>> > > In the nfit test framework, after normal initialization, update
>> > > the NFIT
>> > > with a new hot-plugged NVDIMM, and directly call into the driver
>> > > to
>> > > update its view of the available regions.
>> > >
>> > > Cc: Dan Williams <dan.j.williams@intel.com>
>> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > > Cc: Toshi Kani <toshi.kani@hpe.com>
>> > > Cc: Elliott, Robert <elliott@hpe.com>
>> > > Cc: Jeff Moyer <jmoyer@redhat.com>
>> > > Cc: <linux-acpi@vger.kernel.org>
>> > > Cc: <linux-nvdimm@lists.01.org>
>> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>> > [..]
>> >
>> > > +static int acpi_nfit_add(struct acpi_device *adev)
>> > > +{
>> > > +       struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>> > > +       struct acpi_nfit_desc *acpi_desc;
>> > > +       struct device *dev = &adev->dev;
>> > > +       struct acpi_table_header *tbl;
>> > > +       acpi_status status = AE_OK;
>> > > +       acpi_size sz;
>> > > +       int rc = 0;
>> > > +
>> > > +       device_lock(dev);
>> >
>> > The device is already locked by the time we reach this point.  The
>> > unit tests don't trip this path which might be why this wasn't seen
>> > earlier.
>>
>> The lockup call trace if you're interested:
>>
>> dracut:/# [  376.030455] INFO: task systemd-udevd:278 blocked for more
>> than 120 seconds.
>> [  376.032561]       Tainted: G           O    4.3.0-rc6+ #1747
>> [  376.034376] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  376.036704] systemd-udevd   D 0000000000000000     0   278    262
>> 0x00000004
>> [  376.039758]  ffff880352a0ba60 0000000000000092 ffff880352a0ba88
>> ffff880361e57b98
>> [  376.043779]  ffff88035f150000 ffff880352ea5dc0 ffff880352a0c000
>> 0000000000000246
>> [  376.047800]  ffff880359a43148 ffff880352ea5dc0 00000000ffffffff
>> ffff880352a0ba78
>> [  376.051821] Call Trace:
>> [  376.052882]  [<ffffffff818e8b43>] schedule+0x33/0x80
>> [  376.054527]  [<ffffffff818e8eae>]
>> schedule_preempt_disabled+0xe/0x10
>> [  376.056493]  [<ffffffff818eaf2f>] mutex_lock_nested+0x14f/0x3a0
>> [  376.058361]  [<ffffffffa003140e>] ? acpi_nfit_add+0x4e/0x150 [nfit]
>> [  376.060310]  [<ffffffffa003140e>] acpi_nfit_add+0x4e/0x150 [nfit]
>> [  376.062283]  [<ffffffff81584310>] ?
>> devices_kset_move_last+0x60/0x90
>> [  376.064250]  [<ffffffff814d61c0>] acpi_device_probe+0x4f/0xf5
>> [  376.066076]  [<ffffffff81588244>] driver_probe_device+0x224/0x480
>> [  376.067983]  [<ffffffff81588528>] __driver_attach+0x88/0x90
>> [  376.069769]  [<ffffffff815884a0>] ? driver_probe_device+0x480/0x480
>> [  376.071716]  [<ffffffff81585d83>] bus_for_each_dev+0x73/0xc0
>> [  376.073522]  [<ffffffff81587b9e>] driver_attach+0x1e/0x20
>> [  376.075267]  [<ffffffff815876de>] bus_add_driver+0x1ee/0x280
>> [  376.077072]  [<ffffffffa0038000>] ? 0xffffffffa0038000
>> [  376.078757]  [<ffffffff81588f10>] driver_register+0x60/0xe0
>> [  376.080543]  [<ffffffff814d6095>]
>> acpi_bus_register_driver+0x40/0x42
>> [  376.082511]  [<ffffffffa00380ce>] nfit_init+0xce/0x1000 [nfit]
>>
>>
>
> Thanks for the fixup, Dan. The change looks good - I think I got too
> reliant on lockdep not complaining - should've taken a closer look.

Unfortunately device_lock() has this by default in device_initialize():

void device_initialize(struct device *dev)
{
...
       lockdep_set_novalidate_class(&dev->mutex);
...
}

...so it hides these issues by default.
