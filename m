From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Wed, 26 Nov 2014 17:53:11 +0800
Message-ID: <5475A307.8040605@linaro.org>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <1416926930-792-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64694 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaKZJzT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 04:55:19 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so2505873pdb.15
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2014 01:55:19 -0800 (PST)
In-Reply-To: <1416926930-792-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Sudeep,

On 2014-11-25 22:48, Sudeep Holla wrote:
> phys_id in acpi_processor structure is unsigned 32-bit integer,
> comparing it with signed value is incorrect.

Yes, this is a bug :)

But the phys_id in acpi_processor structure should be signed value because
acpi_get_phys_id() will return -1 if there if no CPU entry found in MADT
table.

I found the id in acpi_processor structure should also be signed value by
unsigned now, we should fix that too.

> 
> This patch removes that incorrect comparision in acpi_processor_hotadd_init
> as the lone user of this function is already checking for correctness
> of phys_id before calling it.

	if (apic_id < 0)
		acpi_handle_debug(pr->handle, "failed to get CPU APIC ID.\n");

it only check the value and print debug message but no returns, so I think
the check in the following patch is still needed.

> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/acpi_processor.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c4a8a5666298..eaf56f6ce1eb 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -170,9 +170,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	acpi_status status;
>  	int ret;
>  
> -	if (pr->phys_id == -1)
> -		return -ENODEV;

I prepared a patch below:

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 8e34af9..cfdab24 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -199,8 +199,8 @@ struct acpi_processor_flags {
 struct acpi_processor {
        acpi_handle handle;
        u32 acpi_id;
-       u32 phys_id;    /* CPU hardware ID such as APIC ID for x86 */
-       u32 id;         /* CPU logical ID allocated by OS */
+       int phys_id;    /* CPU hardware ID such as APIC ID for x86 */
+       int id;         /* CPU logical ID allocated by OS */
        u32 pblk;
        int performance_platform_limit;
        int throttling_platform_limit;

what do you think?

Thanks
Hanjun
