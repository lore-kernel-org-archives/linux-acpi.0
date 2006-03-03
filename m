From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] max_refcount too low for starting debug messages
Date: Fri, 3 Mar 2006 09:48:42 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E048B943C@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:2442 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030263AbWCCRss convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2006 12:48:48 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Raymund Will <rw@suse.de>, "Brown, Len" <len.brown@intel.com>

I would rather bump up the default value rather than change the message
to debug, since this check is very useful for catching objects that have
been prematurely deleted.

Bob


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Thursday, March 02, 2006 4:37 AM
> To: linux-acpi@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org; Moore, Robert; Raymund Will; Brown,
Len
> Subject: [PATCH] max_refcount too low for starting debug messages
> 
> Some big equipped IA64 machines might show large ref count messages.
> 
> I increased ACPI_MAX_REFERENCE_COUNT and hid the message as debug.
> Feel free to only hide msg, only increase reference count or both ...,
not
> sure which
> one is best, but at least one thing should be done ...
> 
> Subject: Hide ref_cnt debug message
> 
> signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> drivers/acpi/utilities/utdelete.c |    8 +++-----
> include/acpi/acconfig.h           |    2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6.16-rc5/drivers/acpi/utilities/utdelete.c
> ===================================================================
> --- linux-2.6.16-rc5.orig/drivers/acpi/utilities/utdelete.c
> +++ linux-2.6.16-rc5/drivers/acpi/utilities/utdelete.c
> @@ -372,12 +372,10 @@ acpi_ut_update_ref_count(union acpi_oper
>  	 * (A deleted object will have a huge reference count)
>  	 */
>  	if (count > ACPI_MAX_REFERENCE_COUNT) {
> -
> -		ACPI_WARNING((AE_INFO,
> -			      "Large Reference Count (%X) in object %p",
> -			      count, object));
> +		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> +				  "Large Reference Count (%X) in object
%p",
> +				  count, object));
>  	}
> -
>  	return;
>  }
> 
> Index: linux-2.6.16-rc5/include/acpi/acconfig.h
> ===================================================================
> --- linux-2.6.16-rc5.orig/include/acpi/acconfig.h
> +++ linux-2.6.16-rc5/include/acpi/acconfig.h
> @@ -104,7 +104,7 @@
> 
>  /* Max reference count (for debug only) */
> 
> -#define ACPI_MAX_REFERENCE_COUNT        0x400
> +#define ACPI_MAX_REFERENCE_COUNT        0x800
> 
>  /* Size of cached memory mapping for system memory operation region
*/
> 
