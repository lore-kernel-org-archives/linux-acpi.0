From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [Devel] ACPICA: Resource Mgr: Prevent infinite loops in
	resource walks
Date: Wed, 23 Oct 2013 06:06:46 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802478147@SHSMSX101.ccr.corp.intel.com>
References: <20131017122850.GA24755@longonot.mountain>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37C78AA21@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32098 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3JWGGt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2013 02:06:49 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37C78AA21@ORSMSX103.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

The last resource should always be ACPI_RESOURCE_TYPE_END_TAG and we have nsrepair mechanism to ensure that this entry is always there for resource based properties (there are still 2 kinds of properties haven't been fixed yet).
If we do not want to rely on this logic, then we may need to use buffer->length and pass this one to the acpi_rs_get_aml_length to avoid potential infinite loop.
I'll draft an ACPICA patch to achieve the latter.

Thanks and best regards
-Lv

> -----Original Message-----
> From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf Of Moore, Robert
> Sent: Wednesday, October 23, 2013 5:36 AM
> To: Dan Carpenter
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
> Subject: Re: [Devel] ACPICA: Resource Mgr: Prevent infinite loops in resource walks
> 
> We'll take a look.
> Thanks,
> Bob
> 
> 
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Thursday, October 17, 2013 5:29 AM
> > To: Moore, Robert
> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org
> > Subject: re: ACPICA: Resource Mgr: Prevent infinite loops in resource
> > walks
> >
> > Hello Bob Moore,
> >
> > The patch c13085e519e8: "ACPICA: Resource Mgr: Prevent infinite loops in
> > resource walks" from Mar 8, 2013 is not beautiful.  My static checker
> > complains about the loop because:
> > "drivers/acpi/acpica/rscalc.c:197 acpi_rs_get_aml_length()
> > 	 warn: 'resource' can't be NULL."
> >
> > drivers/acpi/acpica/rscalc.c
> >    195          /* Traverse entire list of internal resource descriptors
> > */
> >    196
> >    197          while (resource) {
> >                        ^^^^^^^^
> >
> > My static checker is wrong because we use the -fno-strict-overflow to
> > prevent GCC from optimizing this check away.  But we are looping over a
> > list of pointers until our pointer wraps to NULL.  In other words we loop
> > over all the 2**64 - 1 addresses until we wrap to NULL or we find
> > something with an invalid type or something with ->length zero.
> >
> > I assume the last element in the list always has length zero?  If so then
> > we could replace "while (resource)" with "while (resource->length)"
> >
> >    198
> >    199                  /* Validate the descriptor type */
> >    200
> >    201                  if (resource->type > ACPI_RESOURCE_TYPE_MAX) {
> >    202
> > return_ACPI_STATUS(AE_AML_INVALID_RESOURCE_TYPE);
> >    203                  }
> >    204
> >    205                  /* Sanity check the length. It must not be zero,
> > or we loop forever */
> >    206
> >    207                  if (!resource->length) {
> >    208
> > return_ACPI_STATUS(AE_AML_BAD_RESOURCE_LENGTH);
> >    209                  }
> >    210
> >    211                  /* Get the base size of the (external stream)
> > resource descriptor */
> >    212
> >
> > regards,
> > dan carpenter
> 
> _______________________________________________
> Devel mailing list
> Devel@acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
