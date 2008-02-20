From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 19:25:16 +0000
Message-ID: <20080220192516.GA24771@srcf.ucam.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
	<b6a2187b0802200954p1cccb01aqbc48c865797f0af1@mail.gmail.com>
	<alpine.LFD.1.00.0802201007300.7833@woody.linux-foundation.org>
	<b6a2187b0802201049r25959293r1e6b83ca67f65f04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <b6a2187b0802201049r25959293r1e6b83ca67f65f04@mail.gmail.com>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 21, 2008 at 02:49:39AM +0800, Jeff Chua wrote:

> Here's an interesting discovery. After I found that "echo reboot >
> /sys/power/disk" does reboot, I tried "echo shutdown >
> /sys/power/disk", it does shutdown properly.
> 
> With "platform" it refuses to shutdown. Both reboot and shutdown still
> end up with Mr. Green at resume.

That kind of suggests that the ACPI platform code is hitting the 
hardware directly - we've seen similar issues with PATA controllers. The 
right thing to do here is almost certainly just to avoid explicitly 
powering down hardware on hibernation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
