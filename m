From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Thu, 25 Sep 2014 11:23:27 +0900
Message-ID: <54237C9F.4030307@jp.fujitsu.com>
References: <54095EE7.3080302@jp.fujitsu.com> <2311044.Mgki24rmc5@vostro.rjw.lan> <541BC4F7.9020602@jp.fujitsu.com> <2640711.2x3ddJGmzs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57792 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbaIYCY1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Sep 2014 22:24:27 -0400
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B137F3EE168
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2014 11:24:25 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id BFCBBAC07B8
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2014 11:24:24 +0900 (JST)
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 76AA01DB8038
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2014 11:24:24 +0900 (JST)
In-Reply-To: <2640711.2x3ddJGmzs@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: joeyli <jlee@suse.com>, rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org

(2014/09/21 9:01), Rafael J. Wysocki wrote:
> On Friday, September 19, 2014 02:53:59 PM Yasuaki Ishimatsu wrote:
>> Hi Rafael,
>>
>>>>>> So feel free to  add "Tested-by : Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>"
>>>>>> to the patch.
>>>>>
>>>>> Thanks!
>>>>>
>>>>
>>>> I just tested your new patch, it works on my side as Yasuaki's patch.
>>>>
>>>> Tested-by: Lee, Chun-Yi <jlee@suse.com>
>>
>> Hi Rafael,
>>
>> When will you merge the patch into your tree?
>> I would like you to do it soon.
>
> I'm going to push it for 3.17-rc7 next week.

Thank you for your cooperation.

I confirmed that the patch is merged into bleeding-dege now.

Thanks,
Yasuaki Ishimatsu

>
> Rafael
>


