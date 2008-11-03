From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH 0/7] sony-laptop for acpi-test
Date: Mon, 3 Nov 2008 14:02:13 +0100
Message-ID: <20081103130213.GG1660@gamma.logic.tuwien.ac.at>
References: <1225705280-12775-1-git-send-email-malattia@linux.it> <20081103111721.GA31688@gamma.logic.tuwien.ac.at> <20081103124842.GA6865@inferi.kami.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:41926 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbYKCNCP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 08:02:15 -0500
Content-Disposition: inline
In-Reply-To: <20081103124842.GA6865@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mattia,

On Mo, 03 Nov 2008, Mattia Dongili wrote:
> > I tried your patches on top of 2.6.28-rc3 and the tests showed:
> > - backlight is working via sys interface and xbacklight
> > - hardkeys are still not working
> 
> what do you mean? some Fn backlight button (F5/F6 usually) or a separate
> button?

F5 and F6 does not work. No message of events in the kernel log.

> Can you see if the kernel driver reports the events (pressing releasing
> keys) but loading it with debug=1 ?

Nothing.

> > - wifipower, wwanpower, bluetoothpower sys files do not work
> 
> can you send the kernel output after loading sony-laptop with debug=1
> and echoing some value to those files?

I did load with debug=1 and
# pwd
/sys/devices/platform/sony-laptop
# cat wifipower 
0
# echo 1 >wifipower 
# cat wifipower 
1
# cat wwanpower 
0
# echo 1 >wwanpower 
# cat wwanpower 
1
# cat bluetoothpower 
255
# echo 1 > bluetoothpower 
# cat bluetoothpower 
1


Output of dmesg starting from loading the sony-laptop module is
attached.

If you need more tests just let me know, I can patch/hack things into
the sony-laptop if you need it.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
OUNDLE (vb.)
To walk along leaning sideways, with one arm hanging limp and dragging
one leg behind the other. Most commonly used by actors in amateur
production of Richard III, or by people carrying a heavy suitcase in
one hand.
			--- Douglas Adams, The Meaning of Liff

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

