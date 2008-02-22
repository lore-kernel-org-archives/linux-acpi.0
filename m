From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 01:54:56 +0100
Message-ID: <200802220154.57051.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802220131.09525.rjw@sisk.pl>
	<alpine.LFD.1.00.0802211643140.19896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.1.00.0802211643140.19896@woody.linux-foundation.org>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Friday, 22 of February 2008, Linus Torvalds wrote:
> 
> On Fri, 22 Feb 2008, Rafael J. Wysocki wrote:
> >  
> > -	if (state.event == PM_EVENT_SUSPEND) {
> > +	if (state.event == PM_EVENT_SUSPEND && !in_hibernation_power_off()) {
> 
> I don't understand why hibernation just doesn't use a PM_EVENT_HIBERNATE, 
> and be done with it?
> 
> Why should it be called PM_EVENT_SUSPEND when it isn't?
> 
> Adding some external global variables is absolutely the wrong way to fix 
> this.
> 
> It's not even like there are very many drivers who actually care about 
> "state.event" anyway: a 'git grep' returns just 35 users in the whole 
> tree, so if this was done this ugly way just to avoid double-chcking the 
> other cases that compare against PM_EVENT_SUSPEND, then it really wasn't 
> worth it.

Please relax, we're debugging the thing right now and the patch doesn't
even seem to help on the other affected box.

The issue appears to be more complicated than we initially thought.

Thanks,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
