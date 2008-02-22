From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 02:06:41 +0100
Message-ID: <200802220206.43024.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<b6a2187b0802211642i7f4cd764ocb5a66b49de78875@mail.gmail.com>
	<b6a2187b0802211701p59b427aft694ace922e8c3c90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6a2187b0802211701p59b427aft694ace922e8c3c90@mail.gmail.com>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, 22 of February 2008, Jeff Chua wrote:
> On Fri, Feb 22, 2008 at 8:42 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> > On Fri, Feb 22, 2008 at 8:31 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> >  >  Jeff, can you please test hibernation with the patch I've just sent to Jesse
> >  >  (reproduced below for convenience)?
> >
> >  Testing now.
> 
> Great news. It works. STD (platform) does not hang at suspend. And the
> annoying green is gone! STR still works.

Great, thanks for testing.

If Jesse confirms that it also works for him, I'll prepare a cleaner final fix
tomorrow.

Thanks,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
