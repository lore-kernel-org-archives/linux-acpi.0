From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
	suspend
Date: Tue, 12 May 2009 11:06:14 +0800
Message-ID: <1242097574.3773.212.camel@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
	 <4A073D92.5060904@gmx.net>
	 <1242009782.3773.139.camel@localhost.localdomain>
	 <200905111721.10166.rjw@sisk.pl>
	 <1242089305.3773.198.camel@localhost.localdomain>
	 <20090512020147.GA24896@srcf.ucam.org>
	 <1242095172.3773.209.camel@localhost.localdomain>
	 <20090512025017.GB24896@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50530 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757609AbZELDEB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 23:04:01 -0400
In-Reply-To: <20090512025017.GB24896@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-05-12 at 10:50 +0800, Matthew Garrett wrote:
> On Tue, May 12, 2009 at 10:26:12AM +0800, yakui_zhao wrote:
> > Windows can work well on such broken box. And I find that the _STA
> > object of power resource is not called in course of power transition
> > with the help of KVM.
> > 
> > To be compatible with windows, we add such a
> > workaround("acpi.power_nocheck=1") to fix this issue.
> 
> If Windows doesn't call _STA when performing these power transitions 
> then the default behaviour of Linux should be not to call _STA. We 
> strive to maintain compatibility with Windows when it comes to driving 
> the hardware - that means not forcing the user to add a boot option or 
> trying to maintain a DMI table.
It will be OK to change the default value of "power_nocheck" to 1.

I will do this.
> 
> > If the power state check is always skipped in course of power
> > transition, there is no such error message. But it can't tell us that
> > this is a broken BIOS.
> 
> Failing someone's suspend in order to inform them that their ancient 
> hardware has a broken BIOS doesn't seem like useful behaviour.
> 

