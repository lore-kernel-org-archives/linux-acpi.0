From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Sat, 1 Jan 2005 20:37:42 -0800 (PST)
Message-ID: <20050102043742.11965.qmail@web50205.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501011115460.26294-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0501011115460.26294-100000@netrider.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: acpi-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

My UHCI is sharing interrupt 9 with acpi.
IRQ 9 usage does increment after the resume.
And also, even after the resume, when the USB is not
seeing any device plugged in, if I unload and reload
the uhci-hcd, then it works.
Maybe, when I reload uhci-hcd, it does some
reinitialization of the usb controller.


--- Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, 29 Dec 2004, Paul Ionescu wrote:
> 
> > Hello Alan,
> > 
> > If I boot with "acpi=off" then I cannot use ACPI
> S3 to
> > suspend and resume, and my problem appears after
> an
> > ACPI S3 suspend/resume cycle.
> 
> This just occurred to me: After a suspend/resume,
> when the uhci_hcd driver
> doesn't recognize new devices being plugged in, can
> you tell if the
> interrupt count for the driver is changing?  If the
> host controller
> doesn't share an IRQ, the numbers in
> /proc/interrupts will tell the story.
> 
> As another test, what shows up in the debugging file
> for the controller?  
> Under 2.6.9 that file would be in the
> /proc/driver/uhci/ directory, but it
> was recently moved to the debugfs filesystem, and
> I'm not sure whether
> that move was done before or after 2.6.10 was
> released.
> 
> Alan Stern
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Jazz up your holiday email with celebrity designs. Learn more. 
http://celebrity.mail.yahoo.com


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
