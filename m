From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Debugging spurious wakeup
Date: Fri, 15 May 2015 09:54:53 +0200
Message-ID: <5555A64D.6060200@linaro.org>
References: <20150513065825.GA10680@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35539 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771AbbEOHy5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 03:54:57 -0400
Received: by wgnd10 with SMTP id d10so101248543wgn.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2015 00:54:56 -0700 (PDT)
In-Reply-To: <20150513065825.GA10680@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>, linux-acpi@vger.kernel.org


Hi Gianluca,

do yo have the option "Remain off after power failure" in the BIOS ?

Does the issue occur if you set this option ?




On 05/13/2015 08:58 AM, Gianluca Anzolin wrote:
> Hello,
>
> I have a curious problem with my system: whenever I wake up the PC wi=
th a WOL
> magic packet and then power it off the systems comes back to life aft=
er a
> couple of seconds, by itself.
>
> I can reproduce the problem 100% of the times.
>
> I've been having this problems for years. I remember this same issue =
occurred
> also with my previous computer, with a different mainboard. My curren=
t system
> has an ASUS P8B-WS mb with a Xeon 1275v2 CPU.
>
> I've ruled out in the time many factors: traffic on the net (by disco=
nnecting
> the cable), RTC alarms (by disabling them)... long story short: I'm s=
tuck.
>
> While I'm not the only one with this issue (see[1]), some people have=
 reported
> mixed success by blacklisting some components (xhci-pci) or by settin=
g
> unrelated BIOS options. Unfortunately these workarounds never worked =
for me.
>
> So I'm here to ask if there is a way to get the source/cause of the l=
ast wakeup
> by setting some ACPI debug option. This way I could at least pinpoint=
 the
> device/interface that caused the spontaneous wakeup and then debug fu=
rther or
> at least disable it.
>
> I've tried to enable the ACPI hardware-related messages with the kern=
el
> arguments: acpi.debug_layer=3D0x2 acpi.debug_level=3D0xffffffff
>
> Unfortunately I can't see the information I'm looking for in the resu=
lting
> output. Should I enable some other debug_layer? Could anybody point m=
e in the
> right direction?
>
> Thank you and best regards,
>
> Gianluca
>
> [1] https://bbs.archlinux.org/viewtopic.php?id=3D173648
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


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
