From: Yu Luming <luming.yu@intel.com>
Subject: Re: Help on a ACPI error message during kernel boot
Date: Fri, 29 Sep 2006 13:15:24 +0800
Message-ID: <200609291315.24865.luming.yu@intel.com>
References: <ac8af0be0609281945y7eb5129bp61e9fc7b489cf838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38245 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161416AbWI2FJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Sep 2006 01:09:03 -0400
In-Reply-To: <ac8af0be0609281945y7eb5129bp61e9fc7b489cf838@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-acpi@vger.kernel.org

>  When booting the linux on my hardware, ACPI output some error messag=
es
>  like this:
>
>  PCI: Using configuration type 1
>  =A0=A0=A0 ACPI-1121: *** Error: Method execution failed [\_SB_.LNKA.=
_STA]
>  (Node 0000010011dcb6c0), AE_AML_REGION_LIMIT
>  =A0=A0=A0 ACPI-0098: *** Error: Method execution failed [\_SB_.LNKA.=
_STA]
>  (Node 0000010011dcb6c0), AE_AML_REGION_LIMIT
>  =A0=A0=A0 ACPI-1121: *** Error: Method execution failed [\_SB_.LNKB.=
_STA]
>  (Node 0000010011dcb8c0), AE_AML_REGION_LIMIT
>  =A0=A0=A0 ACPI-0098: *** Error: Method execution failed [\_SB_.LNKB.=
_STA]
>  (Node 0000010011dcb8c0), AE_AML_REGION_LIMIT

what's kernel version?
Looks like a AML interpreter issue.
Please open a bug on bugzilla.kernel.org,
and post acpidump output.

--=20
Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
