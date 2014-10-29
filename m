From: Alan Pater <alan.pater@gmail.com>
Subject: Re: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Wed, 29 Oct 2014 14:43:01 -0500
Message-ID: <CAN4ACkbCuxwaRuX0T1VQatF3g=8UikgS_ECfRMbeNgvbYNGxEQ@mail.gmail.com>
References: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
 <CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
 <CAN4ACka7uCuwM8AiB-r_zodjb1xtsr7r_fw0+nKtqtP-sBQx2w@mail.gmail.com>
 <CAGdLNWHY6M8TB7ekQEW3=1JUAogLN6zbmsmSXqHYXtRVUUXf7w@mail.gmail.com> <CAGdLNWEr0SLF596EDeb6Nr6g7P6ZbLOt5fpudLmvmZqezo9mEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33688 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaJ2TnX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2014 15:43:23 -0400
Received: by mail-la0-f52.google.com with SMTP id pv20so1377181lab.11
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2014 12:43:22 -0700 (PDT)
In-Reply-To: <CAGdLNWEr0SLF596EDeb6Nr6g7P6ZbLOt5fpudLmvmZqezo9mEw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The modified module did not make any difference.

~$ dmesg | grep toshiba_acpi
[   15.974235] toshiba_acpi: module verification failed: signature
and/or  required key missing - tainting kernel
[   15.974808] toshiba_acpi: Toshiba Laptop ACPI Extras version 0.20
[   15.974839] toshiba_acpi: Using INFO method for hotkeys
[   16.196131] toshiba_acpi: Illumination device not available
[   16.200080] toshiba_acpi: Keyboard illumination not available
[   72.106437] toshiba_acpi: Got hotkey 1ff
[   72.485125] toshiba_acpi: Got hotkey 141
[   72.564089] toshiba_acpi: Got hotkey 1c1
[   72.863130] toshiba_acpi: Got hotkey 141
[   72.962669] toshiba_acpi: Got hotkey 1c1
[   73.660179] toshiba_acpi: Got hotkey 141
[   73.780039] toshiba_acpi: Got hotkey 1c1
[   74.916406] toshiba_acpi: Got hotkey 141
[   75.036200] toshiba_acpi: Got hotkey 1c1
[   75.354115] toshiba_acpi: Got hotkey 100
[  725.333981] toshiba_acpi: Got hotkey 1ff
[  725.595286] toshiba_acpi: Got hotkey 141
[  725.695038] toshiba_acpi: Got hotkey 1c1
[  726.036854] toshiba_acpi: Got hotkey 141
[  726.136572] toshiba_acpi: Got hotkey 1c1
[  726.518754] toshiba_acpi: Got hotkey 141
[  726.639480] toshiba_acpi: Got hotkey 1c1
[  727.221559] toshiba_acpi: Got hotkey 100
[ 1532.028295] toshiba_acpi: Got hotkey 1ff
[ 1532.851650] toshiba_acpi: Got hotkey 140
[ 1532.953734] toshiba_acpi: Got hotkey 1c0
[ 1533.092683] toshiba_acpi: Got hotkey 140
[ 1533.132363] toshiba_acpi: Got hotkey 1c0
[ 1533.253140] toshiba_acpi: Got hotkey 140
[ 1533.313907] toshiba_acpi: Got hotkey 1c0
[ 1533.433710] toshiba_acpi: Got hotkey 140
[ 1533.494675] toshiba_acpi: Got hotkey 1c0
[ 1533.614536] toshiba_acpi: Got hotkey 140
[ 1533.674901] toshiba_acpi: Got hotkey 1c0
[ 1533.855708] toshiba_acpi: Got hotkey 140
[ 1533.916778] toshiba_acpi: Got hotkey 1c0
[ 1534.297382] toshiba_acpi: Got hotkey 140
[ 1534.397266] toshiba_acpi: Got hotkey 1c0
[ 1535.160886] toshiba_acpi: Got hotkey 141
[ 1535.261978] toshiba_acpi: Got hotkey 1c1
[ 1535.401869] toshiba_acpi: Got hotkey 141
[ 1535.483247] toshiba_acpi: Got hotkey 1c1
[ 1535.622713] toshiba_acpi: Got hotkey 141
[ 1535.683797] toshiba_acpi: Got hotkey 1c1
[ 1535.803424] toshiba_acpi: Got hotkey 141
[ 1535.883102] toshiba_acpi: Got hotkey 1c1
[ 1536.004233] toshiba_acpi: Got hotkey 141
[ 1536.085126] toshiba_acpi: Got hotkey 1c1
[ 1536.405763] toshiba_acpi: Got hotkey 141
[ 1536.527208] toshiba_acpi: Got hotkey 1c1
[ 1536.787229] toshiba_acpi: Got hotkey 141
[ 1536.907873] toshiba_acpi: Got hotkey 1c1
[ 1537.148843] toshiba_acpi: Got hotkey 141
[ 1537.270166] toshiba_acpi: Got hotkey 1c1
[ 1538.032373] toshiba_acpi: Got hotkey 100
[ 1538.830857] toshiba_acpi: Got hotkey 1ff
[ 1539.111732] toshiba_acpi: Got hotkey 140
[ 1539.193322] toshiba_acpi: Got hotkey 1c0
[ 1540.095516] toshiba_acpi: Got hotkey 140
[ 1540.217071] toshiba_acpi: Got hotkey 1c0
[ 1540.798195] toshiba_acpi: Got hotkey 140
[ 1540.898581] toshiba_acpi: Got hotkey 1c0
[ 1541.440809] toshiba_acpi: Got hotkey 100
[ 1548.512637] toshiba_acpi: Got hotkey e00
[ 1548.512669] toshiba_acpi: Unknown key e00
[ 1563.322557] toshiba_acpi: Got hotkey 1ff
[ 1563.921601] toshiba_acpi: Got hotkey 140
[ 1564.020985] toshiba_acpi: Got hotkey 1c0
[ 1564.520534] toshiba_acpi: Got hotkey 140
[ 1564.640430] toshiba_acpi: Got hotkey 1c0
[ 1564.780130] toshiba_acpi: Got hotkey 140
[ 1564.859874] toshiba_acpi: Got hotkey 1c0
[ 1564.979960] toshiba_acpi: Got hotkey 140
[ 1565.039127] toshiba_acpi: Got hotkey 1c0
[ 1565.138875] toshiba_acpi: Got hotkey 140
[ 1565.239265] toshiba_acpi: Got hotkey 1c0
[ 1565.918103] toshiba_acpi: Got hotkey 141
[ 1566.037873] toshiba_acpi: Got hotkey 1c1
[ 1566.136989] toshiba_acpi: Got hotkey 141
[ 1566.237915] toshiba_acpi: Got hotkey 1c1
[ 1566.337554] toshiba_acpi: Got hotkey 141
[ 1566.417600] toshiba_acpi: Got hotkey 1c1
[ 1566.497223] toshiba_acpi: Got hotkey 141
[ 1566.597385] toshiba_acpi: Got hotkey 1c1
[ 1566.677053] toshiba_acpi: Got hotkey 141
[ 1566.757165] toshiba_acpi: Got hotkey 1c1
[ 1566.856564] toshiba_acpi: Got hotkey 141
[ 1566.936449] toshiba_acpi: Got hotkey 1c1
[ 1567.016564] toshiba_acpi: Got hotkey 141
[ 1567.097151] toshiba_acpi: Got hotkey 1c1
[ 1567.216246] toshiba_acpi: Got hotkey 141
[ 1567.316287] toshiba_acpi: Got hotkey 1c1
[ 1567.735848] toshiba_acpi: Got hotkey 140
[ 1567.815149] toshiba_acpi: Got hotkey 1c0
[ 1567.914885] toshiba_acpi: Got hotkey 140
[ 1567.995160] toshiba_acpi: Got hotkey 1c0
[ 1568.114652] toshiba_acpi: Got hotkey 140
[ 1568.174968] toshiba_acpi: Got hotkey 1c0
[ 1568.294403] toshiba_acpi: Got hotkey 140
[ 1568.354433] toshiba_acpi: Got hotkey 1c0
[ 1568.454532] toshiba_acpi: Got hotkey 140
[ 1568.534092] toshiba_acpi: Got hotkey 1c0
[ 1568.793627] toshiba_acpi: Got hotkey 100

