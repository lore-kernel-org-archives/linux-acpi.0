From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 5/5] edac drivers: add MC owner check in init
Date: Fri, 1 Sep 2017 11:31:31 +0200
Message-ID: <20170901093131.q4afqnd5iyktdhe2@pd.tnic>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
 <20170823225447.15608-6-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:41076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdIAJbz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Sep 2017 05:31:55 -0400
Content-Disposition: inline
In-Reply-To: <20170823225447.15608-6-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 23, 2017 at 04:54:47PM -0600, Toshi Kani wrote:
> Change generic x86 edac drivers, which probe CPU type with
> x86_match_cpu(), to verify the module owner at the beginning
> of their module init functions.  This allows them to fail
> their init immediately when ghes_edac is enabled.  Similar
> change can be made to other edac drivers as necessary.
> 
> Also, remove ".c" from module names of pnp2_edac, sb_edac,
> and skx_edac.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/amd64_edac.c |    5 +++++
>  drivers/edac/pnd2_edac.c  |    9 ++++++++-
>  drivers/edac/sb_edac.c    |    9 +++++++--
>  drivers/edac/skx_edac.c   |    9 ++++++++-
>  4 files changed, 28 insertions(+), 4 deletions(-)

Last 2 applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
