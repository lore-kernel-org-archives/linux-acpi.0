From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] Documentation / ACPI: fix a typo, s/objecte/object/
Date: Mon, 4 May 2015 12:07:50 +0300
Message-ID: <20150504090750.GW1534@lahna.fi.intel.com>
References: <1430296645-18086-1-git-send-email-ao2@ao2.it>
 <1430296645-18086-3-git-send-email-ao2@ao2.it>
 <158966919.Jt0JZPcKKy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbbEDJH4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 May 2015 05:07:56 -0400
Content-Disposition: inline
In-Reply-To: <158966919.Jt0JZPcKKy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Antonio Ospite <ao2@ao2.it>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, May 01, 2015 at 12:17:23AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, April 29, 2015 10:37:25 AM Antonio Ospite wrote:
> > Also add some commas to make it clear that the word "object" refers to
> > "configuration" and not to "names".
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > ---
> >  Documentation/acpi/gpio-properties.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
> > index ae36fcf..cd4b6c7 100644
> > --- a/Documentation/acpi/gpio-properties.txt
> > +++ b/Documentation/acpi/gpio-properties.txt
> > @@ -1,7 +1,7 @@
> >  _DSD Device Properties Related to GPIO
> >  --------------------------------------
> >  
> > -With the release of ACPI 5.1 and the _DSD configuration objecte names
> > +With the release of ACPI 5.1, and the _DSD configuration object, names
> >  can finally be given to GPIOs (and other things as well) returned by
> >  _CRS.  Previously, we were only able to use an integer index to find
> >  the corresponding GPIO, which is pretty error prone (it depends on
> 
> This still doesn't read too well IMO.  Below is my version of the fix.
> 
> ---
>  Documentation/acpi/gpio-properties.txt |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/Documentation/acpi/gpio-properties.txt
> ===================================================================
> --- linux-pm.orig/Documentation/acpi/gpio-properties.txt
> +++ linux-pm/Documentation/acpi/gpio-properties.txt
> @@ -1,9 +1,9 @@
>  _DSD Device Properties Related to GPIO
>  --------------------------------------
>  
> -With the release of ACPI 5.1 and the _DSD configuration objecte names
> -can finally be given to GPIOs (and other things as well) returned by
> -_CRS.  Previously, we were only able to use an integer index to find
> +With the release of ACPI 5.1, the _DSD configuration object finally
> +allows names to be given to GPIOs (and other things as well) returned
> +by _CRS.  Previously, we were only able to use an integer index to find
>  the corresponding GPIO, which is pretty error prone (it depends on
>  the _CRS output ordering, for example).

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
