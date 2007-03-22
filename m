From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 8249] New: NMI watchdog
 detected LOCKUP when plugging USB devices with acpi=off
Date: Thu, 22 Mar 2007 10:49:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703221047300.3605-100000@iolanthe.rowland.org>
References: <20070321175624.GA10891@xanadu.blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070321175624.GA10891@xanadu.blop.info>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-usb-devel@lists.sourceforge.net, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Mar 2007, Lucas Nussbaum wrote:

> On 21/03/07 at 08:41 -0800, Andrew Morton wrote:
> > On Wed, 21 Mar 2007 07:18:45 -0700 bugme-daemon@bugzilla.kernel.org wrote:
> > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=8249
> > > 
> > >            Summary: NMI watchdog detected LOCKUP when plugging USB devices
> > >                     with acpi=off
> > >     Kernel Version: 2.6.21-rc4
> > >             Status: NEW
> > >           Severity: high
> > >              Owner: greg@kroah.com
> > >          Submitter: lucas@lucas-nussbaum.net
> > > 
> > > 
> > > Most recent kernel where this bug did *NOT* occur: none, as far as I know
> > > Problem Description:
> > > 
> > > My kernel is running with acpi=off to workaround another bug. When I turn on my
> > > USB printer (a Canon PIXMA MP750), I get this on the serial console:

It looks like your problem occurs either as a result of the USB printer
driver's actions or as a result of HAL.  You could try turning off the HAL
daemon and renaming the usblp.ko file so that it won't get loaded
automatically.  Then after plugging in the printer you could insmod the
renamed driver file by hand, and see whether that causes the oops.  Then
start HAL by hand and see whether that causes the oops.

Alan Stern


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
