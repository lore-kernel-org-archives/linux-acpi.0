From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 13/25] coresight: etb10: Clean up device specific data
Date: Thu, 28 Mar 2019 11:09:12 +0000
Message-ID: <67c7b74e-62d9-1f73-0622-b861af44c6b4@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
 <20190327213903.GA778@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327213903.GA778@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On 03/27/2019 09:39 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:30PM +0000, Suzuki K Poulose wrote:
>> Track the coresight device instead of the real device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>>   
>> @@ -701,7 +701,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   
>> -	drvdata->dev = &adev->dev;
>>   	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>>   	if (!IS_ERR(drvdata->atclk)) {
>>   		ret = clk_prepare_enable(drvdata->atclk);
>> @@ -740,6 +739,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>>   	if (IS_ERR(drvdata->csdev))
>>   		return PTR_ERR(drvdata->csdev);
>>   
>> +	drvdata->dev = &drvdata->csdev->dev;
> 
> For patch 11, 12, 13 - same comment as earlier.  Let's use drvdata::csdev
> and get rid of drvdata::dev.
> 

Sure, will do.

Thanks for the detailed review !

Suzuki
