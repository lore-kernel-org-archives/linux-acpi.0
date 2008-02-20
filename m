From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 12:41:30 -0800
Message-ID: <200802201241.30952.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802202114.43007.rjw@sisk.pl>
	<alpine.LFD.1.00.0802201224380.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.1.00.0802201224380.7833@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 20, 2008 12:29 pm Linus Torvalds wrote:
> On Wed, 20 Feb 2008, Rafael J. Wysocki wrote:
> > I think we should export the target sleep state somehow.
>
> Yeah. By *not* using "->suspend()" for freezing or hibernate.
>
> Please, Rafael - just make the f*cking suspend-to-disk use other routines
> already. 99% of all hardware needs to do exactly *nothing* on
> suspend-to-disk, and the ones that really do need things tend to need to
> not do a whole lot.

In talking with Rafael on IRC about this, I think we're agreed that we need 
separate entry points.  Even with a kexec based hibernate, we'll probably 
want ->hibernate callbacks so we don't end up shutting down the device.

The current callback system looks like this (according to Rafael and the last 
time I looked):
  ->suspend(PMSG_FREEZE)
  ->resume()
  ->suspend(PMSG_SUSPEND)
  *enter S3 or power off*
  ->resume()
The fact that we get suspend/resume called once before suspend again in the 
hibernate case is somewhat obnoxious, but it's even worse that we don't know 
what we're about to enter after ->suspend(PMSG_SUSPEND).  So in the short 
term it would be nice to at least get the target state exported.

And in the long term we could have:
  ->suspend()
  *enter S3*
  ->resume()
or:
  ->hibernate()
  *kexec to another kernel to save image*
  *power off*
  ->return_from_hibernate() (or somesuch)

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
