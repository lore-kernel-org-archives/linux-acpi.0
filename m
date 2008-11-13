From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 13 Nov 2008 17:06:20 +0800
Message-ID: <1226567180.4006.171.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	 <20081110083938.GD22392@elte.hu>	<20081110115732.GA30181@srcf.ucam.org>
	 <20081110125630.GC28643@elte.hu>	<20081110130029.GC30894@srcf.ucam.org>
	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	 <20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>
	 <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
	 <m1skpwntyu.fsf@frodo.ebiederm.org>
	 <1226554186.4006.136.camel@yakui_zhao.sh.intel.com>
	 <m1ljvom7sz.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59835 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYKMI6o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 03:58:44 -0500
In-Reply-To: <m1ljvom7sz.fsf@frodo.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 2008-11-13 at 14:58 +0800, Eric W. Biederman wrote:
> Zhao Yakui <yakui.zhao@intel.com> writes:
> 
> >> Instead of just writing a plain 6.   I think at least on some machines
> >> there is a requirement for a low to hight transition.
> 
> > Maybe the 0xCF9 port is defined for NVidia, SiS and Several others
> > vendor. But we can't say that it is appropriate for most boxes. 
> 
> Let me get this straight.  We survey all of the major chipsets in existence.
> We discover a register that is implemented the same way in all of them.
> You conclude that using that register is not appropriate for most boxes
I am sorry that I don't describe it very clearly. The value written into
0xCF9 I/O port maybe vary on different chipset vendors. In such case it
is difficult to write the generic 0xCF9 reboot mechanism. If the same
standard about 0xCF9 I/O port is followed by most chipset vendors, it
will be OK.
> 
> > Of course IMO it is not a generic solution for reboot.
> > At the same time the value written to the 0xCF9 I/O port should not be a
> > fixed value. Maybe it varies on different vendors/chipset. Even the
> > value will vary on the boxes from different BIOS vendors although the
> > boxes are based on the same chipset. 
> 
> Reading in between the lines.  Did you just say someone implemented
> a nasty hack on some laptop and attempting to reboot by writing to 0xcf9
> will cause nasty problems?
I have a laptop on which the ACPI reboot mechanism is not supported.(The
reset flag is not present). But there exists the definition of RESET_REG
& RESET_VALUE. The RESET_REG is 0xCF9 I/O port. (The box is based on
Intel i915 chipsets)
    When writing 0x06 to 0xCF9 I/O port the box will hang and can't be
rebooted. (Hardware reset will fail)
    When writing 0x04 to 0xCF9 I/O port the box can be
rebooted.(Software reset is OK)

On the laptop of bug 11942(kernel bugzilla) the acpi reboot is also
unsupported. But there exists the definition of 0xCF9 I/O port. (The box
is based on AMD platform. The CPU is Phenom 9500 Quad-core.)
     After writing 0x06 to 0xCF9 I/O port, the box can't be rebooted.
> 
> If you know of such a case please describe the failure mode.  If there
> is a case where writing to 0xcf9 will makes things worse than we need
> to tread carefully, and we will happily deal with reality.  If you can
> only tell us that we are being rude and circumventing a vendors vision
> of the then your input is not especially useful.
> 
> >     And the value should be provided by BIOS. If BIOS doesn't provide
> > the above info, it is not safe to use them. 
> 
> Balderdash.  There are other ways to learn things than by talking to
> the BIOS.  Usually BIOS's are a mediocre information source at best.
> The job of a BIOS is to boot and if it can do that solidly you can ship it,
> when the schedule gets tight.  Everything else is a nice to have.
> 
> Eric
> 

