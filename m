From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: kernel 2.6.10 , uhci-hcd problem after ACPI
 S3 suspend.
Date: Tue, 28 Dec 2004 22:11:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0412282208440.19400-100000@netrider.rowland.org>
References: <pan.2004.12.28.12.28.29.262637@yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <pan.2004.12.28.12.28.29.262637@yahoo.com>
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

On Tue, 28 Dec 2004, Paul Ionescu wrote:

> Hello all,
> 
> With kernel 2.6.10, I have the following problem with uhci_hcd:
> After an ACPI S3 suspend it fails to see any USB device plugged in.
> If I unload the module and load it again, it works again.
> I hadn't this problem with previous kernels, where it worked just fine.
> Do you know something that changed between 2.6.9 and 2.6.10 that could
> lead to this behavior ?
> It is ACPI or USB fault ?

Nothing relevant has changed in the uhci_hcd driver, so far as I know.  
I'd be inclined to guess that ACPI is the culprit.  Have you tried booting 
with "acpi=off", in both 2.6.9 and 2.6.10?

Alan Stern



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
