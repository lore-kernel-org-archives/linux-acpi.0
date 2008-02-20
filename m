From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 09:28:54 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org



On Thu, 21 Feb 2008, Jeff Chua wrote:
> 
> After inserting "return 0;" right at the top of those two functions, suspend
> (and power-off properly), and resume (without green screen) works just fine.
> 
> I would like to know what they're for.

Try suspend-and-resume without X.

Also, try it on one of the more modern laptops - even *with* X.

Basically, the kernel wants to be able to do what X does, because it means 
that when it works, it works _so_ much better than doing it in X. So 
getting it working is definitely worth it.

That said, before you do anything else, try if suspend-to-RAM works. 

That's the primary goal for this code anyway, and if it works that gives a 
good hint. Suspend-to-disk is fundamentally different, and it's entirely 
possible that for the suspend-to-disk case we should just say "screw 
trying to suspend/resume graphics", since you'll have the BIOS resuming 
text-mode anyway, and there are no performance or debugging advantages.

		Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
