From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Early init patch breaks Dell laptops
Date: 10 Oct 2004 05:08:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1097399285.16791.43.camel@d845pe>
References: <16A54BF5D6E14E4D916CE26C9AD30575457610@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575457610-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Good idea, but it turns out that LAPIC 
causes the D600 poweroff to fail with or without ACPI.

Also, I recall another Dell system's APM suspend
didn't work with the LAPIC enabled.

So I think the simpler patch is better.

thanks,
-Len

On Sun, 2004-10-10 at 05:00, Li, Shaohua wrote:
> How about enable lapic if ACPI isn't enabled?
> 
> -Shaohua
> 
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Len Brown
> >Sent: Sunday, October 10, 2004 4:45 PM
> >To: Daniel Drake
> >Cc: Yu, Luming; ACPI Developers
> >Subject: Re: [ACPI] Early init patch breaks Dell laptops
> >
> >Let me know if this doesn't address all of the regressions.
> >
> >thanks,
> >-Len
> >
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
