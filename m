From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: generic hotkey driver
Date: Tue, 7 Sep 2004 10:49:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040907084910.GA27074@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F84056B57EE@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84056B57EE@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Yu, Luming:
> We don't need to care about the format of event. Since it is
> configurable,
> we just need to understand the internal meaning. So maybe we
> need to define the internal event number, which stands for a
> special purpose. such as:
> 
> 	001	turn off display
> 	002	inc brightness
> 	003	dec brightness
> 	004	s3
> 	......

Hmm, ASUS laptops support some 16 distinct events, I don't see your
solution maintainable.

> >Lcd brightness control is defined in ACPI spec apendix.
> >I'm starting implement that.
> Be careful, there has a video extension driver 
> filed at http://bugzilla.kernel.org/show_bug.cgi?id=1944

Sadly, most OEMs don't give a damn about the spec and implement this in
their own way.

> >Bluetooth, dock, and other device settings are not common.
> >So these may be implement in each extra drivers. eg) 
> >ibm_acpi.c has these functions.
> But , it is still meaningful to standardize the event format.

Sure, but what can be done apart from agreeing on the name of the first
field?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
