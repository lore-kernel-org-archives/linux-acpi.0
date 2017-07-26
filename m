From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] device property: export irqchip_fwnode_ops
Date: Wed, 26 Jul 2017 09:01:32 +0200
Message-ID: <CAK8P3a2Bh_4o9o-jm5ad=T4cFMkJyyQgzP=0ZH6RQEgdnwH5yA@mail.gmail.com>
References: <20170725153243.101147-1-arnd@arndb.de> <2233361.D5jIfdWk16@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2233361.D5jIfdWk16@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, Will Deacon <will.deacon@arm.com>, Eric Auger <eric.auger@redhat.com>, Sebastian Frias <sf84@laposte.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 26, 2017 at 2:13 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 25, 2017 05:32:31 PM Arnd Bergmann wrote:
>> The newly added irqchip_fwnode_ops structure is not exported, which can
>> lead to link errors:
>>
>> ERROR: "irqchip_fwnode_ops" [drivers/gpio/gpio-xgene-sb.ko] undefined!
>>
>> I checked that all other such symbols that were introduced are
>> exported if they need to be, this is the only missing one.
>>
>> Fixes: db3e50f3234b ("device property: Get rid of struct fwnode_handle type field")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the fix.
>
> It is linux-next only at this point, isn't it?

Correct, this is how I decided to send it to you rather than the
irqchip maintainers:

$ git log --oneline --ancestry-path --merges
db3e50f3234b..next/master | tail -n 5
cd8d05edc1ca Merge remote-tracking branch 'idle/next'
db7be21c3bad Merge remote-tracking branch 'pm/linux-next'
e2e9e06e4bb2 Merge branch 'acpi-numa' into linux-next
ed1d633e4584 Merge branches 'pm-tools' and 'pm-sleep' into linux-next
796cbe7125c1 Merge branch 'device-properties' into linux-next

      Arnd
