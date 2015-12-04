From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/9] ACPI / LPSS: fix system hangup on BYT/BSW/CHT
Date: Sat, 5 Dec 2015 01:15:59 +0200
Message-ID: <CAHp75VeJ+Qc4c+n69WXQu3_r5=GZr2MtK02XCm1xtEs==Kiihw@mail.gmail.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1838591.lmJz0NSQxf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1838591.lmJz0NSQxf@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 5, 2015 at 1:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, December 04, 2015 11:49:16 PM Andy Shevchenko wrote:
>> Here is a v3 of the next generation (previous one is [1]) of the long standing
>> power issue fix regarding to LPSS on Intel Baytrail and Braswell SoCs, in
>> particularly ASuS T100TA. There are few bugs already opened on kernel.org's and
>> RedHat's bugzilla sites.
>>
>> The series depends on the patch submitted earlier [2].
>>
>> The patch 1 brings a new notification to handle the case when ->probe() of the
>> driver fails. It allows to avoid a potential problems. I've noticed couple of
>> drivers that are using that in assumption that ->probe() never fails.
>>
>> The patches 2 & 4 are needed to fix an I2C issue which Jarkko is currently
>> investigating.
>>
>> It seems the best way to push it through linux-pm tree. Thus, it would be good
>> to get ACKs from the rest of maintainers.
>>
>> Rafael, it would be nice to have an immutable branch or tag for this sice I
>> have more patches coming for dw_dmac driver which are based on top of this
>> series.
>>
>> The patches have been tested on ASuS T100TA, Intel Cherrytrail, and Intel
>> Braswell SoCs.
>>
>> [1] http://www.spinics.net/lists/linux-acpi/msg53963.html
>> [2] http://www.spinics.net/lists/kernel/msg2119229.html
>>
>> Changelog v3:
>> - patch 2 is split to pure revert with Fixes tag for stable and new change in
>>   patch 3
>> - add patch 4 to resolve an issue when I2C can't be probed and SDHCI leaves
>>   devices in D0
>> - address comments from Rafael
>> - quirk functions moved under CONFIG_PM
>>
>> Andy Shevchenko (9):
>>   device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
>>   Revert "ACPI / LPSS: allow to use specific PM domain during ->probe()"
>>   ACPI / LPSS: allow to use specific PM domain during ->probe()
>>   ACPI / LPSS: power on when probe() and otherwise when remove()
>>   ACPI / LPSS: do delay for all LPSS devices when D3->D0
>>   ACPI / LPSS: override power state for LPSS DMA device
>>   dmaengine: dw: platform: power on device on shutdown
>>   dmaengine: dw: return immediately from IRQ when DMA isn't in use
>>   Revert "dmaengine: dw: platform: provide platform data for Intel"
>>
>>  arch/x86/Kconfig                |   3 +-
>>  arch/x86/include/asm/iosf_mbi.h |   2 +
>>  drivers/acpi/acpi_lpss.c        | 213 +++++++++++++++++++++++++++++++++++++---
>>  drivers/base/dd.c               |  10 +-
>>  drivers/dma/dw/core.c           |   9 +-
>>  drivers/dma/dw/platform.c       |  29 +++---
>>  include/linux/device.h          |   1 +
>>  7 files changed, 231 insertions(+), 36 deletions(-)
>
> The series generally looks good to me, but patch [1/9] needs an ACK from Greg
> and the dmaengine ones need ACKs from Vinod.

Thank you!
Greg, Vinod, what is your opinion?

Just noticed we have to exchange patches 4 and 5 (5 should go before 4
due to bisectability).

Also I would like to ask you to comment and maybe Ack (seems we have
no powercap maintainers) the mentioned patch for dependency [2].

>> [2] http://www.spinics.net/lists/kernel/msg2119229.html

-- 
With Best Regards,
Andy Shevchenko
