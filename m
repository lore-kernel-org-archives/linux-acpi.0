From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: ACPI key events handling
Date: Mon, 14 Mar 2005 20:40:40 -0300
Message-ID: <BAY1-F22A313D38BFC07CFD3762CA8560@phx.gbl>
References: <3ACA40606221794F80A5670F0AF15F8407663707@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8407663707@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The patch suggested (http://bugzilla.kernel.org/show_bug.cgi?id=3851#c52) 
solved the problem with handling of the Fn keys and other special keys. I've 
tested with kernel 2.6.11-rc4. I also used the patch sent by Li, Shaohua.

Regards,
Paulo

>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>To: "Thomas Renninger" <trenn-l3A5Bk7waGM@public.gmane.org>, "Li, Shaohua" 
><shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>CC: "Karol Kozimor" <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>,        "Paulo Vitor Magacho da 
>Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>,        <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>Subject: RE: [ACPI] ACPI key events handling
>Date: Fri, 11 Mar 2005 16:47:05 +0800
>
>The patch at http://bugzilla.kernel.org/show_bug.cgi?id=3851#c52 is worthy
>testing, if you have EC related issue.
>
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas 
>Renninger
>Sent: 2005Äê3ÔÂ11ÈÕ 0:28
>To: Li, Shaohua
>Cc: Karol Kozimor; Paulo Vitor Magacho da Silva; 
>acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] ACPI key events handling
>
>Li, Shaohua wrote:
>
> >How about below patch? It fixes current ec address space handler bugs.
> >
> >Thanks,
> >Shaohua
> >
> >
> >diff -puN drivers/acpi/ec.c~ec_addr_space_handler drivers/acpi/ec.c
> >--- 2.5/drivers/acpi/ec.c~ec_addr_space_handler 2005-03-08
> >09:19:05.228720200 +0800
> >+++ 2.5-root/drivers/acpi/ec.c 2005-03-08 10:35:54.130060696 +0800
> >@@ -441,7 +441,7 @@ acpi_ec_space_handler (
> > {
> >  int   result = 0;
> >  struct acpi_ec  *ec = NULL;
> >- u32   temp = 0;
> >+ u32   temp = *value;
> >  acpi_integer  f_v = 0;
> >  int    i = 0;
> >
> >@@ -462,10 +462,9 @@ next_byte:
> >  switch (function) {
> >  case ACPI_READ:
> >   result = acpi_ec_read(ec, (u8) address, &temp);
> >-  *value = (acpi_integer) temp;
> >   break;
> >  case ACPI_WRITE:
> >-  result = acpi_ec_write(ec, (u8) address, (u8) *value);
> >+  result = acpi_ec_write(ec, (u8) address, (u8) temp);
> >   break;
> >  default:
> >   result = -EINVAL;
> >@@ -474,19 +473,18 @@ next_byte:
> >  }
> >
> >  bit_width -= 8;
> >- if(bit_width){
> >-
> >+ if (bit_width){
> >   if(function == ACPI_READ)
> >-   f_v |= (acpi_integer) (*value) << 8*i;
> >+   f_v |= temp << 8 * i;
> >   if(function == ACPI_WRITE)
> >-   (*value) >>=8;
> >+   temp >>= 8;
> >   i++;
> >
> >
>
>So the actual fix is this?
>
> >+  (u8)address ++;
> >
> >
>I saw it some days ago.
>However this only fixes something if you see:
>*acpi_ec_space_handler: bit_width should be 8*
>messages in your syslog.
>Could you delete this message as well, please?
>I have a machine here having this message in syslog
>every second...
>I didn't try the keys, but I think they work as expected.
>
>I wonder whether  u64 temp should be used, acpi_integer could be u64
>and bit_width (QWordAcc) could be 64 bit?
>
> >   goto next_byte;
> >  }
> >
> >-
> >  if(function == ACPI_READ){
> >-  f_v |= (acpi_integer) (*value) << 8*i;
> >+  f_v |= temp << 8 * i;
> >   *value = f_v;
> >  }
> >
> >@@ -505,8 +503,6 @@ out:
> >  default:
> >   return_VALUE(AE_OK);
> >  }
> >-
> >-
> > }
> >
> >
> >
> >>-----Original Message-----
> >>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karol Kozimor
> >>Sent: Thursday, March 10, 2005 4:50 PM
> >>To: Paulo Vitor Magacho da Silva
> >>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >>Subject: Re: [ACPI] ACPI key events handling
> >>
> >>Thus wrote Paulo Vitor Magacho da Silva:
> >>
> >>
> >>>  I have an ACER 163lmi laptop and I am having problem with some of
> >>>
> >>>
> >the
> >
> >
> >>Fn
> >>
> >>
> >>>keys. I don't know if this is related to ACPI or not.
> >>>  The problem is that when I press some the Fn keys, like the sleep
> >>>
> >>>
> >>button
> >>
> >>
> >>>(Fn+F4), and I look at the /proc/acpi/event, sometimes the key works
> >>>sometimes it doesn't. I did also the check of the Fn keys with the
> >>>
> >>>
> >acerhk
> >
> >
> >>>driver. My laptop has the mail, internet, p1, p2, wireless, buttons.
> >>>
> >>>
> >And
> >
> >
> >>>when I press those buttons, sometimes I get the correct reading from
> >>>
> >>>
> >the
> >
> >
> >>>acerhk driver, sometimes when I press the mail buttons it reads back
> >>>
> >>>
> >the
> >
> >
> >>>wireless, or any other key, and sometimes it just reads garbage.
> >>>
> >>>
> >>Sounds like another instance of
> >>http://bugzilla.kernel.org/show_bug.cgi?id=4124
> >>
> >>Best regards,
> >>
> >>
> >>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

_________________________________________________________________
Chegou o que faltava: MSN Acesso Grátis. Instale Já! 
http://www.msn.com.br/discador



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
