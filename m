From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: ACPI key events handling
Date: Thu, 10 Mar 2005 19:44:07 -0300
Message-ID: <BAY1-F313B1EC17E83D18D03F5C9A8520@phx.gbl>
References: <16A54BF5D6E14E4D916CE26C9AD30575015B5180@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575015B5180-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

I've tryed your patch, but that didn't solve the keyboard problem. But it's 
an ACPI problem, right ?

Regards,
Paulo

>From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>To: "Karol Kozimor" <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>,        "Paulo Vitor Magacho da 
>Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>CC: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>Subject: RE: [ACPI] ACPI key events handling
>Date: Thu, 10 Mar 2005 16:55:16 +0800
>
>How about below patch? It fixes current ec address space handler bugs.
>
>Thanks,
>Shaohua
>
>
>diff -puN drivers/acpi/ec.c~ec_addr_space_handler drivers/acpi/ec.c
>--- 2.5/drivers/acpi/ec.c~ec_addr_space_handler	2005-03-08
>09:19:05.228720200 +0800
>+++ 2.5-root/drivers/acpi/ec.c	2005-03-08 10:35:54.130060696 +0800
>@@ -441,7 +441,7 @@ acpi_ec_space_handler (
>  {
>  	int			result = 0;
>  	struct acpi_ec		*ec = NULL;
>-	u32			temp = 0;
>+	u32			temp = *value;
>  	acpi_integer		f_v = 0;
>  	int 			i = 0;
>
>@@ -462,10 +462,9 @@ next_byte:
>  	switch (function) {
>  	case ACPI_READ:
>  		result = acpi_ec_read(ec, (u8) address, &temp);
>-		*value = (acpi_integer) temp;
>  		break;
>  	case ACPI_WRITE:
>-		result = acpi_ec_write(ec, (u8) address, (u8) *value);
>+		result = acpi_ec_write(ec, (u8) address, (u8) temp);
>  		break;
>  	default:
>  		result = -EINVAL;
>@@ -474,19 +473,18 @@ next_byte:
>  	}
>
>  	bit_width -= 8;
>-	if(bit_width){
>-
>+	if (bit_width){
>  		if(function == ACPI_READ)
>-			f_v |= (acpi_integer) (*value) << 8*i;
>+			f_v |= temp << 8 * i;
>  		if(function == ACPI_WRITE)
>-			(*value) >>=8;
>+			temp >>= 8;
>  		i++;
>+		(u8)address ++;
>  		goto next_byte;
>  	}
>
>-
>  	if(function == ACPI_READ){
>-		f_v |= (acpi_integer) (*value) << 8*i;
>+		f_v |= temp << 8 * i;
>  		*value = f_v;
>  	}
>
>@@ -505,8 +503,6 @@ out:
>  	default:
>  		return_VALUE(AE_OK);
>  	}
>-
>-
>  }
>
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karol Kozimor
> >Sent: Thursday, March 10, 2005 4:50 PM
> >To: Paulo Vitor Magacho da Silva
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: Re: [ACPI] ACPI key events handling
> >
> >Thus wrote Paulo Vitor Magacho da Silva:
> >>   I have an ACER 163lmi laptop and I am having problem with some of
>the
> >Fn
> >> keys. I don't know if this is related to ACPI or not.
> >>   The problem is that when I press some the Fn keys, like the sleep
> >button
> >> (Fn+F4), and I look at the /proc/acpi/event, sometimes the key works
> >> sometimes it doesn't. I did also the check of the Fn keys with the
>acerhk
> >> driver. My laptop has the mail, internet, p1, p2, wireless, buttons.
>And
> >> when I press those buttons, sometimes I get the correct reading from
>the
> >> acerhk driver, sometimes when I press the mail buttons it reads back
>the
> >> wireless, or any other key, and sometimes it just reads garbage.
> >
> >Sounds like another instance of
> >http://bugzilla.kernel.org/show_bug.cgi?id=4124
> >
> >Best regards,
> >
> >--
> >Karol 'sziwan' Kozimor
> >sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> >
> >
> >-------------------------------------------------------
> >SF email is sponsored by - The IT Product Guide
> >Read honest & candid reviews on hundreds of IT Products from real
>users.
> >Discover which products truly live up to the hype. Start reading now.
> >http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel

_________________________________________________________________
Chegou o que faltava: MSN Acesso Grátis. Instale Já! 
http://www.msn.com.br/discador



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
