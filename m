From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 10:28:39 -0800 (PST)
Message-ID: <20050106182839.78516.qmail@web50208.mail.yahoo.com>
References: <200501061755.02272.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501061755.02272.oliver@neukum.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Ionescu <i_p_a_u_l@yahoo.com>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi Oliver,

Yes, it works if rmmod ehci_hcd before suspending, but
it was a time when there was no need to rmmod anything
before suspending ( for me was something like 2.6.7 or
around ).
In 2.6.9 you cannot suspend anymore with ehci-hcd
loaded, in 2.6.10 you can but you screw your uhci and
sometime hang your usb stack.

--- Oliver Neukum <oliver@neukum.org> wrote:

> Am Donnerstag, 6. Januar 2005 16:40 schrieb Alan
> Stern:
> > On Wed, 5 Jan 2005, Paul Ionescu wrote:
> > 
> > > Hi Alan,
> > > 
> > > I just compiled a new kernel with both
> > > CONFIG_USB_SUSPEND and CONFIG_USB_DEBUG, and now
> it
> > > works if nothing is plugged in USB when I
> suspend the
> > > machine.
> > > If I have something plugged in at suspend time,
> after
> > > resume it is not there anymore, and I have to
> > > pull/plug the device again.
> > 
> > Just out of curiosity, does the same thing happen
> with CONFIG_USB_SUSPEND 
> > if you rmmod ehci-hcd before suspending?  Does a
> device plugged in to the 
> > UHCI controller continue to work after you resume?
> 
> Rmmoding ehci_hcd before suspend results in a system
> working
> flawlessly for me.
> 
> 	Regards
> 		Oliver
> 



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
