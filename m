From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Tue, 29 Nov 2011 09:48:43 +0800
Message-ID: <1322531323.1467.10.camel@minggr>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21540 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab1K2Bsr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Nov 2011 20:48:47 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Jean Delvare <khali@linux-fr.org>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2011-11-29 at 06:56 +0800, Moore, Robert wrote:
> I'm going to let Lin Ming respond to this, since the functions in question appear to be Linux extensions to ACPICA.
> 
> > -----Original Message-----
> > From: Luca Tettamanti [mailto:kronos.it@gmail.com]
> > Sent: Monday, November 28, 2011 12:54 PM
> > To: Jean Delvare
> > Cc: Nikolay Mikov; Thomas; Moore, Robert; linux-acpi@vger.kernel.org
> > Subject: [BUG] ACPI resource validation not working [Was: Re: ITE
> > 8728F]
> > 
> > To give some context to the newcomers: while helping a user with a new
> > hwmon chip we discovered that the native driver is loaded fine even
> > though the IO ports are claimed by ACPI (OperationRegion) and
> > acpi_enforce_resources is "strict".
> > 
> > On Mon, Nov 28, 2011 at 4:48 PM, Luca Tettamanti <kronos.it@gmail.com>
> > wrote:
> > > On Mon, Nov 28, 2011 at 4:08 PM, Jean Delvare <khali@linux-fr.org>
> > wrote:
> > >> On Mon, 28 Nov 2011 14:02:51 +0100, Luca Tettamanti wrote:
> > >>> The DSDT has this:
> > >>>
> > >>> Name (IOEB, 0x0290)
> > >>> OperationRegion (SIOE, SystemIO, IOEB, 0x20)
> > >>> Field (SIOE, ByteAcc, NoLock, Preserve)
> > >>> {
> > >>>     Offset (0x05),
> > >>>     GIDX,   8,
> > >>>     GDAT,   8
> > >>> }
> > >>>
> > >>> so the requested area is well within what ACPI claims.
> > [cut]
> > >> A colleague of mine (hi Thomas!) suggests that Nikolay could boot
> > with:
> > >>
> > >> ddebug="file osl.c +p
> > >
> > > This should be:
> > >
> > > ddebug_query="file osl.c +p"
> > >
> > > It should spam the log with all the resources found by ACPI parser,
> > > assuming that CONFIG_DYNAMIC_DEBUG is enabled.
> > 
> > Hum, the call to acpi_os_validate_address was removed between 2.6.38
> > and 2.6.39, with this commit by Bob More:
> > 
> > commit 9ad19ac456a5f097f7cbbfef820b95297d6a934f
> > Author: Bob Moore <robert.moore@intel.com>
> > Date:   Mon Feb 14 16:09:40 2011 +0800
> > 
> >     ACPICA: Split large dsopcode and dsload.c files.
> > 
> > which seems to be just moving code around (the culprit here is
> > acpi_ds_get_region_arguments). I guess that the removal wasn't
> > intentional since the corresponding call to acpi_os_invalidate_address
> > was left in place.
> > Bob should I put the call back in place? Am I missing something?

Yes, we should put the call back.

diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 8c7b997..42163d8 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -387,5 +387,29 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Validate the region address/length via the host OS */
+
+	status = acpi_os_validate_address(obj_desc->region.space_id,
+					  obj_desc->region.address,
+					  (acpi_size) obj_desc->region.length,
+					  acpi_ut_get_node_name(node));
+
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * Invalid address/length. We will emit an error message and mark
+		 * the region as invalid, so that it will cause an additional error if
+		 * it is ever used. Then return AE_OK.
+		 */
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During address validation of OpRegion [%4.4s]",
+				node->name.ascii));
+		obj_desc->common.flags |= AOPOBJ_INVALID;
+		status = AE_OK;
+	}
+
 	return_ACPI_STATUS(status);
 }


> > 
> > Luca


