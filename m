From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Sat, 1 Jan 2005 18:57:15 +0100
Message-ID: <20050101175715.GA1345@elf.ucw.cz>
References: <pan.2004.12.28.12.28.29.262637@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
Cc: acpi-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> With kernel 2.6.10, I have the following problem with uhci_hcd:
> After an ACPI S3 suspend it fails to see any USB device plugged in.
> If I unload the module and load it again, it works again.
> I hadn't this problem with previous kernels, where it worked just fine.
> Do you know something that changed between 2.6.9 and 2.6.10 that could
> lead to this behavior ?
> It is ACPI or USB fault ?

Does it work after swsusp? Can you try unloading module before suspend
and reloading it after resume?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
