From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 05:55:06 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040810125506.38235.qmail@web50210.mail.yahoo.com>
References: <1092138355.16885.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092138355.16885.11.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

As far as I remember, I had the same problems with
2.4.26. But I will try 2.4.27 these days.

You can easily try on your computer to do:
idectl 1 off
idectl 1 on

now see if hdparm -D1 /dev/hdc works anymore (assuming
you have something on /dev/hdc)

and also you will have two of ide1 in /proc/ide

Just give it a try if you have 2.4.x kernel.

Thanks,
Paul

--- Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:

> On Maw, 2004-08-10 at 12:49, Paul Ionescu wrote:
> > station. I also use idectl to enable my cdrom or
> secondary hard-disk in
> > the UltraBay slim, but I have the following
> problems: DMA is not working
> > any more for hdc after "idectl 1 rescan" After
> some rescan cycles I will
> > have a lot of ide1 in /proc/ide/
> > 
> > See http://bugme.osdl.org/show_bug.cgi?id=2261
> 
> The 2.4 kernel supports IDE device hotplugging. The
> 2.6 maintainer has
> consistently refused to merge the change because
> some bits are ugly
> but hasn't done anything else to move it forward
> either.
> 
> You need 2.4 for the ultrabay stuff to work properly
> right now.
> 
> Alan
> 
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
