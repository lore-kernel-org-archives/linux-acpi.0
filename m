From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Debug interface used for error message cleanups
Date: Fri, 01 Aug 2008 09:42:24 +0800
Message-ID: <1217554944.2969.166.camel@rzhang-dt>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
	 <9D39833986E69849A2A8E74C1078B6B3BFA624@orsmsx415.amr.corp.intel.com>
	 <200807311159.11276.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26739 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbYHABoj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 21:44:39 -0400
In-Reply-To: <200807311159.11276.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On Thu, 2008-07-31 at 17:59 +0800, Thomas Renninger wrote:
> On Wednesday 30 July 2008 22:29:19 Moore, Robert wrote:
> > I'm going to go ahead and remove these from ACPICA.
> >
> > We added an "obsolete" warning in the header file some time ago, and
> I
> > think the time has come to remove them, especially in light of these
> > patches to Linux.
> 
> Great thanks.
> If you are at that, do you think it makes sense to intruduce a GPE
> bit?
> Just leaving it unused for now?

> 
> I didn't play with these much yet, Rui, do you think this makes sense?
> The
> fact there were several sever problems recently and GPEs possibly
> must get debugged by people writting other device drivers who do not
> know
> and do not want to know about the output of the other debug flags I
> thought
> this could make sense.

We used to get the GPE debug info by doing this,
set debug_layer=0x44, debug_level=0x8800001f
We can get the content of GPE Block Register once a GPE is fired.
and it's the same for PM1 Event Register and Fixed Events.
Is this what you want?

thanks,
rui
> 
> Just an idea...,
> 
>        Thomas
> 
> 

