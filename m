From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [linux-usb-devel] kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 09:40:41 -0800 (PST)
Message-ID: <20050106174041.70456.qmail@web50202.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501061038540.1024-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0501061038540.1024-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

Yes, I think it works as you expected.
I have CONFIG_USB_SUSPEND and CONFIG_USB_DEBUG, and
the behaviour is:

If ehci-hcd is not loaded but only uhci-hcd, suspend
and resume works just fine with and without USB
devices plugged in.

If ehci-hcd and uhci-hcd is loaded , suspend and
resume works as expected if there is no USB device
plugged at suspend/resume time, or if there are both
uhci (USB 1/1.1) and ehci (USB 2) devices. 
If there are only uhci devices (USB 1/1.1) when
suspending, they are not seen upon resume, unless I
unplug/replug them again.

Hmmm, interesting.


Thanks,
Paul

--- Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:

> On Wed, 5 Jan 2005, Paul Ionescu wrote:
> 
> > Hi Alan,
> > 
> > I just compiled a new kernel with both
> > CONFIG_USB_SUSPEND and CONFIG_USB_DEBUG, and now
> it
> > works if nothing is plugged in USB when I suspend
> the
> > machine.
> > If I have something plugged in at suspend time,
> after
> > resume it is not there anymore, and I have to
> > pull/plug the device again.
> 
> Just out of curiosity, does the same thing happen
> with CONFIG_USB_SUSPEND 
> if you rmmod ehci-hcd before suspending?  Does a
> device plugged in to the 
> UHCI controller continue to work after you resume?
> 
> Alan Stern
> 
> 



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
