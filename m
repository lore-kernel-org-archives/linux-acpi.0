From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: [Suspend2-devel] Cause of Suspend2 resume failures on Toshiba laptops
Date: Sat, 5 Mar 2005 18:56:41 +0100
Message-ID: <20050305175640.GL3485@openzaurus.ucw.cz>
References: <20050304175058.GA4042@blackham.com.au> <1110012298.6028.10.camel@DustPuppy.LNX.RO> <20050305100254.GH4042@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305100254.GH4042-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dumitru Ciobarcianu <swsusp-devel-P4rH+HwZiSk@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > You are on the right track , it does the trick, I did serveral
> > suspend/resume cycles whitout problems. 
> > 
> > But (yes, it's a but :) it is functionally equivalent with using the
> > other workaround (booting at resume with acpi=off) meaning that I lose
> > all the acpi events (AC events, LID events, etc). The system records the
> > event (if I do an "watch cat /proc/acpi/ac_adapter/ADP1/state" it shows
> > the current state correctly) but acpid does not receive the event, and
> > thus can not act accordingly :(  (Toshiba Satellite Pro 6100) 
> 
> Ahh, d'oh. Try this patch instead.
> 
> After more investigation, it seems that the issue is the GPE is
> fired but not serviced because kacpid is frozen. This in itself
> would be okay, however, the GPE isn't being disabled before the
> method executes (despite there being code there to do so), and hence
> fires continuously.

Perhaps you should fix that, too? It is going to cause ugly perfrmance problems.

> The attached patch makes kacpid NOFREEZE so the GPE does get
> serviced (eventually), but probably still isn't the correct
> solution. (A better solution being making sure the GPE gets disabled
> in the first place ... still looking into this).

Looks good to me. It is good idea for other reasons, too: like we'll be
able to fight overheat during writing pages.

				Pavel
> --- linux-2.6.9-rc1/drivers/acpi/osl.c.orig	2005-03-05 17:44:13.000000000 +0800
> +++ linux-2.6.9-rc1/drivers/acpi/osl.c	2005-03-05 17:44:16.000000000 +0800
> @@ -87,7 +87,7 @@
>  		return AE_NULL_ENTRY;
>  	}
>  #endif
> -	kacpid_wq = create_singlethread_workqueue("kacpid", 0);
> +	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
>  	BUG_ON(!kacpid_wq);
>  
>  	return AE_OK;


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
