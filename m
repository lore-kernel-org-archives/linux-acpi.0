From: Fabrice Bellet <fabrice@bellet.info>
Subject: Re: [Bug 1373] uhci-hcd fails after software suspend
Date: Thu, 4 Mar 2004 19:40:43 +0100
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <20040304184043.GA2412@bellet.info>
References: <200403041146.i24Bk6SN031296@fire-2.osdl.org> <Pine.LNX.4.44L0.0403041101080.969-100000@ida.rowland.org>
Reply-To: Fabrice Bellet <fabrice@bellet.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403041101080.969-100000@ida.rowland.org>
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2004 at 11:06:23AM -0500, Alan Stern wrote:
> [Can't reply to you via bugzilla because you're not registered on the CC: 
> list for this bug.]
> 
> > ------- Additional Comments From fabrice@bellet.info  2004-03-04 03:46 -------
> > This patch resolved the part of the problem warning me about "host controller
> > halted, very bad!" in my logs. But the external USB mouse still doesn't work
> > after resume from ACPI suspend (echo 3 > /proc/acpi/sleep). The file
> > /proc/driver/uhci/0000:00:1d.1 contains these differences :
> > 
> > before suspend :
> > 
> >   usbstat   =     0000   
> 
> That's a good value.
> 
> > and after suspend :
> >   usbstat   =     0001   USBINT 
> 
> USBINT means that the USB controller is trying to send an interrupt 
> request but the system isn't accepting it.
> 
> > Then I unplug the mouse :
> > 
> >   usbstat   =     0021   HCHalted USBINT 
> >   stat2     =     0080  
> > 
> > And I replug it :
> > 
> >   usbstat   =     0025   HCHalted ResumeDetect USBINT 
> >   stat2     =     0185   LowSpeed Enabled Connected
> 
> Same thing here.  This may be an interrupt routing problem, probably 
> something to do with ACPI support.

okay.
I also booted with pci=noacpi, just in case, and the same bug occurs.

-- 
fabrice


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
