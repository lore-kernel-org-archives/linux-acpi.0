From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] Documentation / ACPI: fix a typo, s/objecte/object/
Date: Fri, 01 May 2015 00:17:23 +0200
Message-ID: <158966919.Jt0JZPcKKy@vostro.rjw.lan>
References: <1430296645-18086-1-git-send-email-ao2@ao2.it> <1430296645-18086-3-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49462 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750801AbbD3Vw2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 17:52:28 -0400
In-Reply-To: <1430296645-18086-3-git-send-email-ao2@ao2.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wednesday, April 29, 2015 10:37:25 AM Antonio Ospite wrote:
> Also add some commas to make it clear that the word "object" refers to
> "configuration" and not to "names".
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  Documentation/acpi/gpio-properties.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
> index ae36fcf..cd4b6c7 100644
> --- a/Documentation/acpi/gpio-properties.txt
> +++ b/Documentation/acpi/gpio-properties.txt
> @@ -1,7 +1,7 @@
>  _DSD Device Properties Related to GPIO
>  --------------------------------------
>  
> -With the release of ACPI 5.1 and the _DSD configuration objecte names
> +With the release of ACPI 5.1, and the _DSD configuration object, names
>  can finally be given to GPIOs (and other things as well) returned by
>  _CRS.  Previously, we were only able to use an integer index to find
>  the corresponding GPIO, which is pretty error prone (it depends on

This still doesn't read too well IMO.  Below is my version of the fix.

---
 Documentation/acpi/gpio-properties.txt |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/Documentation/acpi/gpio-properties.txt
===================================================================
--- linux-pm.orig/Documentation/acpi/gpio-properties.txt
+++ linux-pm/Documentation/acpi/gpio-properties.txt
@@ -1,9 +1,9 @@
 _DSD Device Properties Related to GPIO
 --------------------------------------
 
-With the release of ACPI 5.1 and the _DSD configuration objecte names
-can finally be given to GPIOs (and other things as well) returned by
-_CRS.  Previously, we were only able to use an integer index to find
+With the release of ACPI 5.1, the _DSD configuration object finally
+allows names to be given to GPIOs (and other things as well) returned
+by _CRS.  Previously, we were only able to use an integer index to find
 the corresponding GPIO, which is pretty error prone (it depends on
 the _CRS output ordering, for example).
 

