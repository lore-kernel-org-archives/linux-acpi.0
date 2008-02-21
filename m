From: david@lang.hm
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 08:30:06 +0000 (GMT)
Message-ID: <alpine.LFD.1.00.0802210819560.1777@xo-0C-FC-0F.localdomain>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802201241.30952.jesse.barnes@intel.com>
	<alpine.LFD.1.00.0802201256040.7833@woody.linux-foundation.org>
	<200802201344.11643.jesse.barnes@intel.com>
	<alpine.LFD.1.00.0802201355590.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.1.00.0802201355590.7833@woody.linux-foundation.org>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 Feb 2008, Linus Torvalds wrote:

>> Well, it seems like we'll have to fix drivers in either case, and isn't a
>> kexec approach fundamentally more sound and simple, design-wise?  Rafael
>> pointed out some problems with properly setting wakeup states, but I think
>> that could be overcome...
>
> I don't personally mind kexec at all, but on the other hand, I don't care
> about suspend-to-disk in the first place. I do know that some people
> really don't want it, and I suspect that they have valid reasons. Ranging
> from memory use to simply just performance.

I've been watching for kexec hibernate for a little while now, and the 
last I saw was that acpi was incompatible with the kexec hibernate (but 
the suspend folks were still claiming that devices needed to be put in the 
'right mode' not just powered off. I've been waiting to see this resolved.

David Lang

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
