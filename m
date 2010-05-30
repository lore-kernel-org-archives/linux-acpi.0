From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
 to RAM
Date: Sun, 30 May 2010 17:40:04 +0300
Message-ID: <1275230404.14907.11.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275078735-1866-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55109 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521Ab0E3OkJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 May 2010 10:40:09 -0400
In-Reply-To: <1275078735-1866-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 2010-05-28 at 16:32 -0400, Matthew Garrett wrote: 
> https://bugzilla.kernel.org/show_bug.cgi?id=13931 describes a bug where
> a system fails to successfully resume after the second suspend. Maxim
> Levitsky discovered that this could be rectified by forcibly saving
> and restoring the ACPI non-volatile state. The spec indicates that this
> is only required for S4, but testing the behaviour of Windows by adding
> an ACPI NVS region to qemu's e820 map and registering a custom memory
> read/write handler reveals that it's saved and restored even over suspend
> to RAM. We should mimic that behaviour to avoid other broken platforms.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/sleep.c |   21 +++++++++++++--------
>  1 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index d3cbc55..18aa074 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -128,6 +128,8 @@ static int __acpi_pm_prepare(void)
>  {
>  	int error = acpi_sleep_prepare(acpi_target_sleep_state);


Just one note, I am sure somebody will ask for s3_no_nvs option, just
like s4_no_nvs.

Also this needs to be rebased, like the first patch.

Best regards,
Maxim Levitsky

