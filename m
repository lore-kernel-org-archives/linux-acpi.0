From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 11:18:08 -0800
Message-ID: <200802201118.08468.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802201053.16218.jesse.barnes@intel.com>
	<b6a2187b0802201110k6e6c458dg6f48c586fff6187a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6a2187b0802201110k6e6c458dg6f48c586fff6187a@mail.gmail.com>
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

On Wednesday, February 20, 2008 11:10 am Jeff Chua wrote:
> On Feb 21, 2008 2:53 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> > > So, next I'll try "shutdown" to see if it work. I was using "platform".
> >
> > Ok, that would be good to try.
>
> "shutdown" does power down properly. But still green on resume.

Ok, so Linus' theory about something later in the resume path trying to touch 
video is looking good.

Rafael, is there anyway to prevent the device shutdown in the hibernate path?

> > Looks like the AR registers are hosed, which is what I thought I fixed...
> >  Can you attach your i915_drv.c file just so I can sanity check it?
>
> Attached.

Hm, looks right.  Let me see if I can reproduce this on my T61.

Thanks,
Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
