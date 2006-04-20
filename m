From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [1/2] ACPI: make _OSI strings static
Date: Thu, 20 Apr 2006 08:48:09 -0600
Message-ID: <200604200848.09050.bjorn.helgaas@hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4200553@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56778 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750919AbWDTOsP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 10:48:15 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4200553@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Tuesday 18 April 2006 16:29, Moore, Robert wrote:
> Actually, I find this even more readable:
> #define ACPI_NUM_OSI_STRINGS    ACPI_ARRAY_SIZE (acpi_valid_osi_strings)
> 
> and leave the existing code as: 
> for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {

The typical Linux style is to use

    for (i = 0; i < ARRAY_SIZE(acpi_valid_osi_strings); i++) {

rather than

    for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {

because you can easily verify the loop bounds without having
to look up ACPI_NUM_OSI_STRINGS, which is defined elsewhere.
But you have to use your own judgment.
