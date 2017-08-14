From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/3] GHES: Move memory initialisation to ghes_probe()
Date: Mon, 14 Aug 2017 21:22:56 +0200
Message-ID: <20170814192256.56zoo5hgbyake25b@pd.tnic>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
 <20170801133608.21017-3-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750771AbdHNTXG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Aug 2017 15:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20170801133608.21017-3-punit.agrawal@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Punit Agrawal <punit.agrwal@arm.com>, James Morse <james.morse@arm.com>

On Tue, Aug 01, 2017 at 02:36:07PM +0100, Punit Agrawal wrote:
> During the driver init, the ghes driver initialises some data structures

Let's stick to "GHES" in capital letters everywhere.

> which are only used if a GHES platform device is probed. Similarly, the
> init function also checks for support for firmware first mode.
> 
> Create a function, ghes_common_init(), that performs the initialisations
> and checks that are currently performed on driver init. The function is
> called when the GHES device is probed.
> 
> Delaying initialisation and checks until probe has the added benefit of
> reducing driver prints on systems that do not support ACPI APEI.
> 
> Signed-off-by: Punit Agrawal <punit.agrwal@arm.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 007b38abcb34..befb18338acb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1088,12 +1088,53 @@ static inline void ghes_nmi_init_cxt(void)
>  }
>  #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
>  
> +static int ghes_common_init(void)
> +{
> +	int rc;
> +	static bool initialised;
> +
> +	if (initialised)
> +		return 0;

Can't say that I like it. Especially for this "initialised" thing, which
practically says that this code doesn't conceptually belong here because
we have to explicitly force it to execute it only once. Even though we
have execute-once path in ghes_init().

What would be much better IMHO is if ghes_init() checked for some APEI
table which is missing on your system and exited early. That would save
us all the trouble and solve the situation properly ...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
