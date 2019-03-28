From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 21/25] coresight: Use fwnode handle instead of device
 names
Date: Thu, 28 Mar 2019 18:42:58 +0000
Message-ID: <01518a53-23d1-8c70-7327-69e8602bddb6@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-22-git-send-email-suzuki.poulose@arm.com>
 <20190328174216.GD778@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328174216.GD778@xps15>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On 03/28/2019 05:42 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:38PM +0000, Suzuki K Poulose wrote:
>> We rely on the device names to find a CoreSight device on the
>> coresight bus. The device name however is obtained from the platform,
>> which is bound to the real platform/amba device. As we are about
>> to use different naming scheme for the coresight devices, we can't
>> rely on the platform device name to find the corresponding
>> coresight device. Instead we use the platform agnostic
>> "fwnode handle" of the parent device to find the devices.
>> We also reuse the same fwnode as the parent for the Coresight
>> device we create.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Agreed to all comments. Will address them in the next revision.

Cheers
Suzuki
