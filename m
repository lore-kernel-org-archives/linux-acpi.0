From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [linux-usb-devel] kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 13:59:50 -0800 (PST)
Message-ID: <20050105215951.45597.qmail@web50205.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501051555230.1001-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0501051555230.1001-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB development list <linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

CONFIG_USB_SUSPEND is not set.
Should I try to set it ? 
I thought it is for something else from its attached
help, that's why I left it unset.

Thanks,
Paul

--- Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:

> Very interesting indeed.  This indicates that the
> problem isn't with the 
> uhci-hcd driver but higher up in the USB stack. 
> It's also not an IRQ 
> problem, as you have already realized.  In brief,
> uhci-hcd resumed 
> correctly and received the appropriate interrupt
> when you plugged in the 
> device.  But then the hub driver never got a
> corresponding status change 
> event.  (Or else the khubd thread had died, which is
> quite possible.)
> 
> Can you build the USB drivers with
> CONFIG_USB_DEBUG=y, and post the 
> dmesg log showing what happens following the
> suspend/resume + plug in a 
> device?  Also, can you say whether or not
> CONFIG_USB_SUSPEND is set?  
> Finally, after plugging in the device, can you get
> the Alt-SysRq-T stack 
> trace for the khubd process?  (This may work out
> better if you switch to 
> single-user mode and kill unnecessary daemons before
> doing the swsusp.)
> 
> Alan Stern
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
