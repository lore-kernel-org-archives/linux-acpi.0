From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 2/2] Documentation / ACPI: fix a typo, s/objecte/object/
Date: Fri, 1 May 2015 20:08:47 +0200
Message-ID: <20150501200847.544bfa39be9afd2771a8b464@ao2.it>
References: <1430296645-18086-1-git-send-email-ao2@ao2.it>
	<1430296645-18086-3-git-send-email-ao2@ao2.it>
	<158966919.Jt0JZPcKKy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:6687 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbbEASIy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 May 2015 14:08:54 -0400
In-Reply-To: <158966919.Jt0JZPcKKy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, 01 May 2015 00:17:23 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Wednesday, April 29, 2015 10:37:25 AM Antonio Ospite wrote:
[...]
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
>  

This is fine by me Rafael. Feel free to drop my 2/2 and add your
version with ACK.

Acked-by: Antonio Ospite <ao2@ao2.it>

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
