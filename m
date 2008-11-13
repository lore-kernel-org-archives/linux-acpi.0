From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 21:25:58 -0800
Message-ID: <491BBA66.4090302@zytor.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>	 <20081110083938.GD22392@elte.hu>	<20081110115732.GA30181@srcf.ucam.org>	 <20081110125630.GC28643@elte.hu>	<20081110130029.GC30894@srcf.ucam.org>	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>	 <20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>	 <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>	 <m1skpwntyu.fsf@frodo.ebiederm.org> <1226554186.4006.136.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42453 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbYKMF1e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 00:27:34 -0500
In-Reply-To: <1226554186.4006.136.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

Zhao Yakui wrote:
> Maybe the 0xCF9 port is defined for NVidia, SiS and Several others
> vendor. But we can't say that it is appropriate for most boxes. 
> Of course IMO it is not a generic solution for reboot.
> At the same time the value written to the 0xCF9 I/O port should not be a
> fixed value. Maybe it varies on different vendors/chipset. Even the
> value will vary on the boxes from different BIOS vendors although the
> boxes are based on the same chipset. 
>     And the value should be provided by BIOS. If BIOS doesn't provide
> the above info, it is not safe to use them. 

We all agree that we should try to get the ACPI stuff to work as the 
first instance.  **THAT IS ALL THE HELP WE WILL GET FROM THE BIOS**.
Now, it isn't working.  Now what do you do?

In short, unless you have anything concrete to add to this discussion, 
please stop pontificating.

	-hpa

