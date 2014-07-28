From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Mon, 28 Jul 2014 17:14:59 +0100
Message-ID: <53D67703.7090306@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <5959830.lpqeqL7HbK@wuerfel> <53D65C16.2050202@arm.com>
 <13731398.6CtXoCyCVq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <13731398.6CtXoCyCVq@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel
List-Id: linux-acpi@vger.kernel.org



On 28/07/14 16:23, Arnd Bergmann wrote:
> On Monday 28 July 2014 15:20:06 Andre Przywara wrote:
>> On 28/07/14 11:46, Arnd Bergmann wrote:
>>> On Monday 28 July 2014 10:23:57 Graeme Gregory wrote:
>>>> The PL011 UART is the use-case I keep hitting, that IP block has a 
>>>> variable input clock on pretty much everything I have seen in the wild. 
>>>
>>> Ok, I see. What does ACPI-5.1 say about pl011?
>>>
>>> Interestingly, the subset of pl011 that is specified by SBSA does not
>>> contain the IBRD/FBRD registers, effectively making it a fixed-rated
>>> UART (I guess that would be a ART, without the U then), and you
>>> consequently don't even need to know the clock rate.
>>
>> The idea of this was probably to let the baudrate set by some firmware
>> code to the "right" value and the spec just didn't want to expose the
>> details for the generic UART:
>> "This specification does not cover registers needed to configure the
>> UART as these are considered hardware-specific and will be set up by
>> hardware-specific software."
>> To me that reads like the SBSA UART is just for debugging, and you are
>> expected just to access the data register.
> 
> Right, makes sense. It also avoids the case where Linux for some reason
> ends up using a different line rate than the firmware, which can
> cause a lot of unnecessary pain.
> 
>>> However, my guess is that most hardware in the real world contains
>>> an actual pl011 and it does make a lot of sense to allow setting
>>> the baud rate on it, which then requires knowing the input clock.
>>>
>>> If there is any hardware that implements just the SBSA-mandated subset
>>> rather than the full pl011, we should probably implement both
>>> in the kernel: a dumb driver that can only send and receive, and the
>>> more complex one that can set the bit rates and flow-control but that
>>> requires a standardized ACPI table with the input clock rate.
>>
>> The fast model I use can be switched to use the SBSA restricted PL011,
>> and as expected the Linux kernel crashes at the device doesn't support
>> DMA (and a lot more stuff) - but the current code requires it.
> 
> It does? We have a lot of platforms that don't have DMA support for
> pl011.

Well, to be honest I just booted the full featured kernel with the
changed fast model config, so the platform and the DT claimed DMA
support, just the emulated hardware doesn't implement it ;-)
And beside that a whole lot of other PL011 registers are not available,
so the crash could be caused by anything. I didn't look to closely why
it broke.

>> So I am about to implement a new driver for that SBSA subset. So far
>> this will be a separate driver, starting from a copy of amba-pl011.c,
>> but removing most of the code ;-)
> 
> Ok. You might want to consider starting from a different base though.
> IIRC, pl011 uses uart_port as the basic abstraction, while the
> new driver should probably use the raw tty_port instead.
> drivers/tty/goldfish.c is probably a good example to look at for
> that.

Good hint, will look at this.

Cheers,
Andre.

> 
> You could also make it a hvc_driver like drivers/tty/hvc/hvc_vio.c,
> but I'm not sure if that model seen favorable by the tty maintainers.
> It would probably be the shortest driver though.
> 
> 	Arnd
> 
> 
