From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem
 after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 10:40:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0501061038540.1024-100000@ida.rowland.org>
References: <20050105225830.87545.qmail@web50207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050105225830.87545.qmail@web50207.mail.yahoo.com>
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
> I just compiled a new kernel with both
> CONFIG_USB_SUSPEND and CONFIG_USB_DEBUG, and now it
> works if nothing is plugged in USB when I suspend the
> machine.
> If I have something plugged in at suspend time, after
> resume it is not there anymore, and I have to
> pull/plug the device again.

Just out of curiosity, does the same thing happen with CONFIG_USB_SUSPEND 
if you rmmod ehci-hcd before suspending?  Does a device plugged in to the 
UHCI controller continue to work after you resume?

Alan Stern



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
