From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: [Suspend2-devel] Cause of Suspend2 resume failures on Toshiba laptops
Date: Sat, 5 Mar 2005 18:02:54 +0800
Message-ID: <20050305100254.GH4042__48830.7517407977$1110017074$gmane$org@blackham.com.au>
References: <20050304175058.GA4042@blackham.com.au> <1110012298.6028.10.camel@DustPuppy.LNX.RO>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <1110012298.6028.10.camel-NCEiQXzLmfTIN9oMcCV+pg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dumitru Ciobarcianu <swsusp-devel-P4rH+HwZiSk@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 05, 2005 at 10:44:58AM +0200, Dumitru Ciobarcianu wrote:
> ??n data de S??, 05-03-2005 la 01:50 +0800, Bernard Blackham a scris:
> > The attached patch more or less reverts the change in 2.6.9-rc1 that
> > began this all. If you have a Toshiba or other laptop that's
> > affected by this, I ask you to see if it helps your problems. (It
> > hacks around the problem rather than fixing it, but I'm not entirely
> > sure what functionality it disables).
> 
> You are on the right track , it does the trick, I did serveral
> suspend/resume cycles whitout problems. 
> 
> But (yes, it's a but :) it is functionally equivalent with using the
> other workaround (booting at resume with acpi=off) meaning that I lose
> all the acpi events (AC events, LID events, etc). The system records the
> event (if I do an "watch cat /proc/acpi/ac_adapter/ADP1/state" it shows
> the current state correctly) but acpid does not receive the event, and
> thus can not act accordingly :(  (Toshiba Satellite Pro 6100) 

Ahh, d'oh. Try this patch instead.

After more investigation, it seems that the issue is the GPE is
fired but not serviced because kacpid is frozen. This in itself
would be okay, however, the GPE isn't being disabled before the
method executes (despite there being code there to do so), and hence
fires continuously.

The attached patch makes kacpid NOFREEZE so the GPE does get
serviced (eventually), but probably still isn't the correct
solution. (A better solution being making sure the GPE gets disabled
in the first place ... still looking into this).

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="toshiba-acpi-hack-2.diff"

--- linux-2.6.9-rc1/drivers/acpi/osl.c.orig	2005-03-05 17:44:13.000000000 +0800
+++ linux-2.6.9-rc1/drivers/acpi/osl.c	2005-03-05 17:44:16.000000000 +0800
@@ -87,7 +87,7 @@
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid", 0);
+	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;

--Km1U/tdNT/EmXiR1--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
