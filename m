From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [PATCH v2] Documentation: acpi: Add an example for PRP0001
Date: Mon, 25 Mar 2019 15:58:13 +0000
Message-ID: <3ae33d42-1175-bdbe-036b-1df5edc6a802@codethink.co.uk>
References: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
 <20190325153032.GG9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325153032.GG9224@smile.fi.intel.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On 25/03/2019 15:30, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 03:12:10PM +0000, Thomas Preston wrote:
>> Add an example for the magic PRP0001 device ID which allows matching
>> ACPI devices against drivers using OF Device Tree compatible property.
> 
>> It wasn't clear to me that PRP0001 could be used in _CID.
> 
> Yes, but it's not necessary to have it if we have defined a _HID.
> 
> In that case PRP0001 is a temporary stub until corresponding driver
> incorporates an official _HID.
> 
> On the contrary, when there is no official _HID available, PRP0001 can be used
> instead directly as a _HID and no _CID is needed.
> 

In that case, how do we uniquely identify devices in sysfs? We have a
case where sound/soc/soc-core.c generates an i2c codec name i2c-TDA7802:00.
It is useful to identify that device by part name, rather than some indexed
generic PRP device i2c-PRP0001:04. I can achieve this with:

	_HID("TDA7802")
	_CID("PRP0001")
	...
	compatible = "st,tda7802" // driver I want to load using OF DT

> I would really recommend to look at the examples in meta-acpi repository. There
> are cases like described above.
> 
> This one is good enough, though see below.
> 

I will drop the superfluous _CID - I think the example is still useful
to have. Even if we don't illustrate my special case for _HID/_CID.

>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>> ---
>>   Documentation/acpi/enumeration.txt | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
>> index 7bcf9c3d9fbe..8375fc506b47 100644
>> --- a/Documentation/acpi/enumeration.txt
>> +++ b/Documentation/acpi/enumeration.txt
>> @@ -410,6 +410,37 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
>>   return package will be checked first.  Also in that case the bus type the device
>>   will be enumerated to depends on the device ID returned by _HID.
>>   
>> +For example, the following ACPI sample might be used to enumerate an lm75-type
>> +I2C temperature sensor and match it to the driver using the Device Tree
>> +namespace link:
>> +
>> +	Device (TMP0)
>> +	{
>> +		/* _HID will appear in sysfs */
>> +		Name (_HID, "PRP0001")
>> +
> 
>> +		/* _CID can also be used to search for "compatible" property */
>> +		Name (_CID, "PRP0001")
> 
> So, these lines are superfluous as stated exaxtly in a following paragraph.
> 
>> +
>> +		Name (_DSD, Package() {
>> +			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>> +			Package () {
>> +				Package (2) { "compatible", "ti,tmp75" },
>> +			}
>> +		})
>> +		Method (_CRS, 0, Serialized)
>> +		{
>> +			Name (SBUF, ResourceTemplate ()
>> +			{
>> +				I2cSerialBusV2 (0x48, ControllerInitiated,
>> +					400000, AddressingMode7Bit,
>> +					"\\_SB.PCI0.I2C1", 0x00,
>> +					ResourceConsumer, , Exclusive,)
>> +			})
>> +			Return (SBUF)
>> +		}
>> +	}
>> +
>>   It is valid to define device objects with a _HID returning PRP0001 and without
>>   the "compatible" property in the _DSD or a _CID as long as one of their
>>   ancestors provides a _DSD with a valid "compatible" property.  Such device
> 
