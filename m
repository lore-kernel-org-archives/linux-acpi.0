From: <Alex_Gagniuc@Dellteam.com>
Subject: Re: [RFC] PCI / ACPI: Implementing Type 3 _HPX records
Date: Thu, 17 Jan 2019 19:02:47 +0000
Message-ID: <edf8493f2c184bd6b28d269fe5aa337a@ausx13mps321.AMER.DELL.COM>
References: <20190110231136.31163-1-mr.nuke.me@gmail.com>
 <20190114200120.GA33971@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: helgaas@kernel.org, mr.nuke.me@gmail.com
Cc: Austin.Bolen@dell.com, keith.busch@intel.com, Shyam.Iyer@dell.com, lukas@wunner.de, okaya@kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn=0A=
=0A=
On 1/14/19 2:01 PM, Bjorn Helgaas wrote:=0A=
> On Thu, Jan 10, 2019 at 05:11:27PM -0600, Alexandru Gagniuc wrote:=0A=
>> _HPX Type 3 is intended to be more generic and allow configuration of=0A=
>> settings not possible with Type 2 tables. For example, FW could ensure=
=0A=
>> that the completion timeout value is set accordingly throughout the PCI=
=0A=
>> tree; some switches require very special handling.=0A=
>>=0A=
>> Type 3 can come in an arbitrary number of ACPI packages. With the older=
=0A=
>> types we only ever had one descriptor. We could get lazy and store it=0A=
>> on the stack. The current flow is to parse the HPX table=0A=
>> --pci_get_hp_params()-- and then program the PCIe device registers.=0A=
>>=0A=
>> In the current flow, we'll need to malloc(). Here's what I tried:=0A=
>>   1) devm_kmalloc() on the pci_dev=0A=
>>    This ended up giving me NULL dereference at boot time.=0A=
> =0A=
> Yeah, I don't think devm_*() is going to work because that's part of the=
=0A=
> driver binding model; this is in the PCI core and this use is not related=
=0A=
> to the lifetime of a driver's binding to a device.=0A=
> =0A=
>>   2) Add a cleanup function to be called after writing the PCIe register=
s=0A=
>>=0A=
>> This RFC implements method 2. The HPX3 stuff is still NDA'd, but the=0A=
>> housekeeping parts are in here. Is this a good way to do things? I'm not=
=0A=
>> too sure about the need to call cleanup() on a stack variable. But if=0A=
>> not that, then what else?=0A=
> =0A=
> pci_get_hp_params() is currently exported, but only used inside=0A=
> drivers/pci, so I think it could be unexported.=0A=
=0A=
It can.=0A=
=0A=
> I don't remember if there's a reason why things are split between=0A=
> pci_get_hp_params(), which runs _HPX or _HPP, and the program_hpp_type*()=
=0A=
> functions.  If we could get rid of that split, we could get rid of struct=
=0A=
> hotplug_params and do the configuration directly in the pci_get_hp_params=
()=0A=
> path.  I think that would simplify the memory management.=0A=
=0A=
Thanks for the in-depth analysis. I'm working on a proof-of-concept =0A=
patch to do what you suggested. On downside though, is that we may have =0A=
to parse some things twice.=0A=
=0A=
Another thing, I've been thinking is, why not store the hotplug =0A=
parameters from ACPI with the pci_bus struct. That way, you only need to =
=0A=
parse ACPI once per bus, instead of each time a device is probed. There =0A=
would be some memory overhead, but the hotplug structures are =0A=
(thankfully) still relatively small. I could try a proof of concept for =0A=
this idea as well... let me know.=0A=
=0A=
Alex=0A=
