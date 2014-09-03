From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: Question of " 202317a : ACPI / scan: Add acpi_device objects
 for all device nodes in the namespace" commit
Date: Wed, 3 Sep 2014 11:14:02 +0900
Message-ID: <5406796A.30303@jp.fujitsu.com>
References: <54052305.9060308@jp.fujitsu.com> <1936799.NYvsvtc9DH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60085 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaICCPP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 22:15:15 -0400
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E42FB3EE0C7
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2014 11:15:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id DC3A6AC06C4
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2014 11:15:12 +0900 (JST)
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 74B281DB8046
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2014 11:15:12 +0900 (JST)
In-Reply-To: <1936799.NYvsvtc9DH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org

Hi Rafael,

Thank you for your explanation.

(2014/09/03 6:29), Rafael J. Wysocki wrote:
> On Tuesday, September 02, 2014 10:53:09 AM Yasuaki Ishimatsu wrote:
>> Hi Rafael,
>
> Hi,
>
>> Why is _SUN method decoded and the sun sysfs created even if _STA reports
>> that the device is not present and not functional?
>
> sun sysfs is created for stuff that has _SUN.  It should be empty for devices
> that aren't present, though, apparently.
>
>> By this commit, "202317a : ACPI / scan: Add acpi_device objects for all
>> device nodes in the namespace", all device nodes in the namespace are
>> shown under /sys/bus/acpi/devices direcotry even if the devices are not
>> present and not functional.
>>
>> But ACPI specification says against return value information of _STA:
>> A device can only decode its hardware resources if both bits 0 and 1 are set.
>> If the device is not present (bit 0 cleared) or not enabled (bit 1 cleared),
>> then the device must not decode its resources.
>
> But _SUN is not about hardware resources, is it?

I think so. But ACPI spec does not define what the hardware resources are.
So someone says _SUN is about hardware resrouces.

>
>> In my understanding, when the device is not present and not functional,
>> _SUN of the device must not be decoded. Is my understanding worng?
>
> If my understanding of the _INI section of the spec is correct, you have a
> point, but the dependency is rather indirect as far as I can say.  If the
> device is not present, we are not supposed to execute _INI for it and _SUN
> can only be executed after _INI.

I know the spec. According to the _INI section of the spec, it says:

"If the _STA method indicates that the device is not present and is not
functional, OSPM will not run the _INI and will not examine the children
of the device for _INI methods."

In my understanding, if a device has both _SUN and _INI method, and _STA
method indicates that the deviceis not present and is not functional,
_SUN method cannot be executed.

If a device has _SUN method and does not have _INI method, and _STA
method indicates that the deviceis not present and is not functional,
can we execute _SUN method?

>
>> In our box, when the device is not present and not functional, _SUN method
>> of the device returns wrong value. And the values is cached to
>> acpi_device->pnp.sun. So when hot adding the device and changing _SUN value,
>> the information is not reflected to acpi_device->pnp.sun.
>
> I see.
>
>> I think the issue is solved by not caching sun value. But at first, I want
>> to know whether current implementation is correct or not.
>
> No, it isn't, but there are two ways to fix it.
>
> A short term fix would be to evaluate _STA and print an empty string in
> acpi_device_sun_show() if we don't like the return value.  If we do like it,
> evaluate _SUN and print the result.

I will create a shot term fix soon.

Thanks,
Yasuaki Ishimatsu

>
> A long term fix would require us to track the execution of _INI and decide
> what to print on this basis (and probably avoid to execute some other methods
> too if _INI has not been executed).  I'll try to do something along these lines,
> but I can't promise any particular time frame, sorry about that.
>
> KR,
> Rafael
>
>


