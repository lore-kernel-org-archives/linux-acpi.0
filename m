From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] ACPI/CPC: Don't try to clean up uninitialized CPC data
Date: Fri, 16 Dec 2016 14:52:35 -0700
Message-ID: <274267e0-d41a-83b1-b4d6-ee7af51ace49@codeaurora.org>
References: <1481913346-16321-1-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757707AbcLPVwi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2016 16:52:38 -0500
In-Reply-To: <1481913346-16321-1-git-send-email-boris.ostrovsky@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Boris,

On 12/16/2016 11:35 AM, Boris Ostrovsky wrote:
> If acpi_cppc_processor_probe() had not executed successfully (for
> example, if _CPC object was not found) then cpc_desc_ptr for that
> processor will be invalid.
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d0d0504..5bba26e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -824,6 +824,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  	void __iomem *addr;
>  
>  	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
> +	if (!cpc_ptr)
> +		return;
>  
>  	/* Free all the mapped sys mem areas for this CPU */
>  	for (i = 2; i < cpc_ptr->num_entries; i++) {
I think a recent patch from Sebastian fixed the same issue.
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9e9d68dad58c70f40f50adfeabd2fdaa39a743fd

--
Thanks,
Prashanth
