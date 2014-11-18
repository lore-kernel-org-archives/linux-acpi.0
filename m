From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1 linux-next] ACPI: remove unnecessary sizeof(u8)
Date: Wed, 19 Nov 2014 00:28:32 +0100
Message-ID: <3970319.cPmRxBPPro@vostro.rjw.lan>
References: <1416131820-7336-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60521 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932700AbaKRXH2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 18:07:28 -0500
In-Reply-To: <1416131820-7336-1-git-send-email-fabf@skynet.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sunday, November 16, 2014 10:57:00 AM Fabian Frederick wrote:
> sizeof(u8) is always 1.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Queued up for 3.19-rc1, thanks!

> ---
>  drivers/acpi/utils.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 371ac12..dd8ff63 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -136,8 +136,7 @@ acpi_extract_package(union acpi_object *package,
>  				break;
>  			case 'B':
>  				size_required +=
> -				    sizeof(u8 *) +
> -				    (element->buffer.length * sizeof(u8));
> +				    sizeof(u8 *) + element->buffer.length;
>  				tail_offset += sizeof(u8 *);
>  				break;
>  			default:
> @@ -255,7 +254,7 @@ acpi_extract_package(union acpi_object *package,
>  				memcpy(tail, element->buffer.pointer,
>  				       element->buffer.length);
>  				head += sizeof(u8 *);
> -				tail += element->buffer.length * sizeof(u8);
> +				tail += element->buffer.length;
>  				break;
>  			default:
>  				/* Should never get here */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
