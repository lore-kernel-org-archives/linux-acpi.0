From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off
 aftersuspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 16:46:33 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802211643140.19896@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211302.27002.jesse.barnes@intel.com>
	<b6a2187b0802211620q47f6601fuf7e88395d89b90c8@mail.gmail.com>
	<200802220131.09525.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802220131.09525.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org



On Fri, 22 Feb 2008, Rafael J. Wysocki wrote:
>  
> -	if (state.event == PM_EVENT_SUSPEND) {
> +	if (state.event == PM_EVENT_SUSPEND && !in_hibernation_power_off()) {

I don't understand why hibernation just doesn't use a PM_EVENT_HIBERNATE, 
and be done with it?

Why should it be called PM_EVENT_SUSPEND when it isn't?

Adding some external global variables is absolutely the wrong way to fix 
this.

It's not even like there are very many drivers who actually care about 
"state.event" anyway: a 'git grep' returns just 35 users in the whole 
tree, so if this was done this ugly way just to avoid double-chcking the 
other cases that compare against PM_EVENT_SUSPEND, then it really wasn't 
worth it.

		Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
