From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT
 is parsed
Date: Mon, 15 Sep 2014 17:55:41 -0400
Message-ID: <5417605D.7070303@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>	<1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>	<20140915064010.GD26649@localhost>	<20140915175250.8177DC40A42@trevor.secretlab.ca> <CAOesGMjcXYjmUzZqGncnkN-uhnLC1ey2vqeqE4MQ5UDm8BaYTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbaIOV47 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Sep 2014 17:56:59 -0400
In-Reply-To: <CAOesGMjcXYjmUzZqGncnkN-uhnLC1ey2vqeqE4MQ5UDm8BaYTg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-arm-kerne

On 09/15/2014 02:01 PM, Olof Johansson wrote:
> On Mon, Sep 15, 2014 at 10:52 AM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Sun, 14 Sep 2014 23:40:10 -0700, Olof Johansson <olof@lixom.net> wrote:
>>> On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
>>>> When MADT is parsed, print GIC information to make the boot
>>>> log look pretty.
>>>
>>> If you do this for prettiness, having an example output in the commit
>>> message would be a nice touch.
>>
>> Agreed.

Here's example output from a hardware platform (just as an example in
this thread, mostly for archiving purposes):

[    0.000000] ACPI: GICC (acpi_id[0x0000] address[00000000e112f000]
MPDIR[0x0] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0001] address[00000000e112f000]
MPDIR[0x1] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0100] address[00000000e112f000]
MPDIR[0x100] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0101] address[00000000e112f000]
MPDIR[0x101] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0200] address[00000000e112f000]
MPDIR[0x200] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0201] address[00000000e112f000]
MPDIR[0x201] enabled)

Jon.

