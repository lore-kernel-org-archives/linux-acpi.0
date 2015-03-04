From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 6/9] ACPI: move _OSI support functions to allow arch-dependent implementation
Date: Thu, 05 Mar 2015 00:09:27 +0100
Message-ID: <2609016.EPbkEHRv6B@vostro.rjw.lan>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-7-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65308 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752929AbbCDWpv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2015 17:45:51 -0500
In-Reply-To: <1424824585-6405-7-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Tuesday, February 24, 2015 05:36:22 PM al.stone@linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Having moved the _OSI callback function needed by ACPICA from
> drivers/acpi/osl.c to drivers/acpi/osi.c, we now move all the
> remaining _OSI support functions to osi.c.
> 
> This patch is much larger than I had wanted it to be; several of the
> functions that implemented acpi_osi* command line options, or did the
> set up of the interfaces to be provided by _OSI, shared a static struct.
> Hence, I ended up moving a bunch of code at once rather than perhaps a
> function at a time.
> 
> With this patch, all the _OSI-associated code has now been moved
> to osi.c, and we next change the build so that we can make the
> _OSI implementation arch-dependent.
> 
> There is no functional change.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/osi.c   | 152 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/acpi/osl.c   | 187 ---------------------------------------------------
>  include/linux/acpi.h |   5 +-
>  3 files changed, 154 insertions(+), 190 deletions(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index f23aa70..9943b7a 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -30,6 +30,8 @@ ACPI_MODULE_NAME("osi");
>  
>  #define PREFIX			"ACPI: "
>  
> +static void __init acpi_osi_setup_late(void);
> +
>  /*
>   * The story of _OSI(Linux)
>   *
> @@ -68,10 +70,14 @@ static struct osi_linux {
>  	unsigned int	dmi:1;
>  	unsigned int	cmdline:1;
>  	unsigned int	default_disabling:1;
> -} osi_linux = {0, 0, 0, 0};
> +	unsigned int	interfaces_added:1;
> +} osi_linux = {0, 0, 0, 0, 0};
>  
>  u32 acpi_osi_handler(acpi_string interface, u32 supported)
>  {
> +	if (!osi_linux.interfaces_added)
> +		acpi_osi_setup_late();
> +

This wasn't there in the old code.

Please don't mix moving code around with adding new things to it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
