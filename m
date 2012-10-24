From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] Improve container_notify_cb() to support container hot-remove.
Date: Wed, 24 Oct 2012 12:02:04 -0600
Message-ID: <CAErSpo7KRTY+M1gSO7s_PGRPkXABK6x9CQsaMXbZ__C11mmTWQ@mail.gmail.com>
References: <1351058750-4275-1-git-send-email-tangchen@cn.fujitsu.com>
 <1351058750-4275-3-git-send-email-tangchen@cn.fujitsu.com> <1351098875.19172.21.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1351098875.19172.21.camel@misato.fc.hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, yinghai@kernel.org, lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, mihailm@parallels.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 24, 2012 at 11:14 AM, Toshi Kani <toshi.kani@hp.com> wrote:
> On Wed, 2012-10-24 at 14:05 +0800, Tang Chen wrote:

>> +             result = container_device_remove(device);
>> +             if (result) {
>> +                     printk(KERN_WARNING "Failed to remove container\n");
>
> Please use pr_warn().

I think you should use dev_warn() and similar when possible.  In a
year or two, the text "Failed to remove container" all by itself in a
dmesg log is not going to mean anything to anybody except you, and it
doesn't give any clue where to start looking for issues.

I also have a larger question.  I'm not sure if
drivers/acpi/container.c does anything important in the first place.
The code in it looks an awful lot like the code in
drivers/acpi/processor_driver.c, drivers/acpi/acpi_memhotplug.c, and
drivers/pci/hotplug/acpiphp_glue.c.

To me, it looks like container.c (as well as the other places I
mentioned) is an attempt to compensate for the lack of hotplug support
in the ACPI core.  If the ACPI core had generic hotplug support, e.g.,
if it handled BUS_CHECK, DEVICE_CHECK, and EJECT_REQUEST notifications
and turned those into the appropriate calls to driver .add()/.start()
and .remove() methods, would we need container.c at all?

Bjorn
