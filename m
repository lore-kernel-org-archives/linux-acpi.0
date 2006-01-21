From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: 2.6.15-mm3 [USB lost interrupt bug]
Date: Fri, 20 Jan 2006 21:47:23 -0800
Message-ID: <20060120214723.79111715.akpm@osdl.org>
References: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>
	<43D1C4E9.7030901@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <43D1C4E9.7030901@reub.net>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, jgarzik@pobox.com, greg@kroah.com, linux-usb-devel@lists.sourceforge.net, neilb@cse.unsw.edu.au, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> 
> 
> On 16/01/2006 4:46 p.m., Alan Stern wrote:
> > On Mon, 16 Jan 2006, Reuben Farrelly wrote:
> > 
> >>> From the information presented here, it looks like -mm1 correctly routes
> >>> the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
> >>> -mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
> >>> it an ACPI problem.
> >> Is this likely to be the same or similar issue to the IRQ 0 problem I see quite 
> >> frequently on the SATA ports on later -mm releases?
> >> (see http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1851.html)
> > 
> > I doubt they are at all related.  In the USB problem the resource is there 
> > but ACPI is routing it wrongly.  In the SATA problem the resource isn't 
> > there to begin with.
> > 
> > But then I know almost nothing about ACPI, so I could be wrong...
> > 
> > Alan Stern
> 
> Some good news.  I think it's fixed in 2.6.16-rc1-mm2.  In fact a whole boatload 
> of problems I was having are fixed in this -mm release, including a nasty libata 
> oops that seemed to have a few people scratching their heads.

OK, but probably that libata error-path bug is still in there.  It's just
that you're no longer taking the error paths.  And now we've lost our means
to reproduce it.

> I've now done in excess of 20 reboots with this code and haven't had either 
> problem show up at all.
> 
> So for now I'll keep a record of things for a bit longer, but I guess I've 
> reason to be fairly confident that both this USB/IRQ problem and my ATA/IRQ 
> problem are now fixed.
> 
> It does make me wonder if the ACPI update in rc1-mm2 fixed it, and was actually 
> the cause of most of my problems......it would be nice to know for sure.

We probably won't know.  Did you ever test 2.6.16-rc1 plus 2.6.16-rc1-mm1's
acpi.patch?  If that plays up we'd have confirmation.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
