From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Fix "buggy BIOS check" when CPUs are hot removed
Date: Tue, 8 Apr 2008 00:03:48 -0700
Message-ID: <20080408000348.0394dd35.akpm@linux-foundation.org>
References: <1207352924.6294.29.camel@promb-2n-dhcp158.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37371 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbYDHHEG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2008 03:04:06 -0400
In-Reply-To: <1207352924.6294.29.camel@promb-2n-dhcp158.eng.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: len.brown@intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Arai <arai@vmware.com>, Zachary Amsden <zach@vmware.com>, stable@kernel.org

On Fri, 04 Apr 2008 16:48:44 -0700 Alok Kataria <akataria@vmware.com> wrote:

> Fixes a BUG in ACPI hotplugging.
> 
> processor_device_array[pr->id] needs to be set to NULL when removing a
> CPU. Else the "buggy BIOS check" in acpi_processor_start mistakenly
> fires when a CPU is removed from the system and then later re-added.
> 
> Signed-off-by: Alok N Kataria <akataria@vmware.com>
> Signed-off-by: Dan Arai <arai@vmware.com>

I assume this is also needed in 2.6.24.x?

> diff --git a/drivers/acpi/processor_core.c
> b/drivers/acpi/processor_core.c
> index 61450f4..0f95f26 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -828,6 +828,7 @@ static int acpi_processor_remove(struct acpi_device
> *device, int type)
> }
> 
> processors[pr->id] = NULL;
> + processor_device_array[pr->id] = NULL;
> 
> kfree(pr);
> 

That set a new record for patch-manglement.
