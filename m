From: giggzounet <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Tue, 22 Jan 2008 23:02:03 +0100
Message-ID: <479667DB.3020207@gmail.com>
References: <fmaaj5$jsl$1@ger.gmane.org>	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>	 <20080112124619.GA15578@srcf.ucam.org>  <fmae78$toa$1@ger.gmane.org> <1200980867.7424.4.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:63819 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbYAVWEU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 17:04:20 -0500
Received: by ik-out-1112.google.com with SMTP id c28so146828ika.5
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jan 2008 14:04:16 -0800 (PST)
In-Reply-To: <1200980867.7424.4.camel@acpi-sony.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Zhang Rui a =C3=A9crit :
> On Sat, 2008-01-12 at 14:08 +0100, giggz wrote:
>> Matthew Garrett a =C3=A9crit :
>>> On Sat, Jan 12, 2008 at 01:33:38PM +0100, giggz wrote:
>>>
>>>> What is the acpi video module ?
>>> If you have /proc/acpi/video, it's loaded.
>>>
>>>> I don't have any /var/log/acpid.log
>>> In that case, try catting /proc/acpi/event and hit the button.
>>>
>> When I try cat /proc/acpi/event under root I can't access to this fi=
le.
>>
>> 13:54 giggz@debian /proc/acpi/video/VGA % ll /proc/acpi/event
>> -r-------- 1 root root 0 2008-01-12 09:45 /proc/acpi/event
>>
>> 14:00 root@debian /proc/acpi # LC_ALL=3DC cat /proc/acpi/event
>> cat: /proc/acpi/event: Device or resource busy
>> zsh: exit 1     LC_ALL=3DC cat /proc/acpi/event
>>
>> How can I access to thsi file ?
> Please kill acpid first.

Ok, done.
When I stop acpid through invoke-rc.d, I can read the /proc/acpi/event
file. But when I press fn+f3 I just read nothing...nothing appears.

What can I do ? Is it useful to report a bug on kernel without any
informations ?

Thanks for your attention
Guillaume

> make sure acpi video driver is loaded. (/proc/acpi/video exists)
> cat /proc/acpi/event
> and press fn+f3 to see what happens.
>=20
> you can file a bug report at:
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> and attach the test result here.
>=20
> Thanks,
> Rui
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
