From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Tue, 29 Jul 2014 17:01:01 +0800
Message-ID: <53D762CD.7070006@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org> <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com> <5014834.k6eecMddPC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5014834.k6eecMddPC@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudeep
List-Id: linux-acpi@vger.kernel.org

On 2014-7-28 17:07, Arnd Bergmann wrote:
> On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
>> On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>> +Relationship with Device Tree
>>> +-----------------------------
>>> +
>>> +ACPI support in drivers and subsystems for ARMv8 should never be mutually
>>> +exclusive with DT support at compile time.
>>> +
>>> +At boot time the kernel will only use one description method depending on
>>> +parameters passed from the bootloader.
>>
>> Possibly overriden by kernel bootargs. And as debated for quite a
>> while earlier this year, acpi should still default to off -- if a DT
>> and ACPI are both passed in, DT should at this time be given priority.
> 
> I think this would be harder to do with the way that ACPI is passed in
> to the kernel. IIRC, you always have a minimal DT information based on
> the ARM64 boot protocol, but in the case of ACPI, this contains pointers
> to the ACPI tables, which are then used for populating the Linux platform
> devices (unless acpi=disabled is set), while the other contents of the
> DTB may be present but we skip the of_platform_populate state.
> 
> If this is correct, then replacing the firmware-generated dtb with a
> user-provided on would implicitly remove the ACPI tables from visibility,
> which is exactly what we want.
> 
> It's possible that I'm misremembering it though, and it should be
> documented better.
> 
>>> +Regardless of whether DT or ACPI is used, the kernel must always be capable
>>> +of booting with either scheme.
>>
>> It should always be possible to compile out ACPI. There will be plenty
>> of platforms that will not implement it, so disabling CONFIG_ACPI
>> needs to be possible.
> 
> Right.

Actually, if platforms don't implement ACPI, acpi_disabled will always be set to
1 at early boot stage which before the device tree is unflattened, so device
tree will work as expected even if CONFIG_ACPI=y on such platforms.

Thanks
Hanjun
