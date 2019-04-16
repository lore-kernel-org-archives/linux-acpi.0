From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
Date: Tue, 16 Apr 2019 11:56:00 +0100
Message-ID: <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, coresight@lists.linaro.org, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 04/16/2019 11:48 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> Make the device_fwnode_match() a generic helper to match device
>> by fwnode handle for use with bus_find_device(). This will be
>> also used by coresight.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>
>> Resending with linux-acpi in Cc, as requested by Rafael.
> 
> Do any other patches in your series depend on this one?

Yes, I do. But they are in the middle of a big series of changes and
I don't expect this series to go into 5.2. So, if you plan to pull this
please go ahead.

Suzuki
