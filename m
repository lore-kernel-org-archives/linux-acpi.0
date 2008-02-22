From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 17:02:01 -0800
Message-ID: <200802211702.02306.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211646.31603.jesse.barnes@intel.com>
	<b6a2187b0802211652x304daa2ci36a76a76a2fcb82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6a2187b0802211652x304daa2ci36a76a76a2fcb82@mail.gmail.com>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, February 21, 2008 4:52 pm Jeff Chua wrote:
> On Fri, Feb 22, 2008 at 8:46 AM, Jesse Barnes <jesse.barnes@intel.com> 
wrote:
> >  Your s2ram script is doing your STD also?  Seems counterintuitive. 
> > Anyway, some machines also re-POST the GPU on resume from S3; maybe yours
> > is doing that.
>
> It's s2ram to do STR, not STD. Sorry for the confusion. But the key
> point is there's no GREEN for STR. Mr Green only appear with STD.

Ah, ok that makes sense.

So typically, what you'd see at suspend time is this ugly call chain:

1) user requests suspend or hibernate
2) kernel kicks users off VT
3) X calls LeaveVT function of X driver
4) X driver restores whatever video state it felt like saving when it started 
up
5) kernel calls suspend methods
6) machine goes to sleep

then on resume:

1) user requests wakeup
2) kernel calls resume methods
3) X takes back the VT, calling driver EnterVT methods
4) X driver EnterVT routine runs, doing whatever it wants
5) you're back to where you were (on a good day anyway)

So, on your machine, I suspect your firmware is doing enough that X doesn't 
have to save/restore full video state around Enter/Leave VT (the same 
functions called at VT switch time when you press ctl-alt-fx), otherwise 
you'd be missing things like your backlight or text consoles.

So the advantage of the kernel suspend/resume hooks for the DRM layer is that 
the kernel video drivers can do full state save/restore (which X usually 
doesn't do, and isn't really designed to do), so that if your platform 
*doesn't* do it all, you'll still end up with a usable machine in the end.

The fact that you'd started running into problems since we merged this just 
means your platform was taking care of it for you (lucky you) and that we 
have some bugs in the hibernate code that we're just discovering.

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
