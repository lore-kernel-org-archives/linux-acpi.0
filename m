From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Fri, 22 Feb 2008 18:10:00 +0000
Message-ID: <20080222181000.GB32623@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <1203689263.4995.81.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:48944 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbYBVSKP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Feb 2008 13:10:15 -0500
Content-Disposition: inline
In-Reply-To: <1203689263.4995.81.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Fri, Feb 22, 2008 at 03:07:42PM +0100, Thomas Renninger wrote:

> So to what Windows version are we compatible?

Microsoft has been very good at keeping backwards compatibility for this 
functionality, so the obvious aim is to be compatible with the current 
version of Windows and all previous versions. If necessary, we can 
switch to compatibility modes depending on whether the firmware requests 
XP or Vista or whatever.

> Do you want to remove lower versions at some time?

No.

> What about Longhorn or whatever coming up?

We aim to be compatible with it.

> Then these strings might branch into a server and a workstation Windows,
> to which one do you want to stay compatible, both again?

Whichever one the firmware asks for.

> All this does not make sense and it does not work.

It makes perfect sense and I've no reason to think it doesn't work.

> All this is an advantage for vendors who do not care about Linux, but it
> makes life really hard for vendors who want to support it.

No! We have the choice between providing a benefit to a subset of 
vendors at the cost of never being able to fix bugs, or just making 
everything work. Given the choice between making everything work and 
making Lenovo work, I'll go for making everything work.

> The _OSI interface is not thought for Linux kernel developers to stay
> compatible with Windows.
> It got invented for vendors being able to provide hot-fixes for their
> BIOS for Operating Systems they are willing to support.

No! _OSI is (according to the spec) there to enable vendors to support 
*features* provided by specific OSs, not to work around bugs in that OS. 
What does an _OSI of Linux mean? We don't have a well-defined feature 
set. We don't have a stable set of bugs. Our development model is 
inherently different from Windows, and providing this information just 
makes no sense.

> So what should a vendor do if he has a BIOS hotfix for Windows 2003
> only. The fix workarounds an old W2003 AML bug. But this fix will break
> Linux and Vista on his machine. For Vista he can take care, Linux will
> break. And you are going to try to implement a workaround for an old
> W2003 OS bug (after people got angry because their machine they bought
> with Linux pre-loaded does not boot anymore after a BIOS update)...

Fine. So we define different behaviour depending on whether the firmware 
asks for Vista or not. This isn't rocket science.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
