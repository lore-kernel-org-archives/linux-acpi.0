From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 10:36:18 -0800 (PST)
Message-ID: <20050106183618.78481.qmail@web50201.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
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

After some more testing, I noticed that if I suspend
with only UHCI loaded, it works fine.
If I suspend with only EHCI loaded, it works fine.
If I suspend with both UHCI and EHCI loaded, I run in
the problems we talked about.
When I say "works fine" that means that
suspends/resumes 
with and without USB devices plugged in.

Thanks,
Paul.


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
