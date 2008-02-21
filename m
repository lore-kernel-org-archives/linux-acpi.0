From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 16:25:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802201617050.7833@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802210035.14058.rjw@sisk.pl>
	<alpine.LFD.1.00.0802201548000.7833@woody.linux-foundation.org>
	<200802210113.05733.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802210113.05733.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Alexey Starikovskiy <aystarik@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org



On Thu, 21 Feb 2008, Rafael J. Wysocki wrote:
> 
> > Secondly, the one that people should use ("pci_choose_state()") doesn't 
> > actually do what you claim it does. It does all kinds of wrong things, and 
> > doesn't even take the target state into account at all. So look again.
> 
> Well, if platform_pci_choose_state() is defined, pci_choose_state() returns
> its result and on ACPI systems that points to acpi_pci_choose_state(), so in
> fact it does what I said (apart from the error path). 

Did you check closer?

I repeat: acpi_pci_choose_state() (when called from pci_choose_state()) 
doesn't even look at the target 'state'. It just blindly assumes that you 
want the deepest sleep-state you can have.

Which happens to be correct for normal suspend, but means that if you want 
to test other states (through '/sys/devices/.../power'), that sounds 
broken.

I didn't check any closer, but go check it yourself. The short and sweet: 
acpi_pci_choose_state() totally ignores its 'state' argument. Do you 
really think that's correct? But yes, "pci_choose_state()' effectively 
does that too, apart from PM_EVENT_ON, which is never used.

(But the whole and only point of pci_choose_state() was to do the 
PM_EVENT_FREEZE thing differently, which it doesn't do, so I think the 
real issue here is that the interface is really rather mis-designed)

I suspect most people who ever really looked and worked on this code had a 
specific device in mind, and I'm sure that all of the code individually 
always ends up making sense from the standpoint of some specific device 
driver. It's just that it never seems to make sense from a bigger issues 
standpoint, and often seems senseless from the standpoint of other devices 
of other types.

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
