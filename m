From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Region
 from Trigger resources
Date: Wed, 23 Aug 2017 09:52:46 -0700
Message-ID: <20170823165245.52437iccij6sm4ta@intel.com>
References: <1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com>
 <BN6PR1201MB013138E0E32481E623C35715F8840@BN6PR1201MB0131.namprd12.prod.outlook.com>
 <20170822160305.o4ceuqjnuy4drgxb@intel.com>
 <BN6PR1201MB013106200C118FC6336017C8F8850@BN6PR1201MB0131.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59604 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754154AbdHWQwq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Aug 2017 12:52:46 -0400
Content-Disposition: inline
In-Reply-To: <BN6PR1201MB013106200C118FC6336017C8F8850@BN6PR1201MB0131.namprd12.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>

On Wed, Aug 23, 2017 at 04:37:43PM +0000, Ghannam, Yazen wrote:
> > -----Original Message-----
> > From: Luck, Tony [mailto:tony.luck@intel.com]
> > Maybe you should add the other instruction types that make sense here
> > (ACPI_EINJ_READ_REGISTER, ACPI_EINJ_READ_REGISTER_VALUE and
> > ACPI_EINJ_WRITE_REGISTER) as a sanity check against the BIOS giving you an
> > action in the trigger table that doesn't involve a memory access?
> > 
> 
> Yes, in that case we can do:
> entry->instruction <= ACPI_EINJ_WRITE_REGISTER_VALUE
> 
> That would cover all the memory access instructions and protect against invalid
> instructions.
> 
> How does that sound?

Perfect.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
