From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Tue, 19 Feb 2008 18:28:26 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802191827190.7833@woody.linux-foundation.org>
References: <b6a2187b0802191653q4dfaa32cl96b9278e97606ef0@mail.gmail.com>
	<200802191700.12050.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802191700.12050.jesse.barnes@intel.com>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Tue, 19 Feb 2008, Jesse Barnes wrote:
>
> I found the same poweroff issue on my T61.  It turned out to be related to the 
> C state code disabling interrupts when it shouldn't iirc.  Booting 
> with 'idle=poll' seems to work around the problem.
> 
> The "green screen" problem should be fixed (see the DRM git tree for details).

..and the latter is hopefully now merged in my tree too (at least some of 
the drm updates are).

		Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
