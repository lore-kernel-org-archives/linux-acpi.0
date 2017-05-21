From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V3] acpi: apei: check for pending errors when probing
 GHES entries
Date: Sun, 21 May 2017 15:39:10 +0200
Message-ID: <20170521133910.GA5676@nazgul.tnic>
References: <1495142562-7318-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbdEUNjb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 21 May 2017 09:39:31 -0400
Content-Disposition: inline
In-Reply-To: <1495142562-7318-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, prarit@redhat.com, bhelgaas@google.com, punit.agrawal@arm.com, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, shiju.jose@huawei.com, James.Morse@arm.com, ahs3@redhat.com

On Thu, May 18, 2017 at 03:22:42PM -0600, Tyler Baicar wrote:
> Check for pending errors when probing GHES entries. It is possible
> that a fatal error is already pending at this point, so we should
> handle it as soon as the driver is probed. This also avoids a
> potential issue if there was an interrupt that was already
> cleared for an error since the GHES driver wasn't present.
> 
> V3: Check for pending errors of all GHES types
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d0855c0..5347230 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1039,6 +1039,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  	}
>  	platform_set_drvdata(ghes_dev, ghes);
>  
> +	/* Handle any pending errors right away */
> +	ghes_proc(ghes);
> +
>  	return 0;
>  err_edac_unreg:
>  	ghes_edac_unregister(ghes);

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
