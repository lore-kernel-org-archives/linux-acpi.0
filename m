From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 9 Jun 2015 12:17:57 +0300
Message-ID: <20150609091757.GB4968@jsakkine-mobl1>
References: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43948 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbbFIJSH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2015 05:18:07 -0400
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT AR..." <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Jun 08, 2015 at 08:52:02PM +0000, Moore, Robert wrote:
> It looks like there is a change to the TCPA table also.

Right. I'll update that too.

I strongly think that the struct acpi_tpm2_control should not be in
actbl3.h. It is not defined in the TCG ACPI specification. It is
defined in

http://www.trustedcomputinggroup.org/resources/pc_client_platform_tpm_profile_ptp_specification

FIFO control structures are internal for to the TPM subsystem and so
should be CRB control structures (and we have already inside tpm_crb.c).

The structure ended up there probably because it was combined with the
TPM2 table in that Microsoft specification.

/Jarkko
