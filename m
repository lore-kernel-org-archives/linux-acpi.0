From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 15:03:44 -0800
Message-ID: <200802201503.44656.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<b6a2187b0802201110k6e6c458dg6f48c586fff6187a@mail.gmail.com>
	<200802201432.13393.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802201432.13393.jesse.barnes@intel.com>
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

On Wednesday, February 20, 2008 2:32 pm Jesse Barnes wrote:
> On Wednesday, February 20, 2008 11:10 am Jeff Chua wrote:
> > On Feb 21, 2008 2:53 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> > > > So, next I'll try "shutdown" to see if it work. I was using
> > > > "platform".
> > >
> > > Ok, that would be good to try.
> >
> > "shutdown" does power down properly. But still green on resume.
> >
> > > Looks like the AR registers are hosed, which is what I thought I
> > > fixed... Can you attach your i915_drv.c file just so I can sanity check
> > > it?
> >
> > Attached.
>
> Jeff, for the hang on suspend problem, I know suspect something else in
> 2.6.25-rc2 caused that.

Looks like 2.6.25-rc1 also had broken suspend (my test was broken).  IIRC, 
Dave and I had it working at LCA using the out of tree DRM modules on 
2.6.23.14 or 15...  Maybe you could give that a try?

Thanks,
Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
