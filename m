From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: ibm-acpi-0.1
Date: Sat, 14 Aug 2004 08:20:51 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040814152051.54002.qmail@web50209.mail.yahoo.com>
References: <200408141509.i7EF9v9K083464@sana.init-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408141509.i7EF9v9K083464-QgXWv67w4UhH1774QXjzbtBPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Takanori Watanabe <takawata-PURzwyb9WQGaMJb+Lgu22Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--- Takanori Watanabe <takawata-PURzwyb9WQGaMJb+Lgu22Q@public.gmane.org> wrote:

> >Right now, I am using the way you mentioned above,
> with the hotkey mask,
> >but it does not provide enough flexibility.
> >That is because now I can have one or another, but
> I cannot have both.
> >What should I do if I want to activate both
> bluetooth and wireless ?
> 
> Make wireless interface up and activate Bluetooth by
> executing 
> blutooth activating method:-).

To make wireless interface up, I need the hotkey
event.
Anyway, this will be solved in next release.

> 
> >I have to enable bluetooth AND have an hotkey event
> for activating the
> >wireless, because by default is taken care only of
> the USB bluetooth, but
> >nothing is done for the wireless.
> 
> Wireless LED seems to be connected to MINI PCI GPIO
> register.

I know.
Atheros drivers will take care of that if compiled
with a special option.



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
