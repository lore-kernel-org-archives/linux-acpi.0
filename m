From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 14:58:30 -0800 (PST)
Message-ID: <20050105225830.87545.qmail@web50207.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501051727100.1001-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0501051727100.1001-100000@ida.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
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

Hi Alan,

I just compiled a new kernel with both
CONFIG_USB_SUSPEND and CONFIG_USB_DEBUG, and now it
works if nothing is plugged in USB when I suspend the
machine.
If I have something plugged in at suspend time, after
resume it is not there anymore, and I have to
pull/plug the device again.

I will try to compile only with CONFIG_USB_DEBUG, to
see what happens.



--- Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, 5 Jan 2005, Paul Ionescu wrote:
> 
> > Hi Alan,
> > 
> > CONFIG_USB_SUSPEND is not set.
> > Should I try to set it ? 
> > I thought it is for something else from its
> attached
> > help, that's why I left it unset.
> 
> No, leaving it unset is fine (and probably best, for
> the moment).  I just 
> wanted to know whether or not you had set it.
> 
> Alan Stern
> 
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
