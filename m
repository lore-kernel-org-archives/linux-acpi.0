From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 13:02:26 -0800
Message-ID: <200802211302.27002.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<b6a2187b0802201002t315548b5uac623759723842d0@mail.gmail.com>
	<1203623002.3420.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1203623002.3420.6.camel@localhost>
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
To: Romano Giannetti <romano@dea.icai.upcomillas.es>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, February 21, 2008 11:43 am Romano Giannetti wrote:
> > > Let's try to narrow it down to what the interaction is. Are you using
> > > something like acpi_sleep=s3_bios or similar?
> >
> > No. Not additional command line option except for resume=/dev/sda3
> > reboot=bios
>
> My laptop (a Toshiba satellite U305, intel 945GM chipset, used to need
> s2ram -f -p -m to STR correctly. In 2.6.25-rc2 I can simply STR with
> echo mem > /sys/power/state.

Cool, glad to hear at least one success report. :)

> This communication contains confidential information. It is for the
> exclusive use of the intended addressee. If you are not the intended
> addressee, please note that any form of distribution, copying or use of
> this communication or the information in it is strictly prohibited by law.
> If you have received this communication in error, please immediately notify
> the sender by reply e-mail and destroy this message. Thank you for your
> cooperation.

Really?  This contains confidential information?  I'd better notify you and 
destroy this message now... :)

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
