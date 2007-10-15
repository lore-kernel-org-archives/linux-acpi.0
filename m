From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: halt does not shut the system down
Date: Mon, 15 Oct 2007 18:03:43 +0400
Message-ID: <4713733F.7060408@gmail.com>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr> <471342C8.2030305@free.fr> <47134ACF.8040608@gmail.com> <47136B2F.9070904@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:30466 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764469AbXJOODw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Oct 2007 10:03:52 -0400
Received: by ug-out-1314.google.com with SMTP id z38so880583ugc
        for <linux-acpi@vger.kernel.org>; Mon, 15 Oct 2007 07:03:50 -0700 (PDT)
In-Reply-To: <47136B2F.9070904@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

John Sigler wrote:
> Alexey Starikovskiy wrote:
> 
>> John Sigler wrote:
>>
>>> Alexey Starikovskiy wrote:
>>>
>>>> Could you please open bug at bugzilla.kernel.org and put all
>>>> these files there?
>>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=9148
>>>
>>> Writing 15361 (i.e. 0x3C01) to ACPI_REGISTER_PM1A_CONTROL appears
>>> to hang my system in acpi_os_write_port(). What can I do about that?
>>
>> That is supposed to turn your machine off. At least we now know that
>> ACPI did try to turn it off. You could also try different kernel or
>> defconfig.
> 
> What's defconfig? .config? Which option(s) might have an impact?

This is an option to make. It creates .config file with some default settings,
appropriate to most computers.

>>> Is it a BIOS issue? a kernel issue? a hardware issue?
>>
>> I think _other_ OS could turn your machine off just fine, so the
>> issue is not HW, not BIOS. Probably, first thing to try is 2.6.23.1
>> as it was just released and has some changes in power management
>> section...
> 
> I have the same problem in 2.6.23.1 (cf. my bug report in the database)
> 
> I'll ask the manufacturer whether they could get poweroff to work.
> 
> Regards.
> 

