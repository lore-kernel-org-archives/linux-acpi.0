From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 05/25] coresight: Merge the static and dynamic replicator
 drivers
Date: Wed, 27 Mar 2019 17:33:24 +0000
Message-ID: <21d02bdd-5fe2-4496-b96d-f588f559e8d7@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-6-git-send-email-suzuki.poulose@arm.com>
 <20190327152749.GC1658@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327152749.GC1658@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On 03/27/2019 03:27 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:22PM +0000, Suzuki K Poulose wrote:
>> Merge the drivers for the two varieties of replicators into
>> a singel one. The dynamic replicator has programming base
>> which can be programmed to filter the trace data. The driver
>> detects the type based on the "base" address value of the
>> device, which is NULL for the static device.
>>
>> Also, while at it, remove the now obsolete DYNAMIC_REPLICATOR
>> config entry.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I'll pickup patches 1 to 5 immediately as they are useful on their own.

Cool, Thanks. I will drop them from the next revision

Suzuki
