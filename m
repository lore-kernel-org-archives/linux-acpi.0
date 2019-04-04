From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 23/25] coresight: stm: ACPI support for parsing stimulus
 base
Date: Thu, 4 Apr 2019 12:27:13 +0100
Message-ID: <09baa551-b351-6651-e609-75ed425ae7f4@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
 <20190328204151.GA7163@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328204151.GA7163@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org

Hi Mathieu,

On 28/03/2019 20:41, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:40PM +0000, Suzuki K Poulose wrote:
>> The stimulus base for STM device must be listed as the second memory
>> resource, followed by the programming base address. Add support for
>> parsing the information for ACPI.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---

>> +#ifdef CONFIG_ACPI
>> +static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
>> +{
>> +	int rc;
>> +	bool found_base = false;
>> +	struct resource_entry *rent;
>> +	LIST_HEAD(res_list);
>> +
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>> +
>> +	if (!adev)
>> +		return -ENODEV;
>> +	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = -ENOENT;
>> +	list_for_each_entry(rent, &res_list, node) {
>> +		if (resource_type(rent->res) != IORESOURCE_MEM)
>> +			continue;
>> +		if (found_base) {
>> +			*res = *rent->res;
>> +			rc = 0;
>> +			break;
>> +		}
>> +
>> +		found_base = true;
> 
> Is the ACPI binding crystal clear on the fact that the second resource region
> has to be for stimulus ports?

Yes. Section 2.3 Resources in ACPI for CoreSightTM 1.0 (DEN0067) :

"Each CoresSight component needs to declare the resources it owns using the _CRS
method. This must include base address and span covering the MMIO interface of
the device. In addition those that can raise interrupts must describe the
interrupts they consume.

For STM two base addresses must be presented, these must be provided in order.
First the configuration base address, and then external stimuli memory region
base address"

>>   static int stm_get_stimulus_area(struct device *dev, struct resource *res)
>>   {
>>   	if (dev->of_node)
> 
> Wouldn't it be better to use is_of_node()?


> 
>>   		return of_stm_get_stimulus_area(dev, res);
>> +	else if (is_acpi_node(dev->fwnode)
> 
> is_acpi_device_node()?
> 

Yes, to both the above.

Cheers
Suzuki
