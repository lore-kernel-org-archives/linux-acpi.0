From: Brad Campbell <brad@fnarfbargle.com>
Subject: Re: sony-laptop on VAIO TT help request
Date: Mon, 04 Jul 2011 17:19:14 +0800
Message-ID: <4E118592.5060301@fnarfbargle.com>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E0D9765.7060700@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 01/07/11 17:46, Marco Chiappero wrote:
> Il 30/06/2011 17:52, Brad Campbell ha scritto:
>> On 30/06/11 21:55, Mattia Dongili wrote:
>>
>>> there are patches already floating around, you can take a look here
>>> http://www.absence.it/vaio-acpi/source/patches/
>>> the code is making its way into the kernel.
>>
>> Hrm.. next time I guess I'll ask before breaking out the debugger!
>
> Hello,
> could you please provide us your DSDT and the exact model string of your TT?
>
http://www.fnarfbargle.com/private/110704_dsdt/tt.dsdt

The Model is a VGN-TT15GN

My dsdt has been patched to recognise a new wireless card but is otherwise unmodified. Everything 
appears to work but I'll be adding a WWAN card and swapping the Wifi card in the next week or two, 
so we'll see how that goes.

The patch I was pointed at earlier seems to pretty much activate everything.

brad@bklaptop:~$ sudo grep . /sys/devices/platform/sony-laptop/*
/sys/devices/platform/sony-laptop/als_backlight:213
/sys/devices/platform/sony-laptop/als_backlight_levels:0x07 0x0c 0x0f 0x15 0x22 0x3c 0x58 0x8d 0xd5
/sys/devices/platform/sony-laptop/als_defaults:0x05 0xaa 0x00 0x55 0x6e 0x01 0x23 0x02 0x08 0x04 
0x32 0x00 0x00
/sys/devices/platform/sony-laptop/als_kelvin:0
/sys/devices/platform/sony-laptop/als_lux:0.00
/sys/devices/platform/sony-laptop/als_managed:0
/sys/devices/platform/sony-laptop/als_power:0
/sys/devices/platform/sony-laptop/battery_care_limiter:1
/sys/devices/platform/sony-laptop/battery_highspeed_charging:0
/sys/devices/platform/sony-laptop/bluetoothpower:0
/sys/devices/platform/sony-laptop/fanspeed:17
/sys/devices/platform/sony-laptop/lid_resume_control:0
/sys/devices/platform/sony-laptop/modalias:platform:sony-laptop
/sys/devices/platform/sony-laptop/odd_power:1
/sys/devices/platform/sony-laptop/thermal_control:1
/sys/devices/platform/sony-laptop/thermal_profiles:3
/sys/devices/platform/sony-laptop/touchpad:1
/sys/devices/platform/sony-laptop/uevent:DRIVER=sony-laptop
/sys/devices/platform/sony-laptop/uevent:MODALIAS=platform:sony-laptop
/sys/devices/platform/sony-laptop/wwanpower:0

No manual fanspeed control. bluetoothpower does not seem to do anything. I don't have wwan installed 
yet, so I can't test wwanpower but I would have expected that to be controlled via rfkill.

I don't seem to be able to get the power consumption down below about 7W though. With Windows I can 
get it below 6W. I'll keep fiddling.

Interesting point. Windows sets up the graphics card in 16 bit mode to reduce power consumption. 
With X in 16 bit mode I seem to get about .5-.7W higher power consumption than in the default 24bit 
mode.
