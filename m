From: Mark Lord <lkml@rtr.ca>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Fri, 30 Nov 2007 23:31:13 -0500
Message-ID: <4750E391.4060309@rtr.ca>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org>	<924EFEDD5F540B4284297C4DC59F3DEE2FAE6A@orsmsx423.amr.corp.intel.com>	<20071130142058.816d1693.akpm@linux-foundation.org>	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>	<4750CC78.9070105@rtr.ca>	<20071130190227.1976e682@laptopd505.fenrus.org>	<4750D180.6080001@rtr.ca> <20071130191816.3e744205@laptopd505.fenrus.org> <4750D585.1030200@rtr.ca> <4750D899.4020905@rtr.ca> <4750DCDC.8030306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1523 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbXLAEbP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Nov 2007 23:31:15 -0500
In-Reply-To: <4750DCDC.8030306@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Mark Lord wrote:
> Arjan van de Ven wrote:
>> On Fri, 30 Nov 2007 22:44:25 -0500
>> Mark Lord <lkml@rtr.ca> wrote:
>>>> all you need to do in your kernel module is call
...
>> set_acceptable_latency("mark", 5);
>>
>> and to remove the constraint again you just do
>>
>> remove_acceptable_latency("mark");
..
>>> Then why not have a sysfs entry for scripts to write tsoro
>>> to trigger the exact same end result?  :)
>>
>> that's what is in current -mm pretty much
>> well not sysfs, but it goes via a file descriptor
>> (so that if the process that sets the contraint dies, the latency
>> requirement can be given up automatically)
> ...
> 
> But doesn't that approach also make it nearly impossible to script ????
...

Okay, I have a working trivial kernel module that I can load/unload
to tweak this.  But a simple sysfs attribute would be *so much* better
as a permanent kernel feature.

Binary interfaces (fd) are fine for some uses, but not nice for scripts.

Cheers
