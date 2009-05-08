From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Bugme-new] [Bug 13243] New: regression from 2.6.29 : can't
	suspend on a compaq nc6000, suspend_device(): pnp_bus_suspend+0x0/0x6b
	returns -5
Date: Fri, 08 May 2009 09:31:04 +0800
Message-ID: <1241746264.3773.125.camel@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
	 <20090505150138.92f3ecd6.akpm@linux-foundation.org>
	 <4A02000D.9030400@gmx.net>  <200905061616.36707.bjorn.helgaas@hp.com>
	 <1241660638.3773.90.camel@localhost.localdomain> <4A0330E3.9060909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12484 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZEHB3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 May 2009 21:29:12 -0400
In-Reply-To: <4A0330E3.9060909@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-05-08 at 03:05 +0800, Witold Szczeponik wrote:
> yakui_zhao schrieb:
> 
> > What you said is right. After applying that commit, the C169 device will
> > be switched to D3. And when the C169 device is switched to D3, the power
> > resource(C16D) will be turned off.
> >    But unfortunately the _OFF object of C16D is bogus. In such case the
> > _STA method can't reflect the correct status of power resource and OS
> > will complain that the C169 device can't be switched to D3 state.
> >    > Method (_OFF, 0, NotSerialized)
> >    >                         {
> >                                 Store (0x00, Local0)
> >    >                         }
> 
> I think this is the key to understanding what is going on here: it seems 
> as if the BIOS does not allow for disabling the power resource through 
> ACPI.  I suspect the Linux' ACPI core tries to set the power resource to 
> D3, then evaluates _STA, and relizes that something went wrong.  But I 
> am guessing here...  Even more speculation: Windows either does not care 
> or makes the transition from D0 to D3 only once..
Your guess is right.
If there is no boot option of "acpi.power_nocheck=1", the _STA method
will be evaluated to check whether the power resource is switched to the
correct state after the _ON/_OFF object is evaluated.

if the boot option of "acpi.power_nocheck=1" is added, the status check
will be skipped after the _ON/_OFF object is evaluated.

Thanks.
> .
> 
> --- Witold
> 
> > 	
> >    
> >    If we add the boot option of "acpi.power_nocheck=1", the status check
> > will be skipped in course of D0/D3 state transition.
> > 
> 
> 

