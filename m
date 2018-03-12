From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Date: Mon, 12 Mar 2018 23:29:56 +0100
Message-ID: <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
References: <20180312194715.GA3992@amd> <20180312194944.GA3979@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312194944.GA3979@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, Ognjen Galic <smclt30p@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 12, 2018 at 8:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-03-12 20:47:15, Pavel Machek wrote:
>> Hi!
>>
>> Did something change recently with battery reporting?

Yes, it did, and specifically for Thinkpads.

>> Fully charged
>> battery shows as empty battery with red "x" in Mate desktop. After
>> reboot to recent mainline problem goes away. Tooltip says "battery
>> waiting to charge".
>>
>> /proc/acpi/battery/BAT0/state looks ok:
>> present:                 yes
>> capacity state:          ok
>> charging state:          charged
>> present rate:            0 mW
>> remaining capacity:      41240 mWh
>> present voltage:         16495 mV
>>
>> Linux amd 4.16.0-rc3-next-20180302 #30 SMP Fri Mar 2 10:28:44 CET 2018
>> i686 GNU/Linux
>> pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
>> Not charging
>
> Reboot to mainline:
>
> pavel@amd:~$ uname -a
> Linux amd 4.16.0-rc4+ #509 SMP Thu Mar 8 15:28:06 CET 2018 i686
> GNU/Linux
> pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
> Unknown
>
> Mate shows it as "laptop battery is fully charged".
>
>> Thinkpad X60.

Please try to revert commits fa93854f7a7e..a20136a67a99 from
linux-next and see if that helps.
