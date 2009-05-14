From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Thu, 14 May 2009 11:56:27 +0100
Message-ID: <20090514105626.GA17294@srcf.ucam.org>
References: <1242106060.3773.216.camel@localhost.localdomain> <200905120857.40058.bjorn.helgaas@hp.com> <1242184384.3773.241.camel@localhost.localdomain> <20090513130803.GA27522@srcf.ucam.org> <1242265659.3773.428.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46436 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbZENK4c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2009 06:56:32 -0400
Content-Disposition: inline
In-Reply-To: <1242265659.3773.428.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, May 14, 2009 at 09:47:39AM +0800, yakui_zhao wrote:
> On Wed, 2009-05-13 at 21:08 +0800, Matthew Garrett wrote:
> > The default behaviour should be to be compatible with Windows, 
> > regardless of what the spec says. There's an argument for providing a 
> > strict interpretation of the spec for testing purposes, but I don't
> > see 
> > any reason for it to be split up into dozens of individual kernel 
> > parameters
> The ACPI 1.0 spec is followed by windows XP. And the power state is not
> checked in power transition under windows XP.
> But we don't know whether it is still skipped on the new version
> windows.(For example: Windows 7).
>
> If the module param is removed, we must delete the source code related
> with power state check. And if the power state is checked in power
> transition on windows 7, what we should do? It is not reasonable to add
> them again.

If Windows 7 changes the behaviour then the correct approach is to key 
this behaviour on whether the system firmware requests the Windows 7 OSI 
string. The code can be #if 0ed out until then, or placed under an 
acpi.strict kernel option that turns on all standards-compliant but 
windows-incompatible code.

> Maybe it is better to determine whether the power state check is skipped
> in power transition.

We have a stated policy that Linux will default to being Windows 
compatible. You've demonstrated that in this case Linux isn't Windows 
compatible, which means that it's a bug. The correct behaviour for Linux 
here is to ignore the _STA value (or, indeed, not to call _STA at all in 
this path).

-- 

Matthew Garrett | mjg59@srcf.ucam.org
