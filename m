From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 01:13:04 +0100
Message-ID: <200802210113.05733.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802210035.14058.rjw@sisk.pl>
	<alpine.LFD.1.00.0802201548000.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.1.00.0802201548000.7833@woody.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Alexey Starikovskiy <aystarik@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday, 21 of February 2008, Linus Torvalds wrote:
> 
> On Thu, 21 Feb 2008, Rafael J. Wysocki wrote:
> > 
> > In fact we have acpi_pci_choose_state() that tells the driver which power
> > state to put the device into in ->suspend().  If that is used, the device ends
> > up in the state expected by to BIOS for S4.
> 
> First off, nobody should *ever* use that directly anyway.

Yes, sorry.

> Secondly, the one that people should use ("pci_choose_state()") doesn't 
> actually do what you claim it does. It does all kinds of wrong things, and 
> doesn't even take the target state into account at all. So look again.

Well, if platform_pci_choose_state() is defined, pci_choose_state() returns
its result and on ACPI systems that points to acpi_pci_choose_state(), so in
fact it does what I said (apart from the error path). 

> > No.  Again, if there are devices that wake us up from S4, but not from S5,
> > they need to be handled differently in the *enter S4* case (hibernation) and
> > in the *enter S5* case (powering off the system).
> 
> And again, what does this have to do with (the example I used) the 
> graphics hardware? Answer: nothing. The example I gave you we simply DO 
> THE WRONG THING FOR.
> 
> Same thing for things like USB devices - where pci_choose_state() doesn't 
> work to begin with. Why do we call "suspend()" on such a thing when we 
> don't want to suspend it? We shouldn't. We should call "freeze/unfreeze" 
> (which are no-ops) and then finally perhaps "poweroff", and that final 
> stage might want to spin things down or similar.

I'm already convinced, really. :-)

Thanks,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
