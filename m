From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 11 Sep 2014 16:57:24 +0100
Message-ID: <5411C664.4060007@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <20140911132935.068DCC408F6@trevor.secretlab.ca> <20140911153739.GA24416@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140911153739.GA24416@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 11/09/14 16:37, Catalin Marinas wrote:
> On Thu, Sep 11, 2014 at 02:29:34PM +0100, Grant Likely wrote:
>> Regarding the requests to refactor ACPICA to work better for ARM. I
>> completely agree that it should be done, but I do not think it should be
>> a prerequisite to getting this core support merged. That kind of
>> refactoring is far easier to justify when it has immediate improvement
>> on the mainline codebase, and it gives us a working baseline to test
>> against. Doing it the other way around just makes things harder.
>
> I have to disagree here. As I said, I'm perfectly fine with refactoring
> happening later but I'm not happy with compiling in code with undefined
> behaviour on ARM that may actually be executed at run-time.
>
> I'm being told one of the main advantages of ACPI is forward
> compatibility: running older kernels on newer hardware (potentially with
> newer ACPI version tables). ACPI 5.1 includes partial support for ARM
> but the S and C states are not defined yet. We therefore assume that
> hardware vendors deploying servers using ACPI would not provide such
> yet to be defined information in ACPI 5.1 tables.
>
> What if in a year time we get ACPI 5.2 or 6 (or an errata update)
> covering the S and C states for ARM? I would expect hardware vendors
> to take advantage and provide such information in ACPI tables. Can we
> guarantee that a kernel with the current ACPI patches wouldn't blow up
> when it tries to interpret the new tables? If we can't guarantee this,
> we rather fix it now. Some suggestions:
>
> a) Make sure code which doesn't have a clear behaviour on ARM is not
>     compiled in and doesn't even try to interpret such tables on ARM (you
>     could just go for the latter but I'm not sure how feasible it is)

This what we have suggested in past especially for this S-state support.
Currently the core acpi code compiles in sleep support unconditionally.
That doesn't mean we need to do the same on ARM64, we can easily make
sure that's not enabled for ARM64 until we have clarification on how to
support them on ARM in ACPI specification.

I just pointed out at one "out of spec" workaround done for x86
"unconditionally" in the code just to tell that it won't work on ARM.
That shouldn't be misunderstood as demand for refactoring as we have no
clue how S-state would look on ARM to take up any such task.

Regards,
Sudeep
