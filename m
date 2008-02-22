From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 08:52:09 +0800
Message-ID: <b6a2187b0802211652x304daa2ci36a76a76a2fcb82@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211623.55450.jesse.barnes@intel.com>
	<b6a2187b0802211642i17730ccav6744b614c086df72@mail.gmail.com>
	<200802211646.31603.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802211646.31603.jesse.barnes@intel.com>
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
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 22, 2008 at 8:46 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:

>  Your s2ram script is doing your STD also?  Seems counterintuitive.  Anyway,
>  some machines also re-POST the GPU on resume from S3; maybe yours is doing
>  that.

It's s2ram to do STR, not STD. Sorry for the confusion. But the key
point is there's no GREEN for STR. Mr Green only appear with STD.

Thanks,
Jeff.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
