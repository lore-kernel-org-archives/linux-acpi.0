From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 22:56:56 -0800
Message-ID: <m1od0km7uv.fsf@frodo.ebiederm.org>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	<200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
	<4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
	<20081110083938.GD22392@elte.hu>
	<20081110115732.GA30181@srcf.ucam.org>
	<20081110125630.GC28643@elte.hu>
	<20081110130029.GC30894@srcf.ucam.org>
	<alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	<20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>
	<1226546613.4006.110.camel@yakui_zhao.sh.intel.com>
	<m1skpwntyu.fsf@frodo.ebiederm.org>
	<1226554186.4006.136.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:38337 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYKMHFe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 02:05:34 -0500
In-Reply-To: <1226554186.4006.136.camel@yakui_zhao.sh.intel.com> (Zhao Yakui's
	message of "Thu, 13 Nov 2008 13:29:46 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

Zhao Yakui <yakui.zhao@intel.com> writes:

>> Instead of just writing a plain 6.   I think at least on some machines
>> there is a requirement for a low to hight transition.

> Maybe the 0xCF9 port is defined for NVidia, SiS and Several others
> vendor. But we can't say that it is appropriate for most boxes. 

Let me get this straight.  We survey all of the major chipsets in existence.
We discover a register that is implemented the same way in all of them.
You conclude that using that register is not appropriate for most boxes?

> Of course IMO it is not a generic solution for reboot.
> At the same time the value written to the 0xCF9 I/O port should not be a
> fixed value. Maybe it varies on different vendors/chipset. Even the
> value will vary on the boxes from different BIOS vendors although the
> boxes are based on the same chipset. 

Reading in between the lines.  Did you just say someone implemented
a nasty hack on some laptop and attempting to reboot by writing to 0xcf9
will cause nasty problems?

If you know of such a case please describe the failure mode.  If there
is a case where writing to 0xcf9 will makes things worse than we need
to tread carefully, and we will happily deal with reality.  If you can
only tell us that we are being rude and circumventing a vendors vision
of the then your input is not especially useful.

>     And the value should be provided by BIOS. If BIOS doesn't provide
> the above info, it is not safe to use them. 

Balderdash.  There are other ways to learn things than by talking to
the BIOS.  Usually BIOS's are a mediocre information source at best.
The job of a BIOS is to boot and if it can do that solidly you can ship it,
when the schedule gets tight.  Everything else is a nice to have.

Eric

