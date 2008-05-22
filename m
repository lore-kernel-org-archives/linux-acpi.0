From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Thu, 22 May 2008 20:55:47 +0400
Message-ID: <4835A593.1080300@gmail.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <480EC916.1050407@suse.de> <9D39833986E69849A2A8E74C1078B6B3372B65@orsmsx415.amr.corp.intel.com> <200804242140.28805.lenb@kernel.org> <1209088386.3538.18.camel@rzhang-crestline.sh.intel.com> <9D39833986E69849A2A8E74C1078B6B33735F5@orsmsx415.amr.corp.intel.com> <823A93EED437D048963A3697DB0E35DE015C58DC@pdsmsx414.ccr.corp.intel.com> <1211388969.6254.30.camel@rzhang-dt.sh.intel.com> <9D39833986E69849A2A8E74C1078B6B35F4D85@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:47389 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbYEVQzQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2008 12:55:16 -0400
Received: by mu-out-0910.google.com with SMTP id w8so103962mue.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 May 2008 09:55:15 -0700 (PDT)
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B35F4D85@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Therien, Guy" <guy.therien@intel.com>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, "Zhao, Yakui" <yakui.zhao@intel.com>

Moore, Robert wrote:
> Rui,
>
> Thanks for examining this issue in detail. Your proposal to
> read/update/write the GPE enable register to simply disable one GPE
> sounds interesting. I want to think about this a bit more -- it has been
> a long time since I have looked closely at the GPE handling.
>
> With my discussions with Alexey Starikovskiy, we have concluded that
> there is something incorrect about the current design, where there exist
> windows where a GPE could come in with no driver available to handle it.
>
> I'm no longer intimate with the GPE handling model, but it would seem to
> me that GPEs should be treated like other interrupts where an interrupt
> level remains disabled until a driver is installed which in turn calls
> the kernel to install a handler for that interrupt. Only then can the
> interrupt be safely enabled.
>
> There is added complexity since drivers (with the exception of the
> Embedded Controller) do not handle GPEs directly; instead, an _Lxx/_Exx
> method is run which in turn (usually) generates a Notify on a device. We
> expect the device driver for the device to have installed a notify
> handler.
>
> So it would seem to me that it would be architecturally best to leave a
> GPE disabled until either a handler for the GPE is installed, or a
> notify handler is installed for the device associated with the GPE.
>
>   
Currently, there is no way to tell if GPE hanler method would
do Notify() to some device.  There could be any number of calls to other
methods, which might cause call of Notify().
So, probably this is a dead end.
The only implementable way I see is to move enabling of _Lxx/_Exx GPEs to
after bus scan, there we have devices autoloaded and installed.

Regards,
Alex.
