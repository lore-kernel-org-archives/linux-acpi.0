From: John Sigler <linux.kernel@free.fr>
Subject: Re: halt does not shut the system down
Date: Wed, 17 Oct 2007 11:59:13 +0200
Message-ID: <4715DCF1.30507@free.fr>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr> <471342C8.2030305@free.fr> <4714979C.5010103@free.fr> <Pine.LNX.4.61.0710160835160.11232@chaos.analogic.com> <4714B7D7.7090005@free.fr> <4714EF81.2070405@gmail.com> <4715C337.6050705@free.fr> <4715C39E.7070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:38610 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757021AbXJQJ7P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2007 05:59:15 -0400
In-Reply-To: <4715C39E.7070603@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, robert.moore@intel.com

Alexey Starikovskiy wrote:

> John Sigler wrote:
> 
>> Alexey Starikovskiy wrote:
>>
>>> John Sigler wrote:
>>>
>>>>          +===================================+
>>>>          | Soft-Off by PWR-BTTN              |
>>>>          |-----------------------------------|
>>>>          | Instant-Off  ..... [v]            |
>>>>          | Delay 4 Sec. ..... [ ]            |
>>>>          |                                   |
>>>>          |-----------------------------------|
>>>>          |  ^V:Move ENTER:Accept ESC:Abort   |
>>>>          +===================================+
>>>>
>>>> 'Instant-Off' is the appropriate setting, right?
>>>
>>> Actually, default should be 4 sec delay. OS should have a chance to
>>> shut down the system...
>>
>> I don't see why this setting would have an impact on the outcome
>> of the 'halt' and 'poweroff' commands.
>>
> Well, it is not possible to tell, what BIOS writer have connected to this flag...

(It sucks to be stuck with a closed proprietary BIOS.)

I tested the other setting, and it didn't change anything.
The system remains powered on after executing poweroff.

Len: the system is 100% Intel (Intel CPU, Intel north bridge, Intel 
south bridge, Intel integrated network controllers). Have Intel 
engineers run into the same problem on a similar platform?

http://bugzilla.kernel.org/show_bug.cgi?id=9148

Regards.
