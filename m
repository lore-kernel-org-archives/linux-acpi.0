From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/9] ACPI / LPSS: fix system hangup on BYT/BSW/CHT
Date: Sat, 5 Dec 2015 01:07:47 +0100
Message-ID: <CAJZ5v0gO5BhqMv6QFAjL-PkAT8_kKiQN6XHq41W4tFk74ArCdw@mail.gmail.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1838591.lmJz0NSQxf@vostro.rjw.lan>
	<CAHp75VeJ+Qc4c+n69WXQu3_r5=GZr2MtK02XCm1xtEs==Kiihw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34186 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbbLEAHt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2015 19:07:49 -0500
In-Reply-To: <CAHp75VeJ+Qc4c+n69WXQu3_r5=GZr2MtK02XCm1xtEs==Kiihw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Hi,

On Sat, Dec 5, 2015 at 12:15 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 5, 2015 at 1:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, December 04, 2015 11:49:16 PM Andy Shevchenko wrote:

[cut]

>>
>> The series generally looks good to me, but patch [1/9] needs an ACK from Greg
>> and the dmaengine ones need ACKs from Vinod.
>
> Thank you!
> Greg, Vinod, what is your opinion?
>
> Just noticed we have to exchange patches 4 and 5 (5 should go before 4
> due to bisectability).
>
> Also I would like to ask you to comment and maybe Ack (seems we have
> no powercap maintainers) the mentioned patch for dependency [2].
>
>>> [2] http://www.spinics.net/lists/kernel/msg2119229.html

I'm the top-level powercap maintainer, but the RAPL driver is
maintained by Jacob.  Please ask him for an ACK.

Thanks,
Rafael
