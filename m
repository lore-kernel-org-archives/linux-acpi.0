From: Takanori Watanabe <takawata-PURzwyb9WQGaMJb+Lgu22Q@public.gmane.org>
Subject: Re: Re: ibm-acpi-0.1
Date: Sun, 15 Aug 2004 00:36:06 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408141536.i7EFa66Y083568@sana.init-main.com>
References: <20040814152051.54002.qmail@web50209.mail.yahoo.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Sat, 14 Aug 2004 08:20:51 MST."
             <20040814152051.54002.qmail-k4S4SYk0aM6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <20040814152051.54002.qmail-k4S4SYk0aM6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>, Paul Ionescu 
wrote:

>> >Right now, I am using the way you mentioned above,
>> with the hotkey mask,
>> >but it does not provide enough flexibility.
>> >That is because now I can have one or another, but
>> I cannot have both.
>> >What should I do if I want to activate both
>> bluetooth and wireless ?
>> 
>> Make wireless interface up and activate Bluetooth by
>> executing 
>> blutooth activating method:-).
>
>To make wireless interface up, I need the hotkey
>event.
>Anyway, this will be solved in next release.


Hmm, SBDC, GBDC method under HKEY device may be related.
SBDC takes two mask value.( 0x2 seems Wireless lan related and
0x4 is Bluetooth attach method, it seems). 
I tried to activate wireless lan in my environment by calling the 
method.
But the wireless LED was not changed so I imageine that it is
not useless for wireless LAN. 
 
>> Wireless LED seems to be connected to MINI PCI GPIO
>> register.
>
>I know.
>Atheros drivers will take care of that if compiled
>with a special option.

Ok, I'm sorry.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
