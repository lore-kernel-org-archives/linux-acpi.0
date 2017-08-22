From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Region
 from Trigger resources
Date: Tue, 22 Aug 2017 09:03:06 -0700
Message-ID: <20170822160305.o4ceuqjnuy4drgxb@intel.com>
References: <1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com>
 <BN6PR1201MB013138E0E32481E623C35715F8840@BN6PR1201MB0131.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8659 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbdHVQDL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Aug 2017 12:03:11 -0400
Content-Disposition: inline
In-Reply-To: <BN6PR1201MB013138E0E32481E623C35715F8840@BN6PR1201MB0131.namprd12.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>

On Tue, Aug 22, 2017 at 02:04:27PM +0000, Ghannam, Yazen wrote:
> > *einj_get_trigger_parameter_region(
> >  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
> >  	for (i = 0; i < trigger_tab->entry_count; i++) {
> >  		if (entry->action == ACPI_EINJ_TRIGGER_ERROR &&
> > -		entry->instruction == ACPI_EINJ_WRITE_REGISTER_VALUE &&
> >  		entry->register_region.space_id ==
> >  			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> >  		(entry->register_region.address & param2) == (param1 &
> > param2))

Maybe you should add the other instruction types that make sense
here (ACPI_EINJ_READ_REGISTER, ACPI_EINJ_READ_REGISTER_VALUE and
ACPI_EINJ_WRITE_REGISTER) as a sanity check against the BIOS
giving you an action in the trigger table that doesn't involve
a memory access?

-Tony
