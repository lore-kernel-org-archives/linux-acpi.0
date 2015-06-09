From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 9 Jun 2015 14:21:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2BE7@ORSMSX112.amr.corp.intel.com>
References: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
 <20150609091757.GB4968@jsakkine-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53124 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbbFIOV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2015 10:21:29 -0400
In-Reply-To: <20150609091757.GB4968@jsakkine-mobl1>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT AR..." <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

ACPICA usually defines any "related" data structures, just for user convenience.

> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, June 09, 2015 2:18 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI COMPONENT
> AR...; open list:ACPI COMPONENT AR...; open list
> Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> 
> On Mon, Jun 08, 2015 at 08:52:02PM +0000, Moore, Robert wrote:
> > It looks like there is a change to the TCPA table also.
> 
> Right. I'll update that too.
> 
> I strongly think that the struct acpi_tpm2_control should not be in
> actbl3.h. It is not defined in the TCG ACPI specification. It is defined
> in
> 
> http://www.trustedcomputinggroup.org/resources/pc_client_platform_tpm_prof
> ile_ptp_specification
> 
> FIFO control structures are internal for to the TPM subsystem and so
> should be CRB control structures (and we have already inside tpm_crb.c).
> 
> The structure ended up there probably because it was combined with the
> TPM2 table in that Microsoft specification.
> 
> /Jarkko
