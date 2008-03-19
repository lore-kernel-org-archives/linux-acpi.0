From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10285] New: backlight is gone in X after
 closing/reopening the lid
Date: Wed, 19 Mar 2008 15:30:44 -0700
Message-ID: <20080319153044.9bc4f21a.akpm@linux-foundation.org>
References: <bug-10285-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54228 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S941387AbYCSWbh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 18:31:37 -0400
In-Reply-To: <bug-10285-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pavel@suse.cz
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Wed, 19 Mar 2008 15:20:03 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10285
> 
>            Summary: backlight is gone in X after closing/reopening the lid
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.25-rc6
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Power-Video
>         AssignedTo: acpi_power-video@kernel-bugs.osdl.org
>         ReportedBy: pavel@suse.cz
> OtherBugsDependingO 9832
>              nThis:
>         Regression: 1
> 
> 
> Latest working kernel version: 2.6.25-rc5
> Earliest failing kernel version: 2.6.25-rc6
> 
> HW: Thinkpad X60
> Steps to reproduce:
> 
> start X, close lid, reopen it, backlight flashes and then it is gone... making
> machine unusable until X are exited.
> 
> This revert of 9832 fixes it:

You mean "this revert of 4af8e10a6c57e7292862bd1703712f0565c7e429"

> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 7222a18..caf873c 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -943,7 +943,11 @@ int __init acpi_ec_ecdt_probe(void)
>                 boot_ec->command_addr = ecdt_ptr->control.address;
>                 boot_ec->data_addr = ecdt_ptr->data.address;
>                 boot_ec->gpe = ecdt_ptr->gpe;
> -               boot_ec->handle = ACPI_ROOT_OBJECT;
> +               if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
> +                               &boot_ec->handle))) {
> +                       pr_info("Failed to locate handle for boot EC\n");
> +                       boot_ec->handle = ACPI_ROOT_OBJECT;
> +               }
>         } else {
>                 /* This workaround is needed only on some broken machines,
>                  * which require early EC, but fail to provide ECDT */
> 

But the patch which you're reverting is itself a revert of
Alexey's 208c70a45624400fafd7511b96bc426bf01f8f5e.

We seem to be stuck.  I think we'd generally prefer the current state:
leave http://bugzilla.kernel.org/show_bug.cgi?id=9916 unfixed.

But it's all rather confusing.  
