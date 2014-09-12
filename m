From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Fri, 12 Sep 2014 17:30:01 -0400
Message-ID: <541365D9.4050908@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org> <540E80BD.20801@redhat.com> <540E88A2.1000606@linaro.org> <540E93A0.4040306@redhat.com> <540F2422.90105@linaro.org> <540F24FF.2060302@redhat.com> <20140911141508.GK6158@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140911141508.GK6158@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bj
List-Id: linux-acpi@vger.kernel.org

On 09/11/2014 10:15 AM, Will Deacon wrote:
> On Tue, Sep 09, 2014 at 05:04:15PM +0100, Jon Masters wrote:
>> On 09/09/2014 12:00 PM, Hanjun Guo wrote:
>>> No, you didn't miss it, I'm still working on the new version, sorry I didn't
>>> clarify that in my previous email.
>>
>> Thanks. If you could copy me on the next posting that would rock. In a
>> few hours we should have another platform posted as an example. In
>> addition, a couple of lower priority patches (building upon the core
>> ACPI pieces) should be posted as well.
> 
> Can I breath out yet or did I miss the platform posting?

There's a posting for AMD Seattle coming soon as an example. Also, there
should be some hardware at Connect on which patches can run.

Jon.
