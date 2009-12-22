From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: BUG printk with not null-terminated string in driver
 /drivers/acpi/osl.c
Date: Tue, 22 Dec 2009 18:12:48 +0100
Message-ID: <20091222171248.GA20318@atjola.homenet>
References: <200912221846.02318.strakh@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751554AbZLVRM5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2009 12:12:57 -0500
Content-Disposition: inline
In-Reply-To: <200912221846.02318.strakh@ispras.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Strakh <strakh@ispras.ru>
Cc: Matthew Wilcox <willy@linux.intel.com>, Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>, Andy Grover <andrew.grover@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2009.12.22 18:46:02 +0000, Alexander Strakh wrote:
>         In driver drivers/acpi/osl.c in function acpi_osi_setup:
> 1. If in line 555 *osi_additional_string =3D=3D 0 then we goto line 1=
039

I guess that's meant to be line 1038?

> 2. In line 1039: if length of str > OSI_STRING_LENGTH_MAX then=20
> osi_additional_string not have 0 at the end.
> 3. In line 1040 printk called with not null-terminated string.

That printk uses str, not osi_additional_string.

> diff --git a/./0000/drivers/acpi/osl.c b/./0001/drivers/acpi/osl.c
> index 02e8464..9c759f8 100644
> --- a/./0000/drivers/acpi/osl.c
> +++ b/./0001/drivers/acpi/osl.c
> @@ -1037,6 +1037,7 @@ int __init acpi_osi_setup(char *str)
>  		acpi_cmdline_osi_linux(1);	/* enable */
>  	} else if (*osi_additional_string =3D=3D '\0') {
>  		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
> +		osi_additional_string[OSI_STRING_LENGTH_MAX - 1] =3D 0;

That will break the test in acpi_os_validate_interface for strings
longer than OSI_STRING_LENGTH_MAX (incl. the NUL byte). And that's the
only other user of osi_additional_string and doesn't require the
terminating NUL byte. So this shouldn't be needed.

Bj=F6rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
