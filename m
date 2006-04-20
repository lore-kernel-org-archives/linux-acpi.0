From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [1/2] ACPI: make _OSI strings static
Date: Thu, 20 Apr 2006 13:42:08 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A423666E@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47178 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751263AbWDTUmK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2006 16:42:10 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Yeah, looking at the code, it looks too busy with ACPI_NUM_OSI_STRINGS
and the additional level of indirection.

My only suggestion would be that ARRAY_SIZE should really be
ARRAY_LENGTH to differentiate it better from the behavior of the
sizeof() operator.
Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Thursday, April 20, 2006 7:48 AM
> To: Moore, Robert
> Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton
> Subject: Re: [1/2] ACPI: make _OSI strings static
> 
> On Tuesday 18 April 2006 16:29, Moore, Robert wrote:
> > Actually, I find this even more readable:
> > #define ACPI_NUM_OSI_STRINGS    ACPI_ARRAY_SIZE
(acpi_valid_osi_strings)
> >
> > and leave the existing code as:
> > for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
> 
> The typical Linux style is to use
> 
>     for (i = 0; i < ARRAY_SIZE(acpi_valid_osi_strings); i++) {
> 
> rather than
> 
>     for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
> 
> because you can easily verify the loop bounds without having
> to look up ACPI_NUM_OSI_STRINGS, which is defined elsewhere.
> But you have to use your own judgment.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
