From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: ACPI key events handling
Date: Thu, 10 Mar 2005 09:49:33 +0100
Message-ID: <20050310084933.GA10094@hell.org.pl>
References: <BAY1-F15F671E407E4F476D2C957A8500@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <BAY1-F15F671E407E4F476D2C957A8500-MsuGFMq8XAE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Paulo Vitor Magacho da Silva:
>   I have an ACER 163lmi laptop and I am having problem with some of the Fn 
> keys. I don't know if this is related to ACPI or not.
>   The problem is that when I press some the Fn keys, like the sleep button 
> (Fn+F4), and I look at the /proc/acpi/event, sometimes the key works 
> sometimes it doesn't. I did also the check of the Fn keys with the acerhk 
> driver. My laptop has the mail, internet, p1, p2, wireless, buttons. And 
> when I press those buttons, sometimes I get the correct reading from the 
> acerhk driver, sometimes when I press the mail buttons it reads back the 
> wireless, or any other key, and sometimes it just reads garbage.

Sounds like another instance of
http://bugzilla.kernel.org/show_bug.cgi?id=4124

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
