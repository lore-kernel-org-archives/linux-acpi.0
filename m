From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: SPCR: Mark expected switch fall-through in acpi_parse_spcr
Date: Wed, 14 Feb 2018 10:27:53 +0100
Message-ID: <1757557.bTtaD8LxG2@aspire.rjw.lan>
References: <20180209180821.GA20326@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209180821.GA20326@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-acpi@vger.kernel.org

On Friday, February 9, 2018 7:08:21 PM CET Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1465078
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> This code was compiled with GCC 7.3.0
> 
>  drivers/acpi/spcr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 89e97d2..9d52743 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -115,6 +115,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>  			table->serial_port.access_width))) {
>  		default:
>  			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
> +			/* fall through */
>  		case 8:
>  			iotype = "mmio";
>  			break;
> 

Applied, thanks!
