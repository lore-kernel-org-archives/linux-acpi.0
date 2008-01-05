From: "Roland" <devzero@web.de>
Subject: Re: always 3 times: "AE_NOT_FOUND, Processor Device is not present"
Date: Sat, 5 Jan 2008 14:15:32 +0100
Message-ID: <05d001c84f9d$0dd1c450$6b02a8c0@bui.materna.com>
References: <87396499@web.de> <20080105124024.GA15738@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:45994 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbYAENPv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 08:15:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-acpi@vger.kernel.org

mhh - it`s an notebook with Pentium M 1.80GHz and i get this when booting in 
vmware (configured with single proc) - didn`t test if this happens if i do 
native boot on that hardware.

got a pointer to kernel bugzilla and will take a closer look.

thanks!

----- Original Message ----- 
From: "Pavel Troller" <patrol@sinus.cz>
To: <devzero@web.de>
Cc: <linux-acpi@vger.kernel.org>
Sent: Saturday, January 05, 2008 1:40 PM
Subject: Re: always 3 times: "AE_NOT_FOUND, Processor Device is not present"


>> came across this by some module testing and i`m just curious why that 
>> message is always being printed 3 times where one would be enough.
>>
>> indeed a very minor issue (if any) - just wanted to let you know....
>>
> Hi!
>  Maybe it's because your ACPI BIOS exports entries for 4 CPUs (your mobo
> can accept quad-core CPU), but only one CPU/core is really populated. One 
> of
> my motherboards does exactly the same - I have a dual-core CPU in it and
> it shows always 2x PROCESSOR_NOT_FOUND error.
>  With regards, Pavel Troller 

