From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/2] tools acpidump: acpidump must be run as root -
 install it into /usr/sbin
Date: Fri, 21 Dec 2012 15:20:32 +0800
Message-ID: <1356074432.29771.3.camel@linux-s257.site>
References: <1355591519-44664-1-git-send-email-trenn@suse.de>
	 <1355591519-44664-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57622 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab2LUHWL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Dec 2012 02:22:11 -0500
In-Reply-To: <1355591519-44664-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org

=E6=96=BC =E5=85=AD=EF=BC=8C2012-12-15 =E6=96=BC 18:11 +0100=EF=BC=8CTh=
omas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> Signed-off-by: Thomas Renninger <trenn@suse.de>

Tested-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey lee

> ---
>  tools/power/acpi/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
> index 8650fd8..c5cbe30 100644
> --- a/tools/power/acpi/Makefile
> +++ b/tools/power/acpi/Makefile
> @@ -21,7 +21,7 @@ clean:
>  	done
> =20
>  install:
> -	install acpidump /usr/bin/acpidump
> +	install acpidump /usr/sbin/acpidump
>  	install acpidump.8 /usr/share/man/man8
>  	for dir in $(SUBDIRS); do \
>  		$(MAKE) -C $$dir install; \


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
