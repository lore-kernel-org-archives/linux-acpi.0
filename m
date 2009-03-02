From: Norbert Preining <preining@logic.at>
Subject: Re: sony-laptop support for Vaio VGN-C2S
Date: Mon, 2 Mar 2009 13:51:14 +0100
Message-ID: <20090302125114.GE15676@gamma.logic.tuwien.ac.at>
References: <1235996539.4378.4.camel@dexmobile> <20090302123948.GB24234@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:52939 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbZCBMv0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2009 07:51:26 -0500
Content-Disposition: inline
In-Reply-To: <20090302123948.GB24234@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Luis Nabais <luis.nabais@caixamagica.pt>, linux-acpi@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mo, 02 Mär 2009, Mattia Dongili wrote:
> On Mon, Mar 02, 2009 at 12:22:19PM +0000, Luis Nabais wrote:
> > I have a vaio VGN-C2S and some of the fn-keys (brightness and the
> > monitor/tv-out key) don't work and since I don't know how to go and hack
> > the module to get the keys working I thought you could help me.

Same here, Vaio VGN-Z11VN

> what kernel version are you using?

2.6.29-rc5 with your patches posted today(yesterday) (9 of them).

> can you also send the output from 
>   dmidecode -t system

Mine is:
# dmidecode 2.9
SMBIOS 2.4 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-Z11VN_B
	Version: J003CWP8
	Serial Number: 28274853-5000470
	UUID: CC21B8B0-B83F-11DC-9D1E-001A80D75937
	Wake-up Type: Power Switch
	SKU Number: N/A
	Family: N/A

Handle 0x0006, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected


> and the kernel log after unloading and reloading the sony-laptop module
> with
>   modprobe sony-laptop debug=1

Attached, dmesg.txt, only of the loading of the module with debug=1

> also press some of non-working Fn keys and see if they show up in the
> kernel log.

Nothing showed up, neither in kernel log, nor in acpi_listen

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SLIGO (n.)
An unnamed and exotic sexual act which people like to believe that
famous films stars get up to in private. 'To commit sligo.'
			--- Douglas Adams, The Meaning of Liff

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

[ 1995.353630] sony-laptop: Sony Programmable IO Control Driver v0.6.
[ 1995.353682] sony-laptop: detected Type3 model
[ 1995.353686] sony-laptop: Evaluating _STA
[ 1995.353729] sony-laptop: Device enabled
[ 1995.353733] sony-laptop: Evaluating _PRS
[ 1995.353948] sony-laptop: IO1 at 0xc000 (0x20)
[ 1995.353954] sony-laptop: IO1 at 0xc800 (0x20)
[ 1995.353959] sony-laptop: IO1 at 0xd000 (0x20)
[ 1995.353964] sony-laptop: IO1 at 0xd800 (0x20)
[ 1995.355791] PM: Adding info for No Bus:input11
[ 1995.355858] input: Sony Vaio Keys as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:0f/SNY6001:00/input/input11
[ 1995.392043] PM: Adding info for No Bus:event7
[ 1995.392076] PM: Adding info for No Bus:input12
[ 1995.392091] input: Sony Vaio Jogdial as /devices/virtual/input/input12
[ 1995.404076] PM: Adding info for No Bus:mouse2
[ 1995.420081] PM: Adding info for No Bus:event8
[ 1995.420108] PM: Adding info for No Bus:sonypi
[ 1995.420113] sony-laptop: device allocated minor is 60
[ 1995.420119] sony-laptop: I/O port1: 0xc000 (0xc000) + 0x20
[ 1995.420133] sony-laptop: IRQ: 6 - triggering: 1 - polarity: 0 - shr: 0
[ 1995.420135] sony-laptop: Evaluating _SRS
[ 1995.423149] sony-laptop: sony_pic_call1(0x82): 0xff0a
[ 1995.424010] sony-laptop: event ([ff] [04]) at port 0xc000(+0x12)
[ 1995.424082] sony-laptop: sony_pic_call2(0x81 - 0xff): 0x00ff
[ 1995.425031] sony-laptop: event ([00] [04]) at port 0xc000(+0x12)
[ 1995.425034] sony-laptop: sony_pic_call1(0x82): 0x000a
[ 1995.425069] PM: Adding info for platform:sony-laptop
[ 1995.425126] sony-laptop: Sony Notebook Control Driver v0.6.
[ 1995.425128] sony-laptop: event ([ff] [04]) at port 0xc000(+0x12)
[ 1995.425132] sony-laptop: method: name: _INI, args 0
[ 1995.425133] sony-laptop: method: name: PWAK, args 0
[ 1995.425135] sony-laptop: method: name: ECON, args 1
[ 1995.425137] sony-laptop: method: name: GBRT, args 0
[ 1995.425139] sony-laptop: method: name: SBRT, args 1
[ 1995.425140] sony-laptop: method: name: EAWK, args 1
[ 1995.425142] sony-laptop: method: name: SN00, args 1
[ 1995.425144] sony-laptop: method: name: SN01, args 0
[ 1995.425145] sony-laptop: method: name: SN02, args 1
[ 1995.425147] sony-laptop: method: name: SN03, args 1
[ 1995.425148] sony-laptop: method: name: SN04, args 0
[ 1995.425150] sony-laptop: method: name: SN05, args 1
[ 1995.425152] sony-laptop: method: name: SN06, args 1
[ 1995.425153] sony-laptop: method: name: SN07, args 1
[ 1995.425155] sony-laptop: method: name: SNIN, args 0
[ 1995.425157] sony-laptop: method: name: SNCF, args 2
[ 1995.425158] sony-laptop: method: name: SNNE, args 1
[ 1995.425160] sony-laptop: method: name: F100, args 0
[ 1995.425162] sony-laptop: method: name: F113, args 0
[ 1995.425163] sony-laptop: method: name: F101, args 0
[ 1995.425165] sony-laptop: method: name: F105, args 0
[ 1995.425167] sony-laptop: method: name: F114, args 0
[ 1995.425168] sony-laptop: method: name: F115, args 0
[ 1995.425170] sony-laptop: method: name: F11D, args 0
[ 1995.425172] sony-laptop: method: name: GPID, args 0
[ 1995.425173] sony-laptop: method: name: F119, args 0
[ 1995.425175] sony-laptop: method: name: F121, args 0
[ 1995.425177] sony-laptop: method: name: F122, args 0
[ 1995.425178] sony-laptop: method: name: F124, args 0
[ 1995.425180] sony-laptop: method: name: F125, args 0
[ 1995.425182] sony-laptop: method: name: F126, args 0
[ 1995.425184] sony-laptop: method: name: F128, args 0
[ 1995.425185] sony-laptop: method: name: HSC0, args 0
[ 1995.425187] sony-laptop: method: name: HSC1, args 0
[ 1995.425189] sony-laptop: method: name: HSC2, args 0
[ 1995.425191] sony-laptop: method: name: HSC3, args 1
[ 1995.425192] sony-laptop: method: name: HSC4, args 1
[ 1995.425194] sony-laptop: method: name: HOMP, args 0
[ 1995.425196] sony-laptop: Invoking _INI
[ 1995.431671] sony-laptop: brightness ignored, must be controlled by ACPI video driver
[ 1995.431675] sony-laptop: detected Sony Vaio Z Series
[ 1995.449394] sony-laptop: Found PID getter: GPID

--5mCyUwZo2JvN/JJP--
