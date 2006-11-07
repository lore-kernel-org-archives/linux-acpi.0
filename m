From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: Re: SMP C-states on x86_64 Status
Date: Tue, 07 Nov 2006 04:51:51 -0800
Message-ID: <1162903911.32119.275205906@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:64489 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1753528AbWKGMvv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Nov 2006 07:51:51 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Thanks a lot for your input Len.  For my 16 core machine, cat
/proc/acpi/processor/*/power gives the following:

active state:  C1
default state: C1
bus master activity:   00000000
states:
  *C1:      promotion[--] demotion[--] latency[000] usage[0000000000]
    C2:      <not supported>
    C3:      <not supported>

So I gather that this means that even with CPU frequency scaling, I'm
really not doing anything since the voltage and power going to the CPU
are going to be constant until I upgrade to 2.6.18.  Am I correct?

Len Brown wrote:
> On Sunday 05 November 2006 06:37, Mathew Brown wrote:
>> Hi,
>>   I just saw Adrian's post on a patch to add SMP C-states on x86_64 to
>>   kernel 2.6.16.  Is there anywhere I can find the current status of
>>   C-states on SMP machines?  I have a 16-core machine running RHEL with
>>   kernel 2.6.9-34 and it shows only C0, nothing else.  I checked the
>>   DSDT and it compiled without error.  Any ideas?  Thanks for your help.
>
> This support (bugzilla 5653) shipped starting in 2.6.18, and I sent it to Adrian
> for 2.6.16.stable -- and it appears it will pop out in 2.6.16.31.
>
> Re: your 16 core machine running 2.6.9...
> What does /proc/acpi/processor/*/power say?
> I would expect it to say C1 only.
>
> I would not expect this box to grow deeper C-states upon the support above.
> The only SMP boxes with C-states deeper than C1 that I'm aware of today
> are laptops.
>
> cheers,
> -Len
>
>
>
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - The way an email service should be

