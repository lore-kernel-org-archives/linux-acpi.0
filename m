From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 09:50:52 -0800
Message-ID: <200802200950.53591.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
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
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 20, 2008 9:17 am Jeff Chua wrote:
> On Feb 20, 2008 2:19 PM, Jeff Chua
>
> > I'll try the "idle=poll" to see if that works and will try some printk
>
> I don't know what exactly the i915_suspend() and i915_resume() are
> supposed to do because it works better without them.
>
> After inserting "return 0;" right at the top of those two functions,
> suspend (and power-off properly), and resume (without green screen) works
> just fine.
>
> I would like to know what they're for.

They're for saving and restoring GPU state across suspend/resume.  They're 
particularly useful if your machine doesn't re-POST at resume time.  In that 
case your GPU may be totally uninitialized, so either the kernel or X has to 
set it up for you (X only does that partially).

> Tested suspend-to-ram, and suspend-to-disk, both console and X on notebook
> internal LCD display, all works without these two functions.
>
> But, anyway, got down to just one line in i915_drv.c causing the hang
> during suspend. "pci_set_power_state(dev->pdev, PCI_D3hot);".

Interesting, which chipset do you have?  AFAIK that shouldn't cause a hang.

> And green screen problem during resume is caused by i915_restore_vga(dev);

I know I fixed that problem in at least one configuration...  Can you try:
  # echo test > /sys/power/disk
  # echo disk > /sys/power/state
and see if that also turns your screen green?

Also, getting a GPU register dump would be helpful.  The intel_reg_dumper tool 
is built as part of the xf86-video-driver build 
(git://anongit.freedesktop.org/git/xorg/driver/xf86-video-intel), can you 
pull that down and try it out?

Thanks,
Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
