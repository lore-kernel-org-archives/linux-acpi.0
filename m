From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [Bugme-new] [Bug 13243] New: regression from 2.6.29 : can't	suspend
 on a compaq nc6000, suspend_device(): pnp_bus_suspend+0x0/0x6b	returns -5
Date: Thu, 07 May 2009 21:05:07 +0200
Message-ID: <4A0330E3.9060909@gmx.net>
References: <bug-13243-10286@http.bugzilla.kernel.org/>	 <20090505150138.92f3ecd6.akpm@linux-foundation.org>	 <4A02000D.9030400@gmx.net>  <200905061616.36707.bjorn.helgaas@hp.com> <1241660638.3773.90.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528AbZEGTFO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 May 2009 15:05:14 -0400
In-Reply-To: <1241660638.3773.90.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, linux-acpi@vger.kernel.org

yakui_zhao schrieb:

> What you said is right. After applying that commit, the C169 device will
> be switched to D3. And when the C169 device is switched to D3, the power
> resource(C16D) will be turned off.
>    But unfortunately the _OFF object of C16D is bogus. In such case the
> _STA method can't reflect the correct status of power resource and OS
> will complain that the C169 device can't be switched to D3 state.
>    > Method (_OFF, 0, NotSerialized)
>    >                         {
>                                 Store (0x00, Local0)
>    >                         }

I think this is the key to understanding what is going on here: it seems 
as if the BIOS does not allow for disabling the power resource through 
ACPI.  I suspect the Linux' ACPI core tries to set the power resource to 
D3, then evaluates _STA, and relizes that something went wrong.  But I 
am guessing here...  Even more speculation: Windows either does not care 
or makes the transition from D0 to D3 only once...

--- Witold

> 	
>    
>    If we add the boot option of "acpi.power_nocheck=1", the status check
> will be skipped in course of D0/D3 state transition.
> 


