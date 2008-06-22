From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [RFC PATCH 1/2] ACPI: allow enable/disable/clear ACPI interrupts in user space
Date: Sun, 22 Jun 2008 22:06:34 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE0174A977@pdsmsx414.ccr.corp.intel.com>
References: <1213926167.3001.9.camel@rzhang-dt.sh.intel.com> <alpine.LFD.1.10.0806200132080.22284@localhost.localdomain> <alpine.LFD.1.10.0806200252290.22284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12107 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbYFVOGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Jun 2008 10:06:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.1.10.0806200252290.22284@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>



>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Friday, June 20, 2008 2:54 PM
>To: Zhang, Rui
>Cc: linux-acpi; Lin, Ming M; Alexey Starikovskiy
>Subject: Re: [RFC PATCH 1/2] ACPI: allow enable/disable/clear ACPI
interrupts
>in user space
>
>>
>> applied to acpi-test
>
>rats, i lied.
>this conflicts with the acpica branch in acpi-test,
>and I'm too lazy to deal with the conflict at this hour.
>
>I expect the acpica branch to go upstream in 2.6.27, and I'd like to
see
>this feature too.  Any chance you can re-base this patch on top of the
>current linux-acpi test tree?
Sure, I'll re-send it out sometime tomorrow. :)

Thanks,
rui
>
>> On Fri, 20 Jun 2008, Zhang Rui wrote:
>>
>> > From: Zhang Rui <rui.zhang@intel.com>
>> >
>> > Allow users to enable/disable/clear a specific & valid GPE/Fixed
Event in
>user space.
>> >
>> > Note: This is useful for debugging, especially for some interrupt
storm
>issues.
>> >
>> > Note: All wakeup GPEs are disabled and they can not be enabled at
runtime,
>and we mark them as invalid.
>> >       All GPEs that don't have a _Lxx/_Exx method are marked as
invalid.
>> >       All Fixed Events that don't have an event handler are marked
as invalid
>and they can't be enabled
>> >       until an event handler is registered.
>> >
>> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> > Signed-off-by: Ling Ming <ming.m.lin@intel.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-firmware-acpi |  127
>+++++++++++++------
>> >  drivers/acpi/events/evxfevnt.c                |   18 ++
>> >  drivers/acpi/hardware/hwgpe.c                 |    2
>> >  drivers/acpi/system.c                         |  169
>++++++++++++++++++++++++--
>> >  include/acpi/achware.h                        |    2
>> >  include/acpi/acpixf.h                         |    4
>> >  6 files changed, 258 insertions(+), 64 deletions(-)
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
