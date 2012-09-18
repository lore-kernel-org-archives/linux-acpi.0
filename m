From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH part2 6/6] PCI: Claim hw/fw allocated resources in hot add path.
Date: Mon, 17 Sep 2012 21:44:08 -0700
Message-ID: <CAE9FiQUB6wshovj=TBmCEL140nZB5K40BfKPYGNmmpZx536F+Q@mail.gmail.com>
References: <1346622653-30741-1-git-send-email-yinghai@kernel.org>
	<1346622653-30741-7-git-send-email-yinghai@kernel.org>
	<CAErSpo4wmnnFKZeY4XyZdmoOZeQz8sj-5VoAhGhCSqWTBi0GRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4wmnnFKZeY4XyZdmoOZeQz8sj-5VoAhGhCSqWTBi0GRw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 17, 2012 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sun, Sep 2, 2012 at 3:50 PM, Yinghai Lu <yinghai@kernel.org> wrote:

>> -static void __init pcibios_allocate_bridge_resources(struct pci_dev *dev)
>> +static void pcibios_allocate_bridge_resources(struct pci_dev *dev)
>
> This patch has a little too much going on at the same time.  Can you
> split the __init removal into its own patch so we can focus on what's
> left by itself?

ok.

>
>>  {
>>         int idx;
>>         struct resource *r;
>>
>>         for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
>>                 r = &dev->resource[idx];
>> +               if (r->parent)  /* Already allocated */
>> +                       continue;
>
> This is also a potentially interesting change that maybe should be in
> its own patch.

oh, we don't need that extra checking anymore. because support
removing non-root bus is dropped.

>> +void pcibios_resource_survey_bus(struct pci_bus *bus)
>> +{
>> +       dev_printk(KERN_DEBUG, &bus->dev, "Allocating resources\n");
>> +
>> +       pcibios_allocate_bus_resources(bus);
>> +
>> +       pcibios_allocate_resources(bus, 0);
>> +       pcibios_allocate_resources(bus, 1);
>> +
>> +       pcibios_allocate_rom_resources(bus);
>> +}
>> +
>>  void __init pcibios_resource_survey(void)
>
> I wish pcibios_resource_survey() could look like this:
>
>     void __init pcibios_resource_survey(void)
>     {
>         list_for_each_entry(bus, &pci_root_buses, node)
>             pcibios_resource_survey_bus(bus)
>
>         e820_reserve_resources_late();
>         ...
>
> but maybe there's a reason why pcibios_allocate_rom_resources() really
> has to be in the pcibios_assign_resources() fs_initcall rather than in
> pcibios_resource_survey().

that should be another patch later.

Thanks

Yinghai
