From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: Re: if power button pressed 1x it creates the same ACPI event twice
Date: Tue, 13 Jan 2015 17:47:24 +0100
Message-ID: <1202643605.20150113174724@eikelenboom.it>
References: <618666178.20150113173510@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <618666178.20150113173510@eikelenboom.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Tuesday, January 13, 2015, 5:35:10 PM, you wrote:

> Hi Rafael / Len,

> When i press the power-button on my intel NUC, i get twp ACPI power-events shortly 
> after one another (within a second), instead of just one. 

> It doesn't matter if i have the old /proc/acpi interface enabled or disabled in the kernel config.

> I have tested a few older kernels lingering around on the box and 3.14 already 
> has this problem. 3.2 (from the debian repo) doesn't have the problem, it only 
> fires one event.

> I did find another report:
>     Re: lenovo ultrabay docking station: if power button pressed 1x it creates 2x the same ACPI event
>     http://www.spinics.net/lists/linux-acpi/msg54723.html
> But that hasn't come to a conclusion ...


> Unfortunately 3.2 - 3.19-rc4 is a bit of a largish bisect window, so that's 
> unfeasible :-)

> I compiled in apci debug support and tried:
>  echo "0x00080000" > /sys/module/acpi/parameters/debug_layer
>  echo "0xffffffff" > /sys/module/acpi/parameters/debug_level

> But i don't get any extra output in dmesg ?

> Do you have any ideas for a debug patch or better values to figure out what is going on ?

> --
> Sander

Hmm is it normal that it registers in this way (twice) ?

[    5.817980] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    5.837907] ACPI: Power Button [PWRB]
[    5.847540] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    5.866915] ACPI: Power Button [PWRF]

--
Sander
