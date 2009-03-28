From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 87/98] Fix state reporting in tc1100-wmi
Date: Sat, 28 Mar 2009 09:14:56 +0000
Message-ID: <200903280914.57293.carlos@strangeworlds.co.uk>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <1a8522f6537bc71153d2d19fdf238d4ff7fba17e.1238214620.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:50541 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbZC1JQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 05:16:04 -0400
In-Reply-To: <1a8522f6537bc71153d2d19fdf238d4ff7fba17e.1238214620.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Krzysztof =?utf-8?q?Kosi=C5=84ski?= <tweenk.pl@gmail.com>, Len Brown <len.brown@intel.com>

On Saturday 28 March 2009 04:32:02 Len Brown wrote:
> From: Krzysztof Kosi=C5=84ski <tweenk.pl@gmail.com>
>
> The tc1100-wmi driver should print the current states of wireless LAN=
 and
> jogdial brightness control when "cat
> /sys/devices/platform/tc1100-wmi/wireless" and "cat
> /sys/devices/platform/tc1100-wmi/jogdial" are executed, respectively.=
 What
> actually happens is that both of those commands print 0 regardless of=
 the
> hardware state. The cause is that wmi_query_block returns an
> ACPI_TYPE_INTEGER rather than ACPI_TYPE_BUFFER as the driver assumes.
> Additionally, the driver intends to return a jogdial state that is in=
verted
> with respect to the commands required to set it (e.g. it intends to r=
eturn
> 1 after the jogdial file was written with 0).
>
> This patch fixes both of those issues - the commands to query the
> state now work, and should return the same state that was written.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=3D12286
>
> Signed-off-by: Krzysztof Kosi=C5=84ski <tweenk.pl@gmail.com>

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/platform/x86/tc1100-wmi.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/tc1100-wmi.c
> b/drivers/platform/x86/tc1100-wmi.c index b4a4aa9..4416600 100644
> --- a/drivers/platform/x86/tc1100-wmi.c
> +++ b/drivers/platform/x86/tc1100-wmi.c
> @@ -94,9 +94,8 @@ static int get_state(u32 *out, u8 instance)
>  		return -ENODEV;
>
>  	obj =3D (union acpi_object *) result.pointer;
> -	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER &&
> -		obj->buffer.length =3D=3D sizeof(u32)) {
> -		tmp =3D *((u32 *) obj->buffer.pointer);
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +		tmp =3D obj->integer.value;
>  	} else {
>  		tmp =3D 0;
>  	}
> @@ -109,7 +108,7 @@ static int get_state(u32 *out, u8 instance)
>  		*out =3D (tmp =3D=3D 3) ? 1 : 0;
>  		return 0;
>  	case TC1100_INSTANCE_JOGDIAL:
> -		*out =3D (tmp =3D=3D 1) ? 1 : 0;
> +		*out =3D (tmp =3D=3D 1) ? 0 : 1;
>  		return 0;
>  	default:
>  		return -ENODEV;

--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
