From: Tom Gundersen <teg@jklm.no>
Subject: Re: Regression in thinkpad-acpi events
Date: Thu, 24 Nov 2011 10:25:44 +0100
Message-ID: <CAG-2HqUgHAa=H6RBS2-Z3FG6OgmaWSJpdBWHn=n7Lm5O6G7ZWA@mail.gmail.com>
References: <4EBAC3B5.5060405@gmail.com> <201111142031.06663.maciej.rutecki@gmail.com>
 <4EC16F8E.7060601@gmail.com> <201111142118.47256.maciej.rutecki@gmail.com>
 <CAG-2HqVnsmSyHVCvEVf+sZw5NxhR8qSDDB0AtR+igwCCFiwfgQ@mail.gmail.com> <20111115230305.GA23325@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111115230305.GA23325@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: maciej.rutecki@gmail.com, Natanji <natanji@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Henrique,

On Wed, Nov 16, 2011 at 12:03 AM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
>> As requested:
>> # grep . /sys/bus/platform/devices/thinkpad*/*
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_enable:1
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_mask:0x008dffff
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_poll_freq:10
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_radio_sw:1
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_recommended_mask:0x00=
8dffff
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_report_mode:1
>> /sys/bus/platform/devices/thinkpad_acpi/hotkey_source_mask:0x0000000=
0
>
> Well, the driver has connected to the firmware, and should be working=
=2E =C2=A0And
> there were no changes to the code from v3.0 to v3.1.1. =C2=A0So, it i=
s either a
> bug in something else, a problematic interaction of the driver with
> something else, or a latent thinkpad-acpi bug that some change elsewh=
ere has
> exposed.
>
> Are the events reported by acpi_listen from arch-linux exactly the sa=
me in
> v3.0.9 and v3.1.1 ? =C2=A0I know some events are missing in your v3.1=
=2E1, but I am
> interested in the ones that do get reported.
>
> Although you really should be using the input device for the hotkeys,=
 and
> not any of the 0x10xx events. =C2=A0Those are driver-specific and dep=
recated, it
> is all explained in Documentation/laptops/thinkpad-acpi.txt. =C2=A0So=
, it really
> might mean that you have something in userspace reading that input de=
vice
> and synthesizing the ACPI HKEY events thinkpad-acpi deprecated for a =
long
> time now. =C2=A0I know some distros did that instead of switching to =
an
> input-device-based hotkey daemon. =C2=A0Please check for that possibi=
lity,
> that daemon could be the one having problems with 3.1.1...

It looks like my problem was something else. We don't do anything to
synthesize the ACPI HKEY events (AFAIK), so I believe that KDE (which
I am using) should be using the input events and that the HKEY stuff
does not matter.

I am still trying to figure out why my laptop does not always go to
sleep when I close my lid, but it turns out that I cannot reproduce it
reliably so it is taking me some time.

As to the original report about the change in HKEY events, this is
(probably) due to PROCFS_ACPI being disabled in the Arch kernel as of
3.1.

Cheers,

Tom
