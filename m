From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Thu, 22 May 2008 10:22:23 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B35F4DF9@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <480EC916.1050407@suse.de> <9D39833986E69849A2A8E74C1078B6B3372B65@orsmsx415.amr.corp.intel.com> <200804242140.28805.lenb@kernel.org> <1209088386.3538.18.camel@rzhang-crestline.sh.intel.com> <9D39833986E69849A2A8E74C1078B6B33735F5@orsmsx415.amr.corp.intel.com> <823A93EED437D048963A3697DB0E35DE015C58DC@pdsmsx414.ccr.corp.intel.com> <1211388969.6254.30.camel@rzhang-dt.sh.intel.com> <9D39833986E69849A2A8E74C1078B6B35F4D85@orsmsx415.amr.corp.intel.com> <4835A593.1080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33709 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbYEVRW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2008 13:22:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4835A593.1080300@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Therien, Guy" <guy.therien@intel.com>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, "Zhao, Yakui" <yakui.zhao@intel.com>

>Currently, there is no way to tell if GPE hanler method would
>do Notify() to some device.

Yep, I thought that might be the issue.

So, GPE is an interrupt mechanism with no way to map an interrupt to a
particular device or driver. So I guess that it is then appropriate for
us to simply enable all GPEs that have associated _Lxx/_Exx methods, and
hope that a driver will come along sometime to handle any associated
notifies. Meaning that all GPEs from the device will be missed until
such time as the driver is loaded.

What if ACPICA did not enable GPEs until after it received a call from
the host that the namespace has been scanned, and all ACPI-related
drivers have been loaded and initialized? Instead of one-by-one enabling
GPEs as drivers came up, wait until *all* drivers are ready?

Bob


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:aystarik@gmail.com]
>Sent: Thursday, May 22, 2008 9:56 AM
>To: Moore, Robert
>Cc: Zhang, Rui; Therien, Guy; Len Brown; Alexey Starikovskiy; linux-
>acpi@vger.kernel.org; Zhao, Yakui
>Subject: Re: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
>
>Moore, Robert wrote:
>> Rui,
>>
>> Thanks for examining this issue in detail. Your proposal to
>> read/update/write the GPE enable register to simply disable one GPE
>> sounds interesting. I want to think about this a bit more -- it has
been
>> a long time since I have looked closely at the GPE handling.
>>
>> With my discussions with Alexey Starikovskiy, we have concluded that
>> there is something incorrect about the current design, where there
exist
>> windows where a GPE could come in with no driver available to handle
it.
>>
>> I'm no longer intimate with the GPE handling model, but it would seem
to
>> me that GPEs should be treated like other interrupts where an
interrupt
>> level remains disabled until a driver is installed which in turn
calls
>> the kernel to install a handler for that interrupt. Only then can the
>> interrupt be safely enabled.
>>
>> There is added complexity since drivers (with the exception of the
>> Embedded Controller) do not handle GPEs directly; instead, an
_Lxx/_Exx
>> method is run which in turn (usually) generates a Notify on a device.
We
>> expect the device driver for the device to have installed a notify
>> handler.
>>
>> So it would seem to me that it would be architecturally best to leave
a
>> GPE disabled until either a handler for the GPE is installed, or a
>> notify handler is installed for the device associated with the GPE.
>>
>>
>Currently, there is no way to tell if GPE hanler method would
>do Notify() to some device.  There could be any number of calls to
other
>methods, which might cause call of Notify().
>So, probably this is a dead end.
>The only implementable way I see is to move enabling of _Lxx/_Exx GPEs
to
>after bus scan, there we have devices autoloaded and installed.
>
>Regards,
>Alex.
