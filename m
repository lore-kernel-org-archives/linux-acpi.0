From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH v6 17/17] Documentation: ACPI for ARM64
Date: Tue, 06 Jan 2015 21:49:21 +0100
Message-ID: <9429675.LhiSR5rsOc@wuerfel>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org> <1420368918-5086-18-git-send-email-hanjun.guo@linaro.org> <D0F5605BA99F0B4594FB1EEC24E785CC654879C3@SZXEMA510-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D0F5605BA99F0B4594FB1EEC24E785CC654879C3@SZXEMA510-MBX.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: liyi 00215672 <phoenix.liyi@huawei.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, Timur Tabi <timur@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vg>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 06 January 2015 09:52:05 liyi 00215672 wrote:
> In traditional telecom market, what confused us(Huawei) was our softw=
are
> and hardware coupling together oftentimes. So if we change some hardw=
are
> then we MUST modify our software, which was not our customer=E2=80=99=
s
> expectation. In x86 world, we have UEFI and ACPI technologies, they a=
re
> suitable to solve this problem very well, we just upgrade our hardwar=
e
> and don=E2=80=99t need to upgrade their software, in the meantime ACP=
I provides
> many methods on power management.

Can you give an example of how ACPI solves the problem of supporting a
particular piece of new hardware?

I assume that for a completely new SoC, it won't help because you
still need device drivers for all the major parts of the hardware
that have changed, so this is about parts of the system that can
be abstracted in AML but not fully described in DT without the need
for new device drivers. Which are the main ones you are interested in
here?

	Arnd
