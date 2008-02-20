From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 12:29:44 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802201224380.7833@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802201118.08468.jesse.barnes@intel.com>
	<200802201209.03807.jesse.barnes@intel.com>
	<200802202114.43007.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802202114.43007.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org



On Wed, 20 Feb 2008, Rafael J. Wysocki wrote:
> 
> I think we should export the target sleep state somehow.

Yeah. By *not* using "->suspend()" for freezing or hibernate.

Please, Rafael - just make the f*cking suspend-to-disk use other routines 
already. 99% of all hardware needs to do exactly *nothing* on 
suspend-to-disk, and the ones that really do need things tend to need to 
not do a whole lot.

For example, the "freeze" action for USB (which is one of the hardest 
things to suspend) should literally be something like just setting the 
controller STOP bit, and waiting for it to have stopped. The "unfreeze" 
should be to just clear the stop bit, while the "restart" should be just a 
controller reset to use the current memory image.

NONE OF THIS HAS ABSOLUTELY ANYTHING TO DO WITH SUSPEND.

It never did. I've told people so for years. Maybe actually seeing the 
problems will make people realize.

So please, we shouldn't call "->suspend[_late]" or "->resume[_early]" at 
all. Not with PMSG_FREEZE, not with PMSG_*anything*.

Can we please get this fixed some day? 

		Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
