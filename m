From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Fri, 24 Jan 2014 08:46:32 +0800
Message-ID: <52E1B7E8.30300@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org> <201401171521.35940.arnd@arndb.de> <52DCE790.6080809@linaro.org> <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Amit
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B401=E6=9C=8822=E6=97=A5 19:46, Mark Rutland wrote:
> On Mon, Jan 20, 2014 at 09:08:32AM +0000, Hanjun Guo wrote:
>> On 2014-1-17 22:21, Arnd Bergmann wrote:
>>> On Friday 17 January 2014, Hanjun Guo wrote:
>>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>>
>>>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>>>> name from the ACPI timer table is matched with all the registered
>>>> timer controllers and matching initialisation routine is invoked.
>>> I wouldn't anticipate this infrastructure to be required. Shouldn't=
 all
>>> ARMv8 machines have an architected timer?
>> I not sure of this, could anyone can give some guidance? if only arc=
h
>> timer is available for ARM64, this will make thing very simple.
> All ARMv8 systems should have an architected timer.

Thanks for the clarification :)

>
> However, they may also have other timers (e.g. global timers for use
> when CPUs are in low power states and their local architected timers
> aren't active).

Only arch timer (generic timer) is defined as a table in ACPI 5.0
spec at now, so other timers will not described as table and will
described as device object in DSDT table, so do you think we need
this framework or not?

Thanks
Hanjun
