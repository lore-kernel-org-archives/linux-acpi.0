From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM
	Improvements
Date: Fri, 1 Sep 2006 00:27:14 +0100
Message-ID: <20060831232714.GA9892@srcf.ucam.org>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	<20060830194317.GA9116@srcf.ucam.org>
	<200608311713.21618.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devel-bounces@laptop.org>
Content-Disposition: inline
In-Reply-To: <200608311713.21618.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 31, 2006 at 05:13:20PM -0600, Bjorn Helgaas wrote:

> Out of curiosity, what is the motivation for running without acpi?
> It costs a lot to diverge from the mainstream in areas like that,
> so there must be a big payoff.  But maybe if OLPC depends on acpi
> being smarter about power or code size or whatever, those improvements
> could be made and everybody would benefit.

The current issues are probably the code size and the somewhat 
specialised needs of OLPC. The hardware is interesting in that the 
framebuffer is designed to carry on reading from memory even if the rest 
of the system is in S3. The aim here is to allow the machine to suspend 
when idle while still giving the impression of being alive. It's 
therefore important that the system come out of suspend as quickly as 
possible in order to avoid spoiling that impression, and suspend as 
quickly as possible in order to maximise the power savings. The 
assumption is that parsing AML is something that would add to these time 
periods without providing any significant extra benefit.

Of course, the other main issue is that providing an ACPI platform would 
require us to actually write a set of ACPI tables. The system is running 
Linuxbios, and every kilobyte that's not used by a static table in the 
BIOS is space that could be used for extra functionality.

I think the basic consensus was that ACPI bought us fairly little other 
than the ability to use the existing suspend/resume code, C state 
transitions and battery monitoring, and that replacing the first was 
probably desirable in any case.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
