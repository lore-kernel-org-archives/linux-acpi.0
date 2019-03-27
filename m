From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 08/25] coresight: tmc: Clean up device specific data
Date: Wed, 27 Mar 2019 11:45:17 +0000
Message-ID: <cdb22ab6-c43f-5cf6-3110-eaa6906ae1a5@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-9-git-send-email-suzuki.poulose@arm.com>
 <20190326215322.GA1658@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326215322.GA1658@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, mathie.poirier@linaro.org
List-Id: linux-acpi@vger.kernel.org

On 03/26/2019 09:53 PM, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Wed, Mar 20, 2019 at 06:49:25PM +0000, Suzuki K Poulose wrote:
>> In preparation to use a consistent device naming scheme,
>> clean up the device link tracking in replicator driver.
>> Use the "coresight" device instead of the "real" parent device
>> for all internal purposes. All other requests (e.g, power management,
>> DMA operations) must use the "real" device which is the parent device.
>>
>> Since the CATU driver also uses the TMC-SG infrastructure, update
>> the callers to ensure they pass the appropriate device argument
>> for the tables.
>>
>> Cc: Mathieu Poirier <mathie.poirier@linaro.org>
> 
> I was wondering why patches 6, 7, and 8 didn't make it to my inbox...  Now I
> have the answer :o)

Ah! Sorry about that. Will fix it

Suzuki