On Mon, Oct 27, 2014 at 7:15 PM, Azael Avalos <coproscefalo@gmail.com> wrote:
> @Alan Pater
>
> http://pastebin.com/k3DpPaPJ <- toshiba_acpi
> http://pastebin.com/Jv0YWma3 <- Makefile
>
> Please get the two files from the pastebin links and simply do:
>
> make
> sudo make install
> sudo make load
>
> Once the modified module is installed and loaded, try to change
> the brightness (via hotkeys and /sys), suspend, resume, try
> changing the brightness (again, via hotkeys and /sys) and
> provide me the output of "dmesg | grep toshiba_acpi"
>
>
> Cheers
> Azael
>
>
> 2014-10-27 11:02 GMT-06:00 Azael Avalos <coproscefalo@gmail.com>:
>> Hi there,
>>
>>
>> After reading (quite a lot of) posts linked on the bug reports,
>> I'll try to make a patch for you to test later today when I'm
>> back home. Which, let's hope it solves your issues.
>>
>>
>> Cheers
>> Azael
>>
>>
>> 2014-10-27 9:46 GMT-06:00 Alan Pater <alan.pater@gmail.com>:
>>> No, I need to use /sys/class/backlight/intel_backlight/brightness to
>>> control the backlight after resume.
>>>
>>> On Mon, Oct 27, 2014 at 10:39 AM, Azael Avalos <coproscefalo@gmail.com> wrote:
>>>>
>>>> So, the backlight device (/sys/class/backlight/toshiba/brightness) can still
>>>> be used to change brightness, but not via the hotkeys on resume?
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> -- El mundo apesta y vosotros apestais tambien --
>
>
>
> --
> -- El mundo apesta y vosotros apestais tambien --
