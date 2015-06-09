From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 9 Jun 2015 19:33:32 +0300
Message-ID: <20150609163332.GA18210@jsakkine-mobl1>
References: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
 <20150609091757.GB4968@jsakkine-mobl1>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2BE7@ORSMSX112.amr.corp.intel.com>
 <20150609151919.GA4453@jsakkine-mobl1>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2CA6@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50732 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbbFIQdm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2015 12:33:42 -0400
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2CA6@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT AR..." <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

On Tue, Jun 09, 2015 at 04:16:14PM +0000, Moore, Robert wrote:
> Looking at the TCG ACPI Specification today, it looks like there are
> major changes to the TCPA table. There is a whole bunch of new stuff
> after the Log Area Start Address.
> 
> Perhaps I missed or didn't get part of your proposed change.

I was looking only at the client TCPA table so it was my bad. The client
table has only the change that I did in the patch. I'm myself focused
towards TPM 2.0 work.

If you look at very old specification version:

https://www.trustedcomputinggroup.org/files/temp/6453AF78-1D09-3519-AD74028427486A3B/Server%20TCG_ACPIGeneralSpecification.pdf

You see that there is also a server TCPA with a lot more fields that we
have. If the need hasn't rised for those fields since 2005, I would not
add them unless there is a real use case.

If you seriously want those fields to be part of the patch, I can do a
struct for server TCPA but I don't think there will be value for it.


/Jarkko

> > -----Original Message-----
> > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > Sent: Tuesday, June 09, 2015 8:19 AM
> > To: Moore, Robert
> > Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI COMPONENT
> > AR...; open list:ACPI COMPONENT AR...; open list
> > Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> > 
> > On Tue, Jun 09, 2015 at 02:21:12PM +0000, Moore, Robert wrote:
> > > ACPICA usually defines any "related" data structures, just for user
> > > convenience.
> > 
> > If you want to keep it, it's fine for me but we still probably use the
> > internal structure for it in tpm_crb driver (as tpm_tis uses internal
> > structure for CRB).
> > 
> > Do other updates look fine? I'm looking into migrating to tpm_crb driver
> > to use actbl3.h.
> > 
> > /Jarkko
> > 
> > >
> > > > -----Original Message-----
> > > > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > > > Sent: Tuesday, June 09, 2015 2:18 AM
> > > > To: Moore, Robert
> > > > Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI
> > > > COMPONENT AR...; open list:ACPI COMPONENT AR...; open list
> > > > Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> > > >
> > > > On Mon, Jun 08, 2015 at 08:52:02PM +0000, Moore, Robert wrote:
> > > > > It looks like there is a change to the TCPA table also.
> > > >
> > > > Right. I'll update that too.
> > > >
> > > > I strongly think that the struct acpi_tpm2_control should not be in
> > > > actbl3.h. It is not defined in the TCG ACPI specification. It is
> > > > defined in
> > > >
> > > > http://www.trustedcomputinggroup.org/resources/pc_client_platform_tp
> > > > m_prof
> > > > ile_ptp_specification
> > > >
> > > > FIFO control structures are internal for to the TPM subsystem and so
> > > > should be CRB control structures (and we have already inside
> > tpm_crb.c).
> > > >
> > > > The structure ended up there probably because it was combined with
> > > > the
> > > > TPM2 table in that Microsoft specification.
> > > >
> > > > /Jarkko
