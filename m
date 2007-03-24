From: Mirco Jeske <m.jeske@web.de>
Subject: Re: active[0] being ignored
Date: Sat, 24 Mar 2007 17:22:42 +0100
Message-ID: <46055052.7060109@web.de>
References: <46018B9A.7060106@web.de> <200703231206.13236.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:43626 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbXCXQWQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Mar 2007 12:22:16 -0400
In-Reply-To: <200703231206.13236.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

Len Brown schrieb:
> On Wednesday 21 March 2007 15:46, you wrote:
>   
>> Hi all,
>> I have an asus A3G with opensuse 10.2 running. My trip points are
>>
>> critical (S5):           99 C
>> passive:                 60 C: tc1=2 tc2=10 tsp=100 devices=0xdffec504
>> active[0]:               75 C: devices=0xdffe157c
>>
>> Is there a way to force the fan to only run at 75C?
> See if you can have any effect on this at all
>
> echo 99:98:75:40 > trip_points
>
> and in theory, if temperature is above 40, the fan should turn on.
> If it does, then look at trip_points and see if the BIOS overwrites them.
>   
Hi Len,
thank you for your detailed answer. I already tried to lower the
temperatur point to see if the cooler starts working. It happens that my
fan does not react to my changes at all. Even If I set up 40C as the
point to start cooling the fan is still being activated at 45C. So I
presume you are right with your suspicion that there is a non
configurable hardware device playing a part. I checked my BIOS but found
nothing related to deal with temperatur issues.
Since this starts getting a serious problem (simple office work lets the
fan go on and off giving me a hard time) I'll have a look at the
decompiled DSDT. However, my knowledge regarding this is small, so is
there anybody who could help me with the dsdt if I sent it per email?

thanx a lot, Mirco
