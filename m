From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Sun, 2 Jan 2005 20:02:08 +0100
Message-ID: <20050102190208.GB2473@openzaurus.ucw.cz>
References: <20050101175715.GA1345@elf.ucw.cz> <20050102043601.63276.qmail@web50202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050102043601.63276.qmail@web50202.mail.yahoo.com>
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
Cc: Pavel Machek <pavel@ucw.cz>, acpi-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> I don't have swsusp compiled in, but if I unload and
> reload the module, then it works.
> Anyway, this is not the intended behaviour, as it
> worked fine till 2.6.10 without unload/reload.

Yes it is a bug. Find which changeset causes it and complain to its author.
It is probably going to be some usb change.

> > > With kernel 2.6.10, I have the following problem
> > with uhci_hcd:
> > > After an ACPI S3 suspend it fails to see any USB
> > device plugged in.
> > > If I unload the module and load it again, it works
> > again.
> > > I hadn't this problem with previous kernels, where
> > it worked just fine.
> > > Do you know something that changed between 2.6.9
> > and 2.6.10 that could
> > > lead to this behavior ?
> > > It is ACPI or USB fault ?
> > 
> > Does it work after swsusp? Can you try unloading
> > module before suspend
> > and reloading it after resume?
> > 			
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
