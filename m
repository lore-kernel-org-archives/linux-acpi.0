From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: Re: Slightly OT: Battery usage
Date: Tue, 7 Jun 2005 13:04:30 -0500
Message-ID: <200506071304.30718.gkanis@cems.umn.edu>
References: <m2br6jx2t1.fsf@phoenix.squirrel.nl> <42A4282C.7070808@kernelconcepts.de> <20050606223143.GC65@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050606223143.GC65-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

As I am not an expert on batteries usage, I need your expertise.
I have a laptop with a Li-Ion battery. The company told me that I should at 
least once a month fully discharge it and then charge it. But, from what I 
have read this is wrong and will deteriorate the battery.
Also, I read that the battery should be kept at 30% of its capacity in a 
relative cool environment. But, does this mean that if the laptop is always 
on power I should remove the battery.

I too have observed a decrease in the power capacity, but if it drops a lot, 
the battery will be recharged. I was told that this is normal. Also, I 
observed that the charging rate is not constant, and initially it is at the 
maximum value, but then it drops and gets at 10% of the nominal value. 

What is the definition of a cycle? How can I tell how many cycles my battery 
has? Is it wise to keep the battery on the laptop, when the laptop is on 
power?

Thank you,
Vasilis


On Monday 06 June 2005 05:31 pm, Karol Kozimor wrote:
> Thus wrote Nils Faerber:
> > - - not be charged to full all the time. All Li-* batteries like only to
> > be recharged after they have discharged for at least 10% or more (i.e.
> > max. 90% remaining). Before that they should not be recharged to full
> > again. Many notebook charging circuits do not honor this and kill their
> > batteries within approx. one year (my Asus L3C did this, my Fujitsu
>
> True, my original L3C battery is now at 25% of design capacity and it's
> a fairly common practice to restart charging every time the power cord is
> plugged in. It's good you name the brands that got it right though.
>
> > Siemens Lifebook B-Series does not, IBM T42p does not, etc.)
> >
> > - - never be discharged completely, i.e. up to the point where the
> > machine switches itself off.
>
> Except that given current laptop power consumption, the battery is nowhere
> near empty when the voltage drops below the acceptable level and the
> circuit is switched off. That said, any attempts at shorting will damage
> the battery.
> Best regards,


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
