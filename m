From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/2] ACPI / ARM64: add BAD_MADT_GICC_ENTRY() macro
Date: Tue, 7 Jul 2015 10:25:16 +0100
Message-ID: <20150707092516.GC23879@arm.com>
References: <1436224608-27754-1-git-send-email-al.stone@linaro.org>
 <1436224608-27754-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34672 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbbGGJZV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jul 2015 05:25:21 -0400
Content-Disposition: inline
In-Reply-To: <1436224608-27754-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>

On Tue, Jul 07, 2015 at 12:16:47AM +0100, Al Stone wrote:
> From: Al Stone <al.stone@.linaro.org>
> 
> The BAD_MADT_ENTRY() macro is designed to work for all of the subtables
> of the MADT.  In the ACPI 5.1 version of the spec, the struct for the
> GICC subtable (struct acpi_madt_generic_interrupt) is 76 bytes long; in
> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
> subtable, it fails if 5.1 structs are in use, and there are systems in
> the wild that have them.
> 
> This patch adds the BAD_MADT_GICC_ENTRY() that checks the GICC subtable
> only, accounting for the difference in specification versions that are
> possible.  The BAD_MADT_ENTRY() will continue to work as is for all other
> MADT subtables.
> 
> This code is being added to an arm64 header file since that is currently
> the only architecture using the GICC subtable of the MADT.  As a GIC is
> specific to ARM, it is also unlikely the subtable will be used elsewhere.
> 
> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Not the nicest patch I've ever seen, but if it gets things working again:

  Acked-by: Will Deacon <will.deacon@arm.com>

Catalin, I assume you're picking these two up for 4.2?

Will
