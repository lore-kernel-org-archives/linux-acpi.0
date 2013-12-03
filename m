From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use arch_timer_acpi_init()
Date: Wed, 04 Dec 2013 00:30:35 +0800
Message-ID: <529E072B.3060901@linaro.org>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org> <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org> <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com> <529DE21E.4080707@linaro.org> <CACRpkdZWELp1u=O=gSGZhaxQ2oTMu_jXuJb43snrr-tdYW9XAA@mail.gmail.com> <20131203144309.GC7552@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131203144309.GC7552@e106331-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Jon Masters <jonathan@jonmasters.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Patch Tracking <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B412=E6=9C=8803=E6=97=A5 22:43, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 02:13:49PM +0000, Linus Walleij wrote:
>> On Tue, Dec 3, 2013 at 2:52 PM, Hanjun Guo <hanjun.guo@linaro.org> w=
rote:
>>
>>> I will introduce has_arch_timer_node() as you said and use
>>> it as follows:
>>>
>>> if (has_arch_timer_node())
>>> clocksource_of_init();
>>> esle
>>> arch_timer_acpi_init(); /* try ACPI way */
>>>
>>> Is this make sense to you?
> What does arch_timer_acpi_init() do? Is it just detecting the presenc=
e
> of the timer, or grabbing the rate from a property in an ACPI table?

It seems that you didn't get the PATCH 1/2, and my part1/part2 patch se=
t
is also missing, I will resend all the patch set, sorry for the noise.

Thanks
Hanjun
