From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 11:07:19 -0800 (PST)
Message-ID: <20050105190719.90405.qmail@web50203.mail.yahoo.com>
References: <200501051757.40967.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501051757.40967.stefandoesinger@gmx.at>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: acpi-devel@lists.sourceforge.net
Cc: Paul Ionescu <i_p_a_u_l@yahoo.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Alan Stern <stern@rowland.harvard.edu>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi Stefan,

I tried with and without ehci-hcd loaded.
In fact, right now on kernel 2.6.10, only ehci-hcd is
surviving a suspend resume cycle without rmmod/insmod.


--- Stefan Dösinger <stefandoesinger@gmx.at> wrote:

> Am Mittwoch, 5. Januar 2005 17:46 schrieb Paul
> Ionescu:
> > Hi Bjorn,
> >
> > I tried with "pci=routeirq" but the same
> behaviour.
> > Then I isolate uhci_hcd to be alone on IRQ 9, and
> I
> > can see that after a susp/resume cycle, the irq 9
> > count is still incrementing, but lsusb shows no
> new
> > device.
> > If I rmmod/insmod the uhci-hcd at this point, it
> > works.
> > So I think is not an IRQ problem.
> >
> Is ehci-hcd loaded? I have to reload ehci-hcd to
> make USB working.
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
