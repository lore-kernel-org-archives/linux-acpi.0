From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: kernel 2.6.10 , uhci-hcd problem after ACPI
 S3 suspend.
Date: Fri, 31 Dec 2004 11:32:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0412311131420.26830-100000@netrider.rowland.org>
References: <20041229205319.17704.qmail@web50208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041229205319.17704.qmail@web50208.mail.yahoo.com>
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
Cc: linux-usb-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, 29 Dec 2004, Paul Ionescu wrote:

> --- Alan Stern <stern@rowland.harvard.edu> wrote:
>  
> > Nothing relevant has changed in the uhci_hcd driver,
> > so far as I know.  
> > I'd be inclined to guess that ACPI is the culprit. 
> > Have you tried booting 
> > with "acpi=off", in both 2.6.9 and 2.6.10?
> 
> Hello Alan,
> 
> If I boot with "acpi=off" then I cannot use ACPI S3 to
> suspend and resume, and my problem appears after an
> ACPI S3 suspend/resume cycle.

You could try something a little weaker, like "acpi=noirq".

Alan Stern



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
