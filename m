From: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Fri, 23 Jul 2004 19:34:12 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040723233412.GA9078@omocha.vort.org>
References: <20040723193658.GA3331@omocha.vort.org> <1090615197.9015.7.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1090615197.9015.7.camel-DNmeG3802II@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vernon Mauery <vernux-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Adding new wakeup devices helps in this area a lot.  Check out the
> latest acpi patch to the kernel -- I had this same issue and applied
> the  acpi-20040715 patch, which among other things adds support for
> other things waking up the machine (sleep button, lid, etc.)
> 
> This simply makes it so you don't have to press the power button to
> wake up from S3.  While that is not exactly a direct solution, it was
> the one I was looking for anyway.

Interesting, though I think the only thing my laptop would be able to
use to trigger S3 would be the lid switch, and I don't think I'd want
that. I think one of the best things about Apple's laptops is how
awesome their sleep support is. The worst thing about them (in my
opinion) that they make it a nightmare to disable the sleep-on-lid-close
feature.

Obviously, some people will love it, so I'm very pleased that we can
configure S3/wakup triggers that way. But, considering tha S3 still
breaks things... 

Oi.

Russell


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
