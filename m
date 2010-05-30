From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic
 suspend functionality
Date: Sun, 30 May 2010 17:37:18 +0300
Message-ID: <1275230238.14907.8.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40214 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab0E3OhY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 May 2010 10:37:24 -0400
In-Reply-To: <1275078735-1866-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Fri, 2010-05-28 at 16:32 -0400, Matthew Garrett wrote: 
> Saving platform non-volatile state may be required for suspend to RAM as
> well as hibernation. Move it to more generic code.


Since the other patch 'ACPI / EC / PM: Fix race between EC transactions
and system suspend' is now merged, this should be rebased on top of it
(I did the opposite....)

.... 
> diff --git a/kernel/power/nvs.c b/kernel/power/nvs.c
> new file mode 100644
> index 0000000..1836db6
> --- /dev/null
> +++ b/kernel/power/nvs.c
> @@ -0,0 +1,136 @@
> +/*
> + * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
This should be updated (I did in the version I posted) 
> + *
> + * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
> +
............


Best regards,
Maxim Levitsky

