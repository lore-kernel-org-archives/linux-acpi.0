From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Tue, 19 Feb 2008 17:00:11 -0800
Message-ID: <200802191700.12050.jesse.barnes@intel.com>
References: <b6a2187b0802191653q4dfaa32cl96b9278e97606ef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6a2187b0802191653q4dfaa32cl96b9278e97606ef0@mail.gmail.com>
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

I found the same poweroff issue on my T61.  It turned out to be related to the 
C state code disabling interrupts when it shouldn't iirc.  Booting 
with 'idle=poll' seems to work around the problem.

The "green screen" problem should be fixed (see the DRM git tree for details).

Jesse

On Tuesday, February 19, 2008 4:53 pm Jeff Chua wrote:
> On Feb 16, 2008 5:00 AM, Greg KH <gregkh@suse.de> wrote:
> > > Also, I've tried CONFIG_DETECT_SOFTLOCKUP=n, but this doesn't fix it
> > > either.
> >
> > Ok, this looks to be something else.
> >
> > > Here's the last dmesg after suspend-to-disk and hang there...
> > >
> > > CPU 1 is now offline
> > > SMP alternatives: switching to UP code
> > > PM: Syncing filesystems ... done.
> > > Freezing user space processes ... (elapsed 0.00 seconds) done.
> > > Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> > > PM: Shrinking memory...  ^H-^Hdone (0 pages freed)
> > > PM: Freed 0 kbytes in 0.10 seconds (0.00 MB/s)
> > > ACPI: Preparing to enter system sleep state S4
> > > Suspending console(s)
> > >
> > > [ ... it just hangs here ... press power-switch does the job, and
> > > system is able to resume upon powering on ]
> >
> > Wait, this is a suspend-to-disk issue.  Totally different than the "will
> > not power off" issue.
> >
> > Can you start a new thread on this, and add the suspend people to it?
>
> I bisected down this one commit that causes the problem with
> suspend-to-disk on Lenovo X60s (i945 chipset).
>
> commit ba8bbcf6ff4650712f64c0ef61139c73898e2165
> Author: Jesse Barnes <jesse.barnes@intel.com>
> Date:   Thu Nov 22 14:14:14 2007 +1000
>
>     i915: add suspend/resume support
>
>     Add suspend/resume support to the i915 driver.  Moves some of the
>     initialization into the driver load routine, and fixes up places where
> we assumed no dev_private existed in some of the cleanup paths.  This
> allows us to suspend/resume properly even if X isn't running.
>
>     Signed-off-by: Dave Airlie <airlied@linux.ie>
>
>
> There where problem reverting the some i915 files with the latest
> linux git pull, so I copied those i915*.{h,c} prior to this commit,
> and problem went away.
>
>
> Suspend-to-ram, suspend-to-disk all working now.
>
>
> Thanks,
> Jeff.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
