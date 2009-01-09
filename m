From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: why kexec (was Re: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable when unused)
Date: Thu, 8 Jan 2009 23:24:15 -0800
Message-ID: <86802c440901082324g50138f71tcd705b909205be6e@mail.gmail.com>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
	 <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
	 <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com>
	 <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain>
	 <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com>
	 <alpine.LFD.2.00.0812191337160.3745@localhost.localdomain>
	 <494C023F.6070207@kernel.org>
	 <alpine.LFD.2.00.0901090144220.4091@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:46917 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbZAIHYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 02:24:16 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8800368rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2009 23:24:15 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901090144220.4091@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, Jan 8, 2009 at 10:55 PM, Len Brown <lenb@kernel.org> wrote:
>> >> maybe could have one switch in /proc so could not disable that for
>> >> some kexec path...
>> >
>> > I fail to comprehend the benefits of kexec,
>> > and the requirements that kexec puts on the kernel, other than:
>> >
>> > # CONFIG_KEXEC is not set
>> >
>>
>> for me: it is a tools that i could use to make sure root-cause is in FW, and BIOS guys will not kick back the ball to os team.
>> after modifying table or hw reg in first kernel, and kexec even stock kernel, everything will work well.
>
> For ACPI, we already have the ability to override the BIOS tables
> upon the 1st boot.
>
> I don't know which BIOS guys you refer to,
> but when we find a BIOS bug and have access to
> the associated BIOS developer, we've never needed
> to do such a demonstration to convince them they have a bug.

Your BIOS developer must have enough time or have bunch of BIOS engineers.

>
> kexec seems like a science project that has a chance of working
> only under extremely controlled conditions.
> I have no problem with that, as long as it is not built into my kernel.

could reduce boot time.
or some system has problem with reset...

or linuxbios + tinykernel to kexec final production kernel.
here linuxbios only init ram and basic pci resource allocation ...

>
> But say kexec is useful to somebody out there -- what are
> the requirements that kexec puts on the kernel?

the support got into the mainline kernel several years ago... from 2.6.16?

YH
