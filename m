From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: Cleanup <linux/acpi.h>
Date: Fri, 9 Nov 2007 13:38:22 -0800
Message-ID: <20071109133822.ba420af4.akpm@linux-foundation.org>
References: <200711071420.56688.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59882 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763615AbXKIVii (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 16:38:38 -0500
In-Reply-To: <200711071420.56688.jdelvare@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, trenn@suse.de

On Wed, 7 Nov 2007 14:20:56 +0100
Jean Delvare <jdelvare@suse.de> wrote:

> Two cleanups to <linux/acpi.h>:
> * Stop defining acpi_mp_config, it isn't used anywhere.
> * Discard nested "#ifdef CONFIG_ACPI", they are useless and
>   error-prone.

It's not a good time to be doing not-strictly-needed cleanup patches
in there.

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
> Len, Andrew, this cleanup should go before the patches sent by
> Thomas Renninger. I'll send updated patches in a moment so that
> we no longer break the build for CONFIG_ACPI=n.

I'm quite confused.  I have the following acpi-affecting patches for this
work:

small-acpica-extension-to-be-able-to-store-the-name-of.patch
small-acpica-extension-to-be-able-to-store-the-name-of-fix.patch
export-acpi_check_resource_conflict.patch
export-acpi_check_resource_conflict-fix.patch
mm-only-enforce-acpi-resource-conflict-checks.patch

But now I see two new patches called

Subject: [PATCH] Provide acpi_check_{mem_}region (update)
Subject: [PATCH] ACPI: Export acpi_check_resource_conflict() (update #2)

<checks>

OK, the first is a renamed version of
small-acpica-extension-to-be-able-to-store-the-name-of.patch, perhaps of
small-acpica-extension-to-be-able-to-store-the-name-of.patch+small-acpica-extension-to-be-able-to-store-the-name-of-fix.patch.
I guess I need to dive into the diffs to find out whether the fix got lost
or not.

Please don't rename patches.


<looks more>

OK, afacit all we've done here is added this cleanup patch and then churned
all the other patches on top of it.  After fixing rejects in the
now-combined
small-acpica-extension-to-be-able-to-store-the-name-of.patch+small-acpica-extension-to-be-able-to-store-the-name-of-fix.patch
I didn't need "Provide acpi_check_{mem_}region (update)" and "ACPI: Export
acpi_check_resource_conflict() (update #2)" is just a little cleanup.

