From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Debugging spurious wakeup
Date: Fri, 15 May 2015 10:49:08 +0200
Message-ID: <5555B304.4050205@linaro.org>
References: <20150513065825.GA10680@sottospazio.it> <5555A64D.6060200@linaro.org> <20150515083528.GA15215@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36527 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbbEOItL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 04:49:11 -0400
Received: by wizk4 with SMTP id k4so277488565wiz.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2015 01:49:10 -0700 (PDT)
In-Reply-To: <20150515083528.GA15215@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: linux-acpi@vger.kernel.org

On 05/15/2015 10:35 AM, Gianluca Anzolin wrote:
> On Fri, May 15, 2015 at 09:54:53AM +0200, Daniel Lezcano wrote:
>>
>> Hi Gianluca,
>>
>> do yo have the option "Remain off after power failure" in the BIOS ?
>>
>> Does the issue occur if you set this option ?
>
> Hi,
>
> The BIOS option "Restore AC Power Loss" is set to "Power Off".
>
> The other options are "Last State" and "Power On". I could change it =
to "Last
> State", I can do it later if needed since I've no physical access to =
the PC
> right now.
>
> However I'm beginning to think it's the NIC driver, even though it oc=
curs also
> with no cable attached, I sent a while ago an email with my findings.

I suggest you Cc the linux-netdev@, too. If this is related to the=20
driver or the NIC itself, someone will probably have an answer for this=
=20
issue.


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
