From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] ACPI processor: force throttling state when BIOS
 returns incorrect value
Date: Wed, 26 Aug 2009 12:16:19 -0700
Message-ID: <20090826121619.2bc7e72b.akpm@linux-foundation.org>
References: <200908171443.35622.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41973 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751229AbZHZTQV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 15:16:21 -0400
In-Reply-To: <200908171443.35622.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@intel.com, rui.zhang@intel.com

On Mon, 17 Aug 2009 14:43:34 +0200
Frans Pop <elendil@planet.nl> wrote:

> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -62,7 +62,8 @@ struct throttling_tstate {
>  #define THROTTLING_POSTCHANGE      (2)
>  
>  static int acpi_processor_get_throttling(struct acpi_processor *pr);
> -int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
> +int acpi_processor_set_throttling(struct acpi_processor *pr,
> +						int state, bool force);
>  

WARNING: externs should be avoided in .c files
#74: FILE: drivers/acpi/processor_throttling.c:65:
+int acpi_processor_set_throttling(struct acpi_processor *pr,

total: 0 errors, 1 warnings, 137 lines checked

checkpatch speaketh truth - there's already a declaration in
acpi/processor.h anyway.

I'll leave it alone though.  Cleaning up acpi code isn't on the agenda
for today.

Please integrate checkpatch into your patch preparation tools.  It
finds stuff.
