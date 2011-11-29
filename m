From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Shutdown issues with Gigabyte A75M board: always reboots
Date: Mon, 28 Nov 2011 17:43:45 -0800
Message-ID: <CAErSpo4ut00Ew7ZhOazmhBGXYMnNrs0JU4HwT5mjOSrq8-JPDg@mail.gmail.com>
References: <1322497836.4462.5.camel@alucardo.nm.mcbf.net> <1322498547.4462.7.camel@alucardo.nm.mcbf.net>
 <1322529738.2648.6.camel@alucardo.nm.mcbf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1K2BoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Nov 2011 20:44:10 -0500
Received: by eaak14 with SMTP id k14so2469908eaa.19
        for <linux-acpi@vger.kernel.org>; Mon, 28 Nov 2011 17:44:09 -0800 (PST)
In-Reply-To: <1322529738.2648.6.camel@alucardo.nm.mcbf.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Mohr <damailings@mcbf.net>
Cc: linux-acpi@vger.kernel.org

On Mon, Nov 28, 2011 at 5:22 PM, David Mohr <damailings@mcbf.net> wrote=
:
> On Mon, 2011-11-28 at 09:42 -0700, David Mohr wrote:
>> Hi folks,
>>
>> I have an AMD CPU on a Gigabyte A75M board[0]. When I shut the compu=
ter
>> off, either through gdm, or with 'shutdown -h now' on the cli, the
>> computer turns off and then immediately on again. I would say there =
is a
>> tiny delay in between which distinguishes it from a reboot.
>>
>> The same thing happens when I go to standby - the computer immediate=
ly
>> wakes up.
>>
>> This is on 3.2-rc2. I have some infos attached to this email. Any he=
lp
>> would be appreciated since this annoying problem has been with me fo=
r a
>> while :-).
>>
>> Thanks,
>> ~David
>>
>> P.S. If there is a better place to post this issue, please let me kn=
ow.
>>
>> [0]: http://www.gigabyte.us/products/product-page.aspx?pid=3D3928&#s=
p
>
> And I just realized my original email did not go through because the
> attachment was too large.
>
> Another attempt is attached. It contains acpidump =A0dmidecode =A0ker=
n.log =A0lspci
> uname . I hope that's useful enough to get a response ;-). I have the=
 sys
> directory tarred up as well, please download it at [1].
>
> Thanks,
> ~David
>
> [1]: http://dsp.mcbf.net/acpi-sys.tar.bz2
>

Is this a regression?  If so, what's the most recent kernel that did
not have this bug?  If you're ambitious, you could bisect it and
identify the change that caused the problem.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
