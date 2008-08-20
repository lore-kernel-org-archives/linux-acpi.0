From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: Re: AE_ERROR, ACPI thermal trip point state changed
Date: Wed, 20 Aug 2008 11:08:46 +0200
Message-ID: <48ABDF1E.3010101@freemail.hu>
References: <47B328AA.1000800@freemail.hu> <47B3F147.7000704@freemail.hu>	 <47CF96E2.9020302@freemail.hu>	 <1204757373.10256.179.camel@acpi-hp-zz.sh.intel.com>	 <823A93EED437D048963A3697DB0E35DE0129BB78@pdsmsx414.ccr.corp.intel.com>	 <47D0E694.5050102@freemail.hu>	 <1204874686.10256.185.camel@acpi-hp-zz.sh.intel.com>	 <47D24341.5070908@freemail.hu> <1205113940.10256.191.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail00a.mail.t-online.hu ([84.2.40.5]:63040 "EHLO
	mail00a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbYHTJQn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2008 05:16:43 -0400
In-Reply-To: <1205113940.10256.191.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Zhang, Rui wrote:
> On Sat, 2008-03-08 at 15:41 +0800, N=C3=A9meth M=C3=A1rton wrote:
>> Zhang, Rui wrote:
>>> On Fri, 2008-03-07 at 14:54 +0800, N=C3=A9meth M=C3=A1rton wrote:
>>>> Hi,
>>>>
>>>> I downloaded pmtools from
>>>>
>> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtool=
s-20071116.tar.bz2 and
>>>> compiled: it created exactly the same result what my currently
>>>> installed acpidump Debian
>>>> package version 20071116-1. I think it is useless to send the same
>> log
>>>> again.
>>>>
>>>> After I boot the "Please send acpidump to
>> linux-acpi@vger.kernel.org"
>>>> message is already
>>>> there. So when I first get the prompt I checked for this message i=
n
>>>> dmesg and executed
>>>> the given command. Here is my result:
>>>>
>>>> # cat /proc/acpi/thermal_zone/*/*
>>>> 0 - Active; 1 - Passive
>>>> <polling disabled>
>>>> state:                   ok
>>>> temperature:             42 C
>>>> critical (S5):           155 C
>>>> passive:                 84 C: tc1=3D2 tc2=3D5 tsp=3D0 devices=3DC=
PU0
>>>> active[0]:               70 C: devices=3D
>>>> # ls /proc/acpi/thermal_zone/*/*
>>>> /proc/acpi/thermal_zone/THRM/cooling_mode
>>>> /proc/acpi/thermal_zone/THRM/polling_frequency
>>>> /proc/acpi/thermal_zone/THRM/state
>>>> /proc/acpi/thermal_zone/THRM/temperature
>>>> /proc/acpi/thermal_zone/THRM/trip_points
>>>>
>>>> Maybe this is related to
>>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D8544 ?
>>>>
>>> Hi, N=C3=A9meth,
>>>
>>> Please ignore the debug patch I sent and try this one.
>> I created both the dmesg logs:
>>
>> 1. Clevo-D410J-patch-debug-thermal2.txt: the patch-debug-thermal was
>> only
>> applied, (and added a missing "\n").
>>
>> 2. Clevo-D410J-thermal-fix.txt: the thermal-fix patch was also
>> applied.
>> In this case the AE_ERROR message is not there any more on Clevo D41=
0J
>> laptop.
>>
> Thanks for your help in debugging this.
> We will get the "thermal-fix" patch upstream soon.

As of 2.6.27-rc3 the patch is still not included in the mainstream. I
hope that this patch was not forgotten completely.

	M=C3=A1rton N=C3=A9meth

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
