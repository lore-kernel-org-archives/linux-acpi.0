From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: [PATCH 0/30] return statement cleanup - kill pointless parentheses (fwd)
Date: Tue, 21 Dec 2004 00:35:06 +0100
Message-ID: <20041220233505.GA710@hell.org.pl>
References: <20041220225414.GD464@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041220225414.GD464-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, juhl-lkml-poRShpWsAiE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Pavel Machek:
> Hi!
> 
> Parenthesis around returns statements were driving me crazy for quite
> a long time -- return is not a function and I do not think it should
> look as one. Could we get this applied?
> 								Pavel
> 
> Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
> Signed-off-by: Jesper Juhl <juhl-lkml-poRShpWsAiE@public.gmane.org>
> 
> diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/asus_acpi.c linux-2.6.10-rc3-bk13/drivers/acpi/asus_acpi.c
> --- linux-2.6.10-rc3-bk13-orig/drivers/acpi/asus_acpi.c	2004-10-18 23:53:46.000000000 +0200
> +++ linux-2.6.10-rc3-bk13/drivers/acpi/asus_acpi.c	2004-12-20 23:35:32.000000000 +0100

Acked-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