[ 6610.638032] sony-laptop: Sony Programmable IO Control Driver v0.6.
[ 6610.638087] sony-laptop: detected Type3 model
[ 6610.638090] sony-laptop: Evaluating _STA
[ 6610.638107] sony-laptop: Device enabled
[ 6610.638111] sony-laptop: Evaluating _PRS
[ 6610.638331] sony-laptop: IO1 at 0xc000 (0x20)
[ 6610.638337] sony-laptop: IO1 at 0xc800 (0x20)
[ 6610.638342] sony-laptop: IO1 at 0xd000 (0x20)
[ 6610.638347] sony-laptop: IO1 at 0xd800 (0x20)
[ 6610.640305] PM: Adding info for No Bus:input11
[ 6610.640369] input: Sony Vaio Keys as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:0f/SNY6001:00/input/input11
[ 6610.684121] PM: Adding info for No Bus:event9
[ 6610.684194] PM: Adding info for No Bus:input12
[ 6610.684241] input: Sony Vaio Jogdial as /devices/virtual/input/input12
[ 6610.696037] PM: Adding info for No Bus:mouse2
[ 6610.716075] PM: Adding info for No Bus:event10
[ 6610.716102] PM: Adding info for No Bus:sonypi
[ 6610.716108] sony-laptop: device allocated minor is 60
[ 6610.716113] sony-laptop: I/O port1: 0xc000 (0xc000) + 0x20
[ 6610.716128] sony-laptop: IRQ: 6 - triggering: 1 - polarity: 0 - shr: 0
[ 6610.716130] sony-laptop: Evaluating _SRS
[ 6610.718939] sony-laptop: sony_pic_call1(0x82): 0xff0a
[ 6610.719868] sony-laptop: event ([ff] [ff]) at port 0xc000(+0x1d9)
[ 6610.720804] sony-laptop: sony_pic_call2(0x81 - 0xff): 0x00ff
[ 6610.720896] sony-laptop: sony_pic_call1(0x82): 0xff0a
[ 6610.720906] sony-laptop: event ([00] [ff]) at port 0xc000(+0x1d9)
[ 6610.720928] PM: Adding info for platform:sony-laptop
[ 6610.720985] sony-laptop: Sony Notebook Control Driver v0.6.
[ 6610.720987] sony-laptop: method: name: _INI, args 0
[ 6610.720989] sony-laptop: method: name: PWAK, args 0
[ 6610.720990] sony-laptop: method: name: ECON, args 1
[ 6610.720992] sony-laptop: method: name: GBRT, args 0
[ 6610.720993] sony-laptop: method: name: SBRT, args 1
[ 6610.720994] sony-laptop: method: name: EAWK, args 1
[ 6610.720996] sony-laptop: method: name: SN00, args 1
[ 6610.720997] sony-laptop: method: name: SN01, args 0
[ 6610.720998] sony-laptop: method: name: SN02, args 1
[ 6610.721000] sony-laptop: method: name: SN03, args 1
[ 6610.721001] sony-laptop: method: name: SN04, args 0
[ 6610.721002] sony-laptop: method: name: SN05, args 1
[ 6610.721004] sony-laptop: method: name: SN06, args 1
[ 6610.721005] sony-laptop: method: name: SN07, args 1
[ 6610.721006] sony-laptop: method: name: SNIN, args 0
[ 6610.721008] sony-laptop: method: name: SNCF, args 2
[ 6610.721009] sony-laptop: method: name: SNNE, args 1
[ 6610.721010] sony-laptop: method: name: F100, args 0
[ 6610.721011] sony-laptop: method: name: F113, args 0
[ 6610.721013] sony-laptop: method: name: F101, args 0
[ 6610.721014] sony-laptop: method: name: F105, args 0
[ 6610.721015] sony-laptop: method: name: F114, args 0
[ 6610.721017] sony-laptop: method: name: F115, args 0
[ 6610.721019] sony-laptop: method: name: F11D, args 0
[ 6610.721021] sony-laptop: method: name: GPID, args 0
[ 6610.721022] sony-laptop: method: name: F119, args 0
[ 6610.721024] sony-laptop: method: name: F121, args 0
[ 6610.721026] sony-laptop: method: name: F122, args 0
[ 6610.721027] sony-laptop: method: name: F124, args 0
[ 6610.721029] sony-laptop: method: name: F125, args 0
[ 6610.721031] sony-laptop: method: name: F126, args 0
[ 6610.721032] sony-laptop: method: name: F128, args 0
[ 6610.721034] sony-laptop: method: name: HSC0, args 0
[ 6610.721036] sony-laptop: method: name: HSC1, args 0
[ 6610.721038] sony-laptop: method: name: HSC2, args 0
[ 6610.721040] sony-laptop: method: name: HSC3, args 1
[ 6610.721041] sony-laptop: method: name: HSC4, args 1
[ 6610.721043] sony-laptop: method: name: HOMP, args 0
[ 6610.721046] sony-laptop: Invoking _INI
[ 6610.721843] sony-laptop: event ([ff] [ff]) at port 0xc000(+0x1d9)
[ 6610.727742] PM: Adding info for No Bus:sony
[ 6610.727811] sony-laptop: detected Sony Vaio Z Series
[ 6610.747166] sony-laptop: Found PID getter: GPID
[ 6679.162181] sony-laptop: sony_pic_call2(0x98 - 0xff): 0x00ff
[ 6679.163129] sony-laptop: sony_pic_call1(0x82): 0xff0a
[ 6679.163222] sony-laptop: event ([ff] [ff]) at port 0xc000(+0x1d9)
[ 6687.417252] sony-laptop: sony_pic_call2(0xb0 - 0x01): 0x00ff
[ 6687.417337] sony-laptop: sony_pic_call1(0x82): 0xff0a
[ 6687.418321] sony-laptop: event ([ff] [ff]) at port 0xc000(+0x1d9)
[ 6699.324272] sony-laptop: sony_pic_call2(0x96 - 0x01): 0x00ff
[ 6699.324357] sony-laptop: sony_pic_call1(0x82): 0xff0a
[ 6699.325340] sony-laptop: event ([ff] [ff]) at port 0xc000(+0x1d9)

--Yylu36WmvOXNoKYn--
