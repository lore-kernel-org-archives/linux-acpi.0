From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 19:48:57 +0100
Message-ID: <200501061948.57848.oliver@neukum.org>
References: <20050106182839.78516.qmail@web50208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050106182839.78516.qmail@web50208.mail.yahoo.com>
Content-Disposition: inline
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
Cc: linux-usb-devel@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, 6. Januar 2005 19:28 schrieb Paul Ionescu:
> Hi Oliver,
> 
> Yes, it works if rmmod ehci_hcd before suspending, but
> it was a time when there was no need to rmmod anything
> before suspending ( for me was something like 2.6.7 or
> around ).
> In 2.6.9 you cannot suspend anymore with ehci-hcd
> loaded, in 2.6.10 you can but you screw your uhci and
> sometime hang your usb stack.

This state of affairs is undesirable. It seems important to me to
establish that we both see the same effect.

	Regards
		Oliver


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
