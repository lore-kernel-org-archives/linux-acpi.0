From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] platform/x86: Add Intel ISP dummy driver
Date: Sun, 14 Oct 2018 17:42:21 +0200
Message-ID: <ce4d574f-51da-fd41-81ee-b1cb2792ff31@redhat.com>
References: <20180829135744.16205-1-hdegoede@redhat.com>
 <20180829182011.GG11447@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829182011.GG11447@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,


On 29-08-18 20:20, Andy Shevchenko wrote:
> On Wed, Aug 29, 2018 at 03:57:44PM +0200, Hans de Goede wrote:
>> The Image Signal Processor found on Cherry Trail devices is brought up in
>> D0 state on devices which have camera sensors attached to it. The ISP will
>> not enter D3 state again without some massaging of its registers beforehand
>> and the ISP not being in D3 state blocks the SoC from entering S0ix modes.
>>
>> There was a driver for the ISP in drivers/staging but that got removed
>> again because it never worked. It does not seem likely that a real
>> driver for the ISP will be added to the mainline kernel anytime soon.
>>
>> This commit adds a dummy driver which contains the necessary magic from
>> the staging driver to powerdown the ISP, so that Cherry Trail devices where
>> the ISP is used will properly use S0ix modes when suspended.
>>
>> Together with other recent S0ix related fixes this allows S0ix modes to
>> be entered on e.g. a Chuwi Hi8 Pro and a HP x2 210.
>>
> 
> Thanks for the patch, my comments below.

Thank you for the review and sorry for being a bit slow with responding
I've been quite busy with other stuff.

>>   drivers/platform/x86/intel_isp_dummy.c | 119 +++++++++++++++++++++++++
> 
> First of all, I would like to see that this is about pm and pm only, so,
> perhaps
> 
> intel_isp_pm ?
> 
> OTOH, it would be nice to have less confusing of what ISP we are talking about,
> so,
> 
> intel_atomisp2_pm ?

Works for me, intel_atomisp2_pm it is for v2 of this patch.

>> +config INTEL_ISP_DUMMY
>> +	tristate "Intel ISP dummy driver"
> 
>> +	depends on PCI && IOSF_MBI && PM
> 
> If someone decides to port this to kernels where ATOMISP driver is still
> available, it might be a conflict here. I dunno if it's a good idea to put
> something like depends !ATOMISP here taking into consideration that it would be
> staled option.

I don't look adding deps / conflucts on options which are
not present upstream, so I'm going to keep this as for v2.

> 
>> +	while (1) {
> 
> A nit: I would rather put it like
> 
> do {
> ...
> } while (time_after(...));

That would need to be time_before then, since the time check is a timeout
and then I would need to re-check the time outside the loop to see if
a timeout happened. So I believe it would better to keep this as is.


>> +		/* Wait until ISPSSPM0 bit[25:24] shows 0x3 */
>> +		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, ISPSSPM0, &val);
>> +		val = (val & ISPSSPM0_ISPSSS_MASK) >> ISPSSPM0_ISPSSS_OFFSET;
>> +		if (val == ISPSSPM0_IUNIT_POWER_OFF)
>> +			break;
>> +
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_err(&dev->dev, "IUNIT power-off timeout.\n");
>> +			return -EBUSY;
>> +		}
>> +		usleep_range(1000, 2000);
>> +	}
> 

Regards,

Hans
