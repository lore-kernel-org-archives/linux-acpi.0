From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem
 after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 17:27:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0501051727100.1001-100000@ida.rowland.org>
References: <20050105215951.45597.qmail@web50205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050105215951.45597.qmail@web50205.mail.yahoo.com>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, 5 Jan 2005, Paul Ionescu wrote:

> Hi Alan,
> 
> CONFIG_USB_SUSPEND is not set.
> Should I try to set it ? 
> I thought it is for something else from its attached
> help, that's why I left it unset.

No, leaving it unset is fine (and probably best, for the moment).  I just 
wanted to know whether or not you had set it.

Alan Stern



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
