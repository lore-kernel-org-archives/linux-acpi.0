From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ACPICA: Export mutex functions
Date: Tue, 18 Apr 2017 06:50:26 -0700
Message-ID: <03d661cb-a561-cfce-2c0e-f81ff73e6653@roeck-us.net>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
 <20170417155646.GA8730@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
 <20170417194527.GA16734@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E593580@ORSMSX110.amr.corp.intel.com>
 <20170417210353.GA19771@roeck-us.net>
 <CAJZ5v0jyxRH_B7Yj7HxRdxhofZjgRf175WqmyjtsupWPQYx6tQ@mail.gmail.com>
 <20170417223257.GA22495@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE93D3A@SHSMSX101.ccr.corp.intel.com>
 <0a9550c7-f36b-feb3-f83c-7b868cbf2e3a@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE93F83@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57483 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbdDRNua (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2017 09:50:30 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE93F83@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

On 04/18/2017 12:14 AM, Zheng, Lv wrote:
> Hi,
>
>> From: Zheng, Lv
>> Subject: RE: [PATCH] ACPICA: Export mutex functions
>>
>> Hi,
>>
>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>> Subject: Re: [PATCH] ACPICA: Export mutex functions
>>>
>>> On 04/17/2017 04:53 PM, Zheng, Lv wrote:
>>>> Hi,
>>>>
>>>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>>>> Subject: Re: [PATCH] ACPICA: Export mutex functions
>>>>>
>>>>> On Mon, Apr 17, 2017 at 11:29:38PM +0200, Rafael J. Wysocki wrote:
>>>>>> On Mon, Apr 17, 2017 at 11:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>> On Mon, Apr 17, 2017 at 08:40:38PM +0000, Moore, Robert wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>>>>>>>> Subject: Re: [PATCH] ACPICA: Export mutex functions
>>>>>>>>>
>>>>>>>>> On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
>>>>>>>>>>
>>>>>>>>>>> From: Moore, Robert
>>>>>>>>>>> Subject: RE: [PATCH] ACPICA: Export mutex functions
>>>>>>>>>>>
>>>>>>>>>>> There is a model for the drivers to directly acquire an AML mutex
>>>>>>>>>>> object. That is why the acquire/release public interfaces were added
>>>>>>>>>>> to ACPICA.
>>>>>>>>>>>
>>>>>>>>>>> I forget all of the details, but the model was developed with MS and
>>>>>>>>>>> others during the ACPI 6.0 timeframe.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>> [Moore, Robert]
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Here is the case where the OS may need to directly acquire an AML
>>>>>>>>> mutex:
>>>>>>>>>>
>>>>>>>>>> From the ACPI spec:
>>>>>>>>>>
>>>>>>>>>> 19.6.2 Acquire (Acquire a Mutex)
>>>>>>>>>>
>>>>>>>>>> Note: For Mutex objects referenced by a _DLM object, the host OS may
>>>>>>>>> also contend for ownership.
>>>>>>>>>>
>>>>>>>>> From the context in the dsdt, and from description of expected use cases
>>>>>>>>> for _DLM objects I can find, this is what the mutex is used for (to
>>>>>>>>> serialize access to a resource on a low pin count serial interconnect,
>>>>>>>>> aka LPC).
>>>>>>>>>
>>>>>>>>> What does that mean in practice ? That I am not supposed to use it
>>>>>>>>> because it doesn't follow standard ACPI mutex declaration rules ?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Guenter
>>>>>>>>>
>>>>>>>>>>
>>>>>>>> [Moore, Robert]
>>>>>>>>
>>>>>>>> I'm not an expert on the _DLM method, but I would point you to the description section in the
>>>>> ACPI spec, 5.7.5 _DLM (DeviceLock Mutex).
>>>>>>>>
>>>>>>>
>>>>>>> I did. However, not being an ACPI expert, that doesn't tell me anything.
>>>>>>
>>>>>> Basically, if the kernel and AML need to access a device concurrently,
>>>>>> there should be a _DLM object under that device in the ACPI tables.
>>>>>> In that case it is expected to return a list of (AML) mutexes that can
>>>>>> be acquired by the kernel in order to synchronize device access with
>>>>>> respect to AML (and for each mutex it may also return a description of
>>>>>> the specific resources to be protected by it).
>>>>>>
>>>>>> Bottom line: without _DLM, the kernel cannot synchronize things with
>>>>>> respect to AML properly, because it has no information how to do that
>>>>>> then.
>>>>>
>>>>> That is all quite interesting. I do see the mutex in question used on various
>>>>> motherboards from various vendors (I checked boards from Gigabyte, MSI, and
>>>>> Intel). Interestingly, the naming seems to be consistent - it is always named
>>>>> "MUT0". For the most part, it seems to be available on more recent
>>>>> motherboards; older motherboards tend to use the resource without locking.
>>>>> However, I don't see any mention of "_DLM" in any of the DSDTs.
>>>>>
>>>>
>>>> OK, then you might be having problems in your opregion driver.
>>>>
>>>>> At the same time, access to ports 0x2e/0x2f is widely used in the kernel.
>>>>> As mentioned before, it is used in watchdog, hardware monitoring, and gpio
>>>>> drivers, but also in parallel port and infrared driver code. Effectively
>>>>> that means that all this code is inherently unsafe on systems with ACPI
>>>>> support.
>>>>>
>>>>> I had thought about implementing a set of utility functions to make the kernel
>>>>> code safer to use if the mutex is found to exist.
>>>>
>>>> As what you've mentioned, there are already lots of parallel accesses in kernel without enabling
>>> ACPI.
>>>> Are these accesses mutually exclusive (safe)?
>>>
>>> In-kernel, yes (using request_muxed_region). Against ACPI, no.
>>>
>>>> If so, why do you need to invent a new synchronization mechanism?
>>>>
>>>
>>> Because I am seeing a problem with the current code (more specifically,
>>> with the it87 hwmon driver) on new Gigabyte boards.
>>
>> I checked superio_enter()/superio_exit(), IMO, the mutual exclusion
>> might be handled using 1 of the following 2 solutions:
>>
>> 1. _DLM, then you can find superio related mutex from _DLM and
>>    acquire/release it in superio_enter()/superio_exit().
>>    You really need a set of new APIs to acquire the _DLM related mutex.
>>    If you don't have _DLM in your DSDT, directly exporting ACPICA mutex
>>    functions seem to be a reasonable solution.
>> 2. Normally, AML developer should abstract superio accesses into customized
>>    opregion, then you can prepare a superio opregion driver.
>>
>>>
>>>>> Right now I wonder, though,
>>>>> if such code would have a chance to be accepted. Any thoughts on that ?
>>>>
>>>> Is that possible to make it safe in the opregion driver?
>>>>
>>>
>>> Sorry, I don't think I understand what you mean with "opregion driver".
>>> Do you refer to the drivers accessing the memory region in question,
>>> or in other words replicating the necessary code in every driver accessing
>>> that region ? Sure, I can do that, if that is the preferred solution;
>>> I have no problem with that. However, that would require exporting
>>> the ACPI mutex functions. My understanding is that you are opposed to
>>> exporting those, so I assume that is not what you refer to.
>>> Can you clarify ?
>>
>> I mean solution 2.
>
> Maybe I should provide more detailed examples for this solution.
>
> For example:
> OperationRegion (SIOT, SuperIOAddressSpace, Zero, 100)
> Field (SIOT, ByteAcc, Lock, Preserve)
> {
>     FNC1, 8,
>     FNC2, 8,
>     ...
> }
>
> Acquire (MUX0)
> Store (0, FNC1)
> Release (MUX0)
>
> Then you can call (let me use casual pseudo code)
> acpi_install_operation_region(SuperIOAddressSpace, superio_opregion_handler) from OS side.
> In its callback superio_opregion_handler(), you can:
>
> superio_enter();
> If (address == 0) {
>    /* mean FNC1 */
>    Perform the locked superior accesses
> } else if (address == 1) {
>    /* mean FNC2 */
>    Perform the locked superior accesses
> }
> superio_exit();
>
> Are there similar approach in your DSDT?
>

Some snippets from the DSDT:

	Device (SIO1)
            {
         	Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
         	Name (_UID, Zero)  // _UID: Unique ID
		...
		Mutex (MUT0, 0x00)
		Method (ENFG, 1, NotSerialized)
                     {
                         Acquire (MUT0, 0x0FFF)
                         INDX = 0x87
                         INDX = One
                         INDX = 0x55
                         If ((SP1O == 0x2E))
                         {
                             INDX = 0x55
                         }
                         Else
                         {
                             INDX = 0xAA
                         }

                         LDN = Arg0
                     }

                     Method (EXFG, 0, NotSerialized)
                     {
                         INDX = 0x02
                         DATA = 0x02
                         Release (MUT0)
                     }

		    OperationRegion (IOID, SystemIO, SP1O, 0x02)	/* SP1O is 0x2e */
                     Field (IOID, ByteAcc, NoLock, Preserve)
                     {
                         INDX,   8,
                         DATA,   8
                     }
		    ...

Example for use:
		Method (DCNT, 2, NotSerialized)
                     {
                         ENFG (CGLD (Arg0))
                         If (((DMCH < 0x04) && ((Local1 = (DMCH & 0x03)) != Zero)))
                         {
                             RDMA (Arg0, Arg1, Local1++)
                         }

                         ACTR = Arg1
                         Local1 = (IOAH << 0x08)
                         Local1 |= IOAL
                         RRIO (Arg0, Arg1, Local1, 0x08)
                         EXFG ()
                     }

Can there be more than one address space handler for a given region ?
Each driver accessing the resource would need that handler.

Thanks,
Guenter

> Thanks and best regards
> Lv
>
>> From it87_find() I really couldn't see a possibility to convert superio
>> accesses into opregions. Could you paste some example superio access AML
>> code from your DSDT here.
>>
>> Thanks and best regards
>> Lv
>

