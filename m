From: Sam Ruby <rubys@intertwingly.net>
Subject: Re: [APIC] Kernel panic, rsync corruption, intel q8200, 2.6.28-rc8
Date: Tue, 03 Feb 2009 12:55:50 -0500
Message-ID: <49888526.60803@intertwingly.net>
References: <4978767D.4060700@intertwingly.net> <20090130000758.1dff0113.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vanadium.sabren.com ([67.19.173.84]:32887 "EHLO
	vanadium.sabren.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZBCSpa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 13:45:30 -0500
In-Reply-To: <20090130000758.1dff0113.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> On Thu, 22 Jan 2009 08:37:01 -0500 Sam Ruby <rubys@intertwingly.net> wrote:
> 
>> Hardware summary: http://tinyurl.com/ap79ra
>> APIC details: http://intertwingly.net/stories/2009/01/22/
>> Note acpidump.err: Wrong checksum for OEMB!
>>
>> Messages on boot using Intrepid, Jaunty Alpha 3, or Fedora 10:
>>
>> [    0.296001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
>> [    0.296001] Kernel panic - not syncing: IO-APIC + timer doesn't work! 
>>   Boot with apic=debug and send a report.  Then try booting with the 
>> 'noapic' option.
>> [    0.296001]
>>
>> Able to get past this issue using "noapic", at which point things mostly 
>> work,
> 
> Join the ever-growing noapic club :(
> 
> I assume this is an ACPI problem.  Or at least, a BIOS problem which
> ACPI can solve for us.

My understanding is that APCI and APIC are two different things.

>> but rsync of large iso images result in corrupt files.  Able to 
>> copy those same files using Vista on the same machine, or using Hardy on 
>> another machine.  This problem may not be related to the above, but it 
>> seems plausible to me that this might be an interrupt issue.
> 
> Yes, it might be unrelated.  There are no kernel messages when it happens?

I see no messages to /var/log/messages while doing the following (which 
involves rsync'ing a 2618793984 byte file from an NTFS to ext3 drive on 
the same machine:

rubys@rubix4:~/tmp$ rsync /mnt/shared/windows7_7000.iso .
rubys@rubix4:~/tmp$ openssl md5 windows7_7000.iso
MD5(windows7_7000.iso)= 953b9ac92d58f5edef525004bcce048d
rubys@rubix4:~/tmp$ rsync /mnt/shared/windows7_7000.iso .
rubys@rubix4:~/tmp$ openssl md5 windows7_7000.iso
MD5(windows7_7000.iso)= 695328ef1280708eb73303656f6ef0b2

>> memtest86+ runs clean.
>>
>> Quite willing to invest time in installing kernels or distributions on 
>> fresh hard drives, run tests, obtain debug information, and report back.
>>
>> More background here: http://intertwingly.net/blog/2009/01/20/noAPIC
>>
>> Not subscribed, but will actively monitor the web archives for this 
>> mailing list for the next several days.
> 
> It'd be best to raise a report against ACPI?BIOS (I think) at
> bugzilla.kernel.org, please.

Once again, I'm talking about apic not acpi... does this advice still hold?

> If any previous kernel version worked OK, please be sure to note that.

I don't believe that's the case.

> Thanks.

- Sam Ruby
