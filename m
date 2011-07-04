From: Marco Chiappero <marco@absence.it>
Subject: Re: sony-laptop on VAIO TT help request
Date: Mon, 04 Jul 2011 13:11:01 +0200
Message-ID: <4E119FC5.6060604@absence.it>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it> <4E118592.5060301@fnarfbargle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E118592.5060301@fnarfbargle.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Brad Campbell <brad@fnarfbargle.com>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Il 04/07/2011 11:19, Brad Campbell ha scritto:

> brad@bklaptop:~$ sudo grep . /sys/devices/platform/sony-laptop/*
> /sys/devices/platform/sony-laptop/als_backlight:213
> /sys/devices/platform/sony-laptop/als_backlight_levels:0x07 0x0c 0x0f
> 0x15 0x22 0x3c 0x58 0x8d 0xd5
> /sys/devices/platform/sony-laptop/als_defaults:0x05 0xaa 0x00 0x55 0x6e
> 0x01 0x23 0x02 0x08 0x04 0x32 0x00 0x00
> /sys/devices/platform/sony-laptop/als_kelvin:0
> /sys/devices/platform/sony-laptop/als_lux:0.00
> /sys/devices/platform/sony-laptop/als_managed:0
> /sys/devices/platform/sony-laptop/als_power:0

If you want to enjoy the ALS driven backlight control (I see here 
disabled) you should also compile and run the daemon at 
http://git.zx2c4.com/sony-acpid/

> No manual fanspeed control. bluetoothpower does not seem to do anything.

That because the SPIC device is still present but probably unused (can 
we avoid to initialize it?) since everything goes through the SNC 
device. I don't know if models using both the SNC and SPIC devices 
exist. Mattia?

> I don't have wwan installed yet, so I can't test wwanpower but I would
> have expected that to be controlled via rfkill.

Right.

> I don't seem to be able to get the power consumption down below about 7W
> though. With Windows I can get it below 6W. I'll keep fiddling.

Try using the autodimming feature and try turning off the optical device 
and maybe the touchpad (control files in 
/sys/devices/platform/sony-laptop/ should be more or less 
self-explanatory but ask if you need). I can't say much about this, sorry.
