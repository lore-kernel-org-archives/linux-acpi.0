From: Andi Kleen <ak@suse.de>
Subject: Re: Freeing ACPI tables after parsing
Date: Wed, 23 Aug 2006 10:18:42 +0200
Message-ID: <200608231018.42285.ak@suse.de>
References: <B28E9812BAF6E2498B7EC5C427F293A4CE6F9E@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58038 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932402AbWHWISz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Aug 2006 04:18:55 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4CE6F9E@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Natalie.Protasevich@unisys.com

On Tuesday 22 August 2006 22:28, Moore, Robert wrote:
> > Actually FACS table has a global_lock in it (which the BIOS writes
> too),
> > so it is not movable,
> > and as all tables are laid contiguously in physical memory, moving
> some
> > and
> > leaving FACS is not an option.
> 
> This is a very good point. The Global_Lock field of the FACS is not a
> pointer to the global lock, it is the actual memory location of the
> lock. Therefore, the FACS can only be mapped, it cannot be copied.

Ok.  I will fix the e820.h comments then because they're wrong.

-Andi
