From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem
 after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 16:27:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0501051555230.1001-100000@ida.rowland.org>
References: <20050105190441.77206.qmail@web50205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050105190441.77206.qmail@web50205.mail.yahoo.com>
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

> After resume, without any devices plugged:
> HC status
>   usbcmd    =     0008   Maxp32 EGSM 
>   usbstat   =     0020   HCHalted 
>   usbint    =     000f
>   usbfrnum  =   (0)344
>   flbaseadd = 173d8344
>   sof       =       40
>   stat1     =     0080  
>   stat2     =     0080  
> Frame List
> Skeleton QH's
> 
> After resume, with a device plugged:
> HC status
>   usbcmd    =     00c1   Maxp64 CF RS 
>   usbstat   =     0000   
>   usbint    =     000f
>   usbfrnum  =   (0)eb8
>   flbaseadd = 173d8eb8
>   sof       =       40
>   stat1     =     0080  
>   stat2     =     0093   ConnectChange Connected
> Frame List
> Skeleton QH's

Very interesting indeed.  This indicates that the problem isn't with the 
uhci-hcd driver but higher up in the USB stack.  It's also not an IRQ 
problem, as you have already realized.  In brief, uhci-hcd resumed 
correctly and received the appropriate interrupt when you plugged in the 
device.  But then the hub driver never got a corresponding status change 
event.  (Or else the khubd thread had died, which is quite possible.)

Can you build the USB drivers with CONFIG_USB_DEBUG=y, and post the 
dmesg log showing what happens following the suspend/resume + plug in a 
device?  Also, can you say whether or not CONFIG_USB_SUSPEND is set?  
Finally, after plugging in the device, can you get the Alt-SysRq-T stack 
trace for the khubd process?  (This may work out better if you switch to 
single-user mode and kill unnecessary daemons before doing the swsusp.)

Alan Stern



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
