From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 18/25] coresight: Introduce generic platform data helper
Date: Thu, 28 Mar 2019 10:59:57 +0000
Message-ID: <5268e8bd-2c6d-72bd-7628-e7d5ff90b2da@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-19-git-send-email-suzuki.poulose@arm.com>
 <20190327225721.GC778@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327225721.GC778@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On 03/27/2019 10:57 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:35PM +0000, Suzuki K Poulose wrote:
>> So far we have hard coded the DT platform parsing code in
>> every driver. Introduce generic helper to parse the information
>> provided by the firmware in a platform agnostic manner, in preparation
>> for the ACPI support.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>>   
>> +static int coresight_alloc_conns(struct device *dev,
>> +				 struct coresight_platform_data *pdata)
>> +{
>> +	if (pdata->nr_outport) {
>> +		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
>> +					    sizeof(*pdata->conns),
>> +					    GFP_KERNEL);
>> +		if (!pdata->conns)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

>> -	ret = of_coresight_alloc_memory(dev, pdata);
>> +	ret = coresight_alloc_conns(dev, pdata);
> 
> I'm pretty sure you're doing this because you want to use
> coresight_alloc_conns() for ACPI as well, and I'm fine with that.  But it is
> quite orthogonal to the rest of the work done in this patch and as such I think
> it needs a patch of its own.
> 

Sure, will split this into a separate patch.

Suzuki
