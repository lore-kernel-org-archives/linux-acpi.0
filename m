From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 08:46:55 -0800 (PST)
Message-ID: <20050105164655.45860.qmail@web50204.mail.yahoo.com>
References: <1104862529.1846.47.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <1104862529.1846.47.camel@eeyore>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Ionescu <i_p_a_u_l@yahoo.com>, linux-usb-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

I tried with "pci=routeirq" but the same behaviour.
Then I isolate uhci_hcd to be alone on IRQ 9, and I
can see that after a susp/resume cycle, the irq 9
count is still incrementing, but lsusb shows no new
device.
If I rmmod/insmod the uhci-hcd at this point, it
works.
So I think is not an IRQ problem.

Thanks,
Paul

--- Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Tue, 2004-12-28 at 22:11 -0500, Alan Stern wrote:
> > On Tue, 28 Dec 2004, Paul Ionescu wrote:
> > 
> > > Hello all,
> > > 
> > > With kernel 2.6.10, I have the following problem
> with uhci_hcd:
> > > After an ACPI S3 suspend it fails to see any USB
> device plugged in.
> > > If I unload the module and load it again, it
> works again.
> > > I hadn't this problem with previous kernels,
> where it worked just fine.
> > > Do you know something that changed between 2.6.9
> and 2.6.10 that could
> > > lead to this behavior ?
> > > It is ACPI or USB fault ?
> > 
> > Nothing relevant has changed in the uhci_hcd
> driver, so far as I know.  
> > I'd be inclined to guess that ACPI is the culprit.
>  Have you tried booting 
> > with "acpi=off", in both 2.6.9 and 2.6.10?
> 
> You might also try "pci=routeirq".  This works
> around some known
> issues with suspend/resume in 2.6.10.
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
