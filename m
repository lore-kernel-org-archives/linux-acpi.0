From: Thomas Renninger <trenn@suse.de>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Fri, 22 Feb 2008 15:07:42 +0100
Message-ID: <1203689263.4995.81.camel@queen.suse.de>
References: <1203471860.3358.177.camel@linux-2bdv.site>
	 <20080220173248.GA22709@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:53702 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbYBVOHr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 09:07:47 -0500
In-Reply-To: <20080220173248.GA22709@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, 2008-02-20 at 17:32 +0000, Matthew Garrett wrote:
> Let's look at this differently. Most hardware is produced by vendors who 
> don't care about Linux. We need to make that hardware work anyway. The 
> only way we can achieve that is to be bug-compatible with Windows. 
> Therefore, any way in which Linux behaviour varies from Windows 
> behaviour is a bug. The only reason to export any indication that the 
> kernel is Linux is because our behaviour is not identical to Windows. 
> But, given that that's a bug, the solution should be to fix Linux and 
> not to encourage vendors to put workarounds in their firmware.

So to what Windows version are we compatible?

We currently return true for "Windows 2006".
According to drivers/acpi/utilities/uteval.c we return true for all of
these:

        "Windows 2000",         /* Windows 2000 */
        "Windows 2001",         /* Windows XP */
        "Windows 2001 SP1",     /* Windows XP SP1 */
        "Windows 2001 SP2",     /* Windows XP SP2 */
        "Windows 2001.1",       /* Windows Server 2003 */
        "Windows 2001.1 SP1",   /* Windows Server 2003 SP1 - Added
                                   03/2006 */
        "Windows 2006",         /* Windows Vista - Added 03/2006 */

Stuff added for "Windows 2001 SP2" might break Windows 2006.
How do you want to handle this?
Do you want to remove lower versions at some time?
What about Longhorn or whatever coming up?
Then these strings might branch into a server and a workstation Windows,
to which one do you want to stay compatible, both again?
All this does not make sense and it does not work.

All this is an advantage for vendors who do not care about Linux, but it
makes life really hard for vendors who want to support it.

The _OSI interface is not thought for Linux kernel developers to stay
compatible with Windows.
It got invented for vendors being able to provide hot-fixes for their
BIOS for Operating Systems they are willing to support.

So what should a vendor do if he has a BIOS hotfix for Windows 2003
only. The fix workarounds an old W2003 AML bug. But this fix will break
Linux and Vista on his machine. For Vista he can take care, Linux will
break. And you are going to try to implement a workaround for an old
W2003 OS bug (after people got angry because their machine they bought
with Linux pre-loaded does not boot anymore after a BIOS update)...

Your scenario only makes sense for Windows 2006 vendor fixes but also
these are outdated soon, all this simply does not work...

   Thomas

