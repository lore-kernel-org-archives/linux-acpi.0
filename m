From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Debugging spurious wakeup
Date: Tue, 23 Jun 2015 10:32:16 +0200
Message-ID: <55891990.2090901@linaro.org>
References: <20150513065825.GA10680@sottospazio.it> <20150620215441.GA32242@rhlx01.hs-esslingen.de> <20150622194855.GA16269@sottospazio.it> <20150623063612.GA27891@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36470 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbbFWIcO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2015 04:32:14 -0400
Received: by wguu7 with SMTP id u7so2834622wgu.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2015 01:32:12 -0700 (PDT)
In-Reply-To: <20150623063612.GA27891@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>, Andreas Mohr <andi@lisas.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On 06/23/2015 08:36 AM, Gianluca Anzolin wrote:
> Hello,
>
> Yesterday I took the time to read the document about GPE / PME handli=
ng and I
> compared the wakeup code of my BIOS with the examples in that documen=
t.
>
> I noticed that some vital wakeup code was executed only when a variab=
le (PMSX)
> was set. That variable was set by a global NPME() method and that met=
hod was
> called by _OSC().
>
> And in my logs I had this message:
>
> giu 19 18:31:06 zanac kernel: acpi PNP0A08:00: _OSC: OS supports
> [ExtendedConfig ASPM ClockPM Segments MSI]
> giu 19 18:31:06 zanac kernel: \_SB_.PCI0:_OSC invalid UUID
> giu 19 18:31:06 zanac kernel: _OSC request data:1 1f 0
> giu 19 18:31:06 zanac kernel: acpi PNP0A08:00: _OSC failed (AE_ERROR)=
;
> disabling ASPM
>
> A googled a bit and found the following bugzilla entry, that applies =
to my
> situation perfectly: the NEXP variable isn't set anywhere, yet in Win=
dows it
> is.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D36932
>
> So I disassembled the DSDT, I removed any test involving the NEXP var=
iable in
> the code, I recompiled and replaced the table with GRUB.
>
> And then the _OSC() invocation completed successfully, giving me a wo=
rking WOL
> without spontaneous wakeups!

Great work and thanks for sharing you results !

> What puzzles me is that the location of the NEXP variables is marked =
as ACPI
> NVS and the kernel never touches that region of memory. What is Windo=
ws doing
> differently that makes it work?

Perhaps it is not Windows itself but the motherboard driver fixing a=20
known bug ?

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
