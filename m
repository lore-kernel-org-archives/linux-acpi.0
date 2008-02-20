From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 14:19:10 +0800
Message-ID: <b6a2187b0802192219k76153d8dsd3fa9c80d9e8e1f7@mail.gmail.com>
References: <b6a2187b0802191653q4dfaa32cl96b9278e97606ef0@mail.gmail.com>
	<200802191700.12050.jesse.barnes@intel.com>
	<alpine.LFD.1.00.0802191827190.7833@woody.linux-foundation.org>
	<200802192032.44715.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802192032.44715.jesse.barnes@intel.com>
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
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Feb 20, 2008 12:32 PM, Jesse Barnes <jesse.barnes@intel.com> wrote:
>
> On Tuesday, February 19, 2008 6:28 pm Linus Torvalds wrote:
> > On Tue, 19 Feb 2008, Jesse Barnes wrote:
> > > I found the same poweroff issue on my T61.  It turned out to be related
> > > to the C state code disabling interrupts when it shouldn't iirc.  Booting
> > > with 'idle=poll' seems to work around the problem.
> > >
> > > The "green screen" problem should be fixed (see the DRM git tree for
> > > details).
> Jeff, can you retest with Linus' tree?  If you're still seeing problems, it
> might help to add some printks to the i915 driver's suspend routine.  Just
> reading the regs really shouldn't cause a hang, but maybe the VGA bits are
> subtly wrong again...

The funny thing is the screen is now normal during suspend, but the
green came back after suspend!

And the suspend still does NOT power off with lastest Linus's tree.

I'll try the "idle=poll" to see if that works and will try some printk as well.

Thanks,
Jeff.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
