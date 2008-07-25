From: "Simon Depiets" <sdepiets@gmail.com>
Subject: Re : Re : Acer Aspire One (Intel Atom's Motherboard) CPU Temp & Fan Speed
Date: Fri, 25 Jul 2008 14:33:49 +0200
Message-ID: <f4897e880807250533i498019dby71877fb6bddcdb29@mail.gmail.com>
References: <f4897e880807240800n3c02c6bdw44c4827e098f61c2@mail.gmail.com>
	 <f4897e880807240932q33f3919et1d24cb8f98e8598e@mail.gmail.com>
	 <200807242302.04782.carlos@strangeworlds.co.uk>
	 <f4897e880807241628j4d557e91w1955044d43451247@mail.gmail.com>
	 <1216949919.1831.38.camel@yakui_zhao.sh.intel.com>
	 <f4897e880807250051y6367852fkcdc606809c79c661@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:38170 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbYGYMdw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jul 2008 08:33:52 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2351178fkq.5
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jul 2008 05:33:50 -0700 (PDT)
In-Reply-To: <f4897e880807250051y6367852fkcdc606809c79c661@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: acpi@linux.intel.com, linux-acpi@vger.kernel.org

2008/7/25, Simon Depiets <sdepiets@gmail.com>:
> 2008/7/25, Zhao Yakui <yakui.zhao@intel.com>:
>> On Fri, 2008-07-25 at 01:28 +0200, Simon Depiets wrote:
>>> 2008/7/25 Carlos Corbacho <carlos@strangeworlds.co.uk>:
>>> > We'll also need the output of acpidump.
>>> >
>>> > -Carlos
>>> Hi,
>>> I've uploaded it here
>>> http://www.mmo-tools.com/acpi/acpidump.txt
>> >From the attached acpidump it seems that there is no defintion of
>> thermal_zone, FAN device or power resource device.
>> So we can't get any info about the temperature of thermal_zone or FAN
>> speed through ACPI interface.
>> Will you please check whether there is available bios to upgrade?
> no there isn't
>> Will you please check whether the CPU temperature can be obtained by the
>> coretemp driver?
> coretemp: Unknown CPU model 1c
>
> I'm building my kernel again to check if I missed something
Just by looking at drivers/hwmon/coretemp.c, model 1c doesn't seem to
be supported, it doesn't match any known cpu->x86_model test and
triggers error

Maybe i should report this to coretemp developpers too
-- 
Lliane aka Simon Depiets
Epita Promo 2011,42
http://www.lliane.com
A man is smoking with his girlfriend. She angers herslef : "don't you
see the warning on the box ?!"
To which the man replies, "I am a programmer. I don't worry about
warnings. I only worry about errors."
