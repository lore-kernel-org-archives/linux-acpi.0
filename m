From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
	suspend
Date: Tue, 12 May 2009 10:26:12 +0800
Message-ID: <1242095172.3773.209.camel@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
	 <4A073D92.5060904@gmx.net>
	 <1242009782.3773.139.camel@localhost.localdomain>
	 <200905111721.10166.rjw@sisk.pl>
	 <1242089305.3773.198.camel@localhost.localdomain>
	 <20090512020147.GA24896@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2867 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756874AbZELCYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 22:24:00 -0400
In-Reply-To: <20090512020147.GA24896@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-05-12 at 10:01 +0800, Matthew Garrett wrote:
> On Tue, May 12, 2009 at 08:48:25AM +0800, yakui_zhao wrote:
> 
> > In such case the power state check will be skipped in course of power
> > transition.
> > 
> > Is this OK?
> 
> What's the real-world benefit to throwing an error in this case? What is 
> the user or software supposed to do with it?
In fact this error is caused by the BIOS. And it tells us that such
issue had better be fixed by BIOS upgrading. 
For example: on the HP nc6000 box. The _OFF object of the power resource
is bogus.  And the _STA object can't reflect the correct status of the
power resource. 
   
Windows can work well on such broken box. And I find that the _STA
object of power resource is not called in course of power transition
with the help of KVM.

To be compatible with windows, we add such a
workaround("acpi.power_nocheck=1") to fix this issue.

If the power state check is always skipped in course of power
transition, there is no such error message. But it can't tell us that
this is a broken BIOS.

Best regards.
   Yakui


> 

