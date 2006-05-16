From: "Brown, Len" <len.brown@intel.com>
Subject: RE: acpi_power_off doesn't
Date: Tue, 16 May 2006 02:38:47 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB675ABCD@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49790 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751535AbWEPGiv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2006 02:38:51 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>>> Sometimes when I run 'halt' my PC does not go off. Last
>>> words are
>>>
>>> 	acpi_power_off called
>>>
>>> But the PC stays on.
>>>
>>> What is the story here? I've seen this problem come up
>>> several times, but without solution, as it seems. Any
>>> hint would be very helpfull.
>> 
>> Does this happen all the time, or just some of the time?
>> Has this always failed on box X, or did it used to
>> work in some release Y, and broke in some release Z?
>> 
>> Please supply X, Y, Z.


>The problem does not exist, if I boot my PC and then
>halt it immediately. If I login and use it for some
>time, then acpi_power_off does not work.
>
>Box 'X' is an Aopen MZ-915M, CPU is a 2 GHz Pentium
>M. It is running Debian Sid, kernel is vanilla
>
>Linux bugs 2.6.17-rc4 #1 PREEMPT Sat May 13 16:22:54 CEST 2006 
>i686 GNU/Linux
>
>Old kernels don't work on this PC due to missing
>hardware support. The first vanilla kernel that worked
>reliably on this box (except for acpi_power_off) was 2.6.16.

If you append a "3" to the cmdline and boot without a GUI,
does the system still halt properly (even after you log in
and use it for a while)?  There may be some interaction
between X and the video hardware and system shutdown.

-Len
