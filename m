From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 0/9] [RFC] sonypi ACPI reimplementation (resend 3)
Date: Tue, 10 Apr 2007 16:13:43 -0400
Message-ID: <200704101613.43751.lenb@kernel.org>
References: <20070409081903.057292676@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37887 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362AbXDJUPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Apr 2007 16:15:25 -0400
In-Reply-To: <20070409081903.057292676@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stelian@popies.net

On Monday 09 April 2007 04:19, malattia@linux.it wrote:
> [Resend 3: hopefully this time it will make to the list and the intended
> recipients]
> 
> The following patch series is the state of the art of my work toward
> reimplementing sonypi into sony-laptop. Most patches are mostly cosmetic
> to try to obtain a decent namespace separation between the used
> subsystems and the drivers driving the two sony devices (SNC and SPIC).
> If suitable it would be nice to start applying to acpi-test so that akpm
> gets them in -mm (update: it's already in .21-rc6-mm1).
> 
> Len, if you prefer a big large patch or a different series, just ask.

This is fine, thanks.

> The most interesting patches are probably 0004, 0006 and 0009.
> Andrew, the 9th patch is now really against acpi-test (I think the Kconfig hunk
> didn't apply correclty).

BTW. I check-in on top of Linus' tree, not on top of acpi-test.
Then i merge into acpi-test.  So in the future, you could just as well base
on Linus' tree and let me deal with the conflicts within acpi-test.
fine with me either way, just mention where the base is like you have.

> 0001-Remove-ACPI-references-from-variable-and-function-names.patch
> 0002-prepare-pfdriver-for-multiple-users.patch
> 0003-introduce-debug-macros.patch
> 0004-add-sny6001-device-handling-from-sonypi.patch
> 0005-unify-input-subsystem-event-fwd.patch
> 0006-add-SNY6001-platform-attributes.patch
> 0007-sanitize-printk-logs.patch
> 0008-update-documentation.patch
> 0009-add-sonypi-compat-code.patch
> ---
>  Documentation/sony-laptop.txt |   25 
>  drivers/misc/Kconfig          |   15 
>  drivers/misc/sony-laptop.c    | 2019 +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 1842 insertions(+), 217 deletions(-)


>SONY_LAPTOP_OLD 

There is probably a better name for this -- like SONY_PI_COMPATIBILITY or something.

What about CONFIG_SONYPI? -- should it now depend on this driver not being included?

SONYPI depends on !64BIT -- is that invalid, or perhaps you only need the compatibility
stuff only in 32-bit mode?

applied to acpi-test.

It would be great if you can get some test feedback for the sonypi-era features
to make sure that the code moved into the new driver works as well as the old sonypi.

thanks,
-Len
