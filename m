From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable when unused
Date: Fri, 19 Dec 2008 12:21:19 -0800
Message-ID: <494C023F.6070207@kernel.org>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com> <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com> <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com> <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain> <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com> <alpine.LFD.2.00.0812191337160.3745@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51828 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbYLSUVe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 15:21:34 -0500
In-Reply-To: <alpine.LFD.2.00.0812191337160.3745@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


>> maybe could have one switch in /proc so could not disable that for
>> some kexec path...
> 
> I fail to comprehend the benefits of kexec,
> and the requirements that kexec puts on the kernel, other than:
> 
> # CONFIG_KEXEC is not set
> 

for me: it is a tools that i could use to make sure root-cause is in FW, and BIOS guys will not kick back the ball to os team.
after modifying table or hw reg in first kernel, and kexec even stock kernel, everything will work well.

YH
