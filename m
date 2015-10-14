From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/4] ACPI: for bad_madt_entry(), the GIC ITS table is 20 bytes long, not 16
Date: Thu, 15 Oct 2015 01:39:15 +0200
Message-ID: <2164493.DUcQPnEyLL@vostro.rjw.lan>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org> <1444857985-28844-5-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47575 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753156AbbJNXKd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 19:10:33 -0400
In-Reply-To: <1444857985-28844-5-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Wednesday, October 14, 2015 03:26:25 PM Al Stone wrote:
> Correct a typo where bad_madt_entry() expected the MADT GIC ITS subtable
> to be 16 bytes long, but it is actually 20 bytes.  This is a cut'n'paste
> error picked up from the spec and inadvertently replicated in code.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/tables.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 790d4b0..1b7c13e 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -292,7 +292,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>   * GICD                  0xc                         24    24    24
>   * GICv2m MSI            0xd                               24    24
>   * GICR                  0xe                               16    16
> - * GIC ITS               0xf                                     16
> + * GIC ITS               0xf                                     20
>   *
>   * In the table, each length entry is what should be in the length
>   * field of the subtable, and -- in general -- it should match the
> @@ -366,7 +366,7 @@ static struct acpi_madt_subtable_lengths spec_info[] = {
>  		.madt_version = 3,
>  		.num_types = 16,
>  		.lengths = { 8, 12, 10, 8, 6, 12, 16, SUBTABLE_VARIABLE,
> -			     16, 16, 12, 80, 24, 24, 16, 16 }
> +			     16, 16, 12, 80, 24, 24, 16, 20 }
>  	},
>  	{ /* terminator */
>  		.major_version = 0,
> 

That really needs to be folded into the original patch to avoid creating
artificial bisection holes.

Thanks,
Rafael

