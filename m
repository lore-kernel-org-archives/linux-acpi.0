From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI, APEI, EINJ: Subtract any matching Register Region from Trigger resources
Date: Thu, 31 Aug 2017 01:29:24 +0200
Message-ID: <115727625.IkF9TZtNWN@aspire.rjw.lan>
References: <1503943994-41271-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47251 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbdH3XiI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Aug 2017 19:38:08 -0400
In-Reply-To: <1503943994-41271-1-git-send-email-Yazen.Ghannam@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-edac@vger.kernel.org, bp@suse.de, tony.luck@intel.com, Yazen Ghannam <yazen.ghannam@amd.com>

On Monday, August 28, 2017 8:13:14 PM CEST Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> ACPI defines a number of instructions to use for triggering errors. However
> we are currently removing the address resources from the trigger resources
> for only the WRITE_REGISTER_VALUE instruction. This leads to a resource
> conflict for any other valid instruction.
> 
> Check that the instruction is less than or equal to the
> WRITE_REGISTER_VALUE instruction. This allows all valid memory access
> instructions and protects against invalid instructions.
> 
> Fixes: b4e008dc53a3 ("ACPI, APEI, EINJ, Refine the fix of resource conflict")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Acked-by: Tony Luck <tony.luck@intel.com>
> ---
> Link:
> https://lkml.kernel.org/r/1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Apply Tony's comment to restrict behavior to valid memory instructions.

Applied, thanks!

