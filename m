From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off
 aftersuspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 17:28:53 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802211723510.19896@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211646.31603.jesse.barnes@intel.com>
	<b6a2187b0802211652x304daa2ci36a76a76a2fcb82@mail.gmail.com>
	<200802211702.02306.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802211702.02306.jesse.barnes@intel.com>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Thu, 21 Feb 2008, Jesse Barnes wrote:
> 
> So the advantage of the kernel suspend/resume hooks for the DRM layer is that 
> the kernel video drivers can do full state save/restore (which X usually 
> doesn't do, and isn't really designed to do), so that if your platform 
> *doesn't* do it all, you'll still end up with a usable machine in the end.

Well, I'm also hoping that eventually we could even just not do the VT 
switch at all, and the kernel can treat X as "just another user process" 
that it freezes.

At least from a mode setting standpoint.

We'd still want to make sure that X repaints the screen if the contents 
were lost, of course. And this is going to depend very intimately on the 
type of graphics card and whether the video RAM is saved by STR or not - 
for the Intel integrated graphics kind of situation, the video RAM will be 
refreshed along with all the other memory, but for other cards we may end 
up having to do the VT switch not so much for modesetting reasons as just 
a way to get X to save and restore all the *other* state.

How close is the i915 driver from not having to even signal X? Or is that 
just a pipedream of mine?

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
