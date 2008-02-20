From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 09:52:08 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802200945591.7833@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
	<b6a2187b0802200937q3ff8f470k235b5d1e00eab59e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6a2187b0802200937q3ff8f470k235b5d1e00eab59e@mail.gmail.com>
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
> Works without those two functions.

Ahh. You're using the BIOS to re-initialize your video, aren't you? 

If STR works without X, then you have something else resuming graphics, 
and that may be what then interacts badly with the fact that the kernel 
also does so. 

> Ok, what's next?

Let's try to narrow it down to what the interaction is. Are you using 
something like acpi_sleep=s3_bios or similar? That's what the kernel 
support is supposed to make unnecessary in the long run, along with all 
the video mode flickering (ie we should be able to resume to the video 
mode we want, not flicker through unnecessary modes).

			Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
