From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI_DEBUG_PRINT and ACPI_WARNING
Date: Wed, 29 Mar 2006 15:06:17 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04D8012B@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53258 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750958AbWC2XGY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 18:06:24 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

You would like an OSL interface that gets passed the debug level and can
map this to the host debug/error levels?

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Brown, Len
> Sent: Wednesday, March 29, 2006 2:58 PM
> To: linux-acpi@vger.kernel.org
> Subject: ACPI_DEBUG_PRINT and ACPI_WARNING
> 
> 
> I think we have a problem with both ACPI_DEBUG_PRINT and ACPI_WARNING
> and how these ACPI core macros work on Linux.
> 
> ACPI_WARNING is an improvement over the past where all the
> ACPI_DEBUG_PRINT messages went away on a production kernel.
> 
> ACPI_DEBUG_PRINT is very handy in that via acpi_ut_print()
> you can turn them on and off on your debug kernel depending
> on the level and section of code.
> 
> But both funnel through osl.c where there is no native Linux
> print level associated with the message, and thus if it gets
> that far, it unconditionaly gets printed to the screen and
> log buffer, no mater how the system has been administered
> to handle messages of different levels.
> 
> ie. the kernel.h levels are not used:
> 
> #define	KERN_EMERG	"<0>"	/* system is unusable
> */
> #define	KERN_ALERT	"<1>"	/* action must be taken
immediately
> */
> #define	KERN_CRIT	"<2>"	/* critical conditions
> */
> #define	KERN_ERR	"<3>"	/* error conditions
> */
> #define	KERN_WARNING	"<4>"	/* warning conditions
> */
> #define	KERN_NOTICE	"<5>"	/* normal but significant
condition
> */
> #define	KERN_INFO	"<6>"	/* informational
> */
> #define	KERN_DEBUG	"<7>"	/* debug-level messages
> */
> 
> thoughts?
> 
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
