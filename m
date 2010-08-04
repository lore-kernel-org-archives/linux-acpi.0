From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI: acpi_pad: fix uninitialized variable warning
Date: Wed, 04 Aug 2010 11:46:23 +0800
Message-ID: <4C58E28F.5080102@linux.intel.com>
References: <1280863052-31538-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36826 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758201Ab0HDDqn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Aug 2010 23:46:43 -0400
In-Reply-To: <1280863052-31538-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: trivial@kernel.org, linux-acpi@vger.kernel.org

=E4=BA=8E 8/4/2010 3:17 AM, Bill Pemberton =E5=86=99=E9=81=93:
> drivers/acpi/acpi_pad.c:432: warning: 'num_cpus' may be used
> uninitialized in this function
>
> num_cpus is set by the call to acpi_pad_pur()
>
> Signed-off-by: Bill Pemberton<wfp5p@virginia.edu>
> ---
>   drivers/acpi/acpi_pad.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index b76848c..69e2593 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -429,7 +429,7 @@ static void acpi_pad_ost(acpi_handle handle, int =
stat,
>
>   static void acpi_pad_handle_notify(acpi_handle handle)
>   {
> -	int num_cpus;
> +	int uninitialized_var(num_cpus);
>   	uint32_t idle_cpus;
>
>   	mutex_lock(&isolated_cpus_lock);
It is not necessary because the 1st usage of this variable is as=20
left-value, not right-value.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
