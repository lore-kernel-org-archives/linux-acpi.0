From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 10/25] coresight: tpiu: Clean up device specific data
Date: Wed, 27 Mar 2019 11:52:54 +0000
Message-ID: <db4dfb7b-49db-ca9b-58ca-8b40a9157949@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
 <20190326215440.GB1658@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326215440.GB1658@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On 03/26/2019 09:54 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:27PM +0000, Suzuki K Poulose wrote:
>> Switch to using the coresight device instead of the parent
>> amba device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpiu.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
>> index b2f72a1..9763721 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
>> @@ -48,15 +48,13 @@
>>   
>>   /**
>>    * @base:	memory mapped base address for this component.
>> - * @dev:	the device entity associated to this component.
>> + * @dev:	the coresight device entity associated to this component.
>>    * @atclk:	optional clock for the core parts of the TPIU.
>> - * @csdev:	component vitals needed by the framework.
>>    */
>>   struct tpiu_drvdata {
>>   	void __iomem		*base;
>>   	struct device		*dev;
>>   	struct clk		*atclk;
>> -	struct coresight_device	*csdev;
> 
> Here again I would get rid of @dev rather than @csdev to be consistent with what
> was done previously.

Sure, will do.

Cheers
Suzuki
