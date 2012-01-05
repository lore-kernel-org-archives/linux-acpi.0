From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] acpi/apei/einj: Add extensions to EINJ from rev 5.0 of
 acpi spec
Date: Thu, 05 Jan 2012 14:17:19 +0800
Message-ID: <4F05406F.5030805@linux.intel.com>
References: <212c4cabb390880e855be9509e7d2be002699907.1325716284.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62778 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab2AEGRW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jan 2012 01:17:22 -0500
In-Reply-To: <212c4cabb390880e855be9509e7d2be002699907.1325716284.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ying.huang@intel.com

=E4=BA=8E 2012/1/5 6:29, Tony Luck =E5=86=99=E9=81=93:
> ACPI 5.0 provides extensions to the EINJ mechanism to specify the
> target for the error injection - by APICID for cpu related errors,
> by address for memory related errors, and by segment/bus/device/funct=
ion
> for PCIe related errors. Also extensions for vendor specific error
> injections.
>
> Tested-by: Chen Gong<gong.chen@linux.intel.com>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> ---
>
> [Code is identical to version posted on November 29th, 2011 - but add=
ed changes
>   to einj.txt in response to all the questions from Chen Gong]
>
>   Documentation/acpi/apei/einj.txt |   43 ++++++--
>   drivers/acpi/apei/einj.c         |  217 +++++++++++++++++++++++++++=
++++------
>   include/acpi/actbl1.h            |    3 +-
>   3 files changed, 215 insertions(+), 48 deletions(-)
>
> diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/ap=
ei/einj.txt
> index 5cc699b..95a2b22 100644
> --- a/Documentation/acpi/apei/einj.txt
> +++ b/Documentation/acpi/apei/einj.txt
> @@ -47,20 +47,41 @@ directory apei/einj. The following files are prov=
ided.
>
>   - param1
>     This file is used to set the first error parameter value. Effect =
of
> -  parameter depends on error_type specified. For memory error, this =
is
> -  physical memory address.  Only available if param_extension module
> -  parameter is specified.
> +  parameter depends on error_type specified.
>
>   - param2
>     This file is used to set the second error parameter value. Effect=
 of
> -  parameter depends on error_type specified. For memory error, this =
is
> -  physical memory address mask.  Only available if param_extension
> -  module parameter is specified.
> +  parameter depends on error_type specified.
>
> -Injecting parameter support is a BIOS version specific extension, th=
at
> -is, it only works on some BIOS version.  If you want to use it, plea=
se
> -make sure your BIOS version has the proper support and specify
> -"param_extension=3Dy" in module parameter.
> +BIOS versions based in the ACPI 4.0 specification have limited optio=
ns
> +to control where the errors are injected.  Your BIOS may support an
> +extension (enabled with the param_extension=3D1 module parameter, or
> +boot command line einj.param_extension=3D1). This allows the address
> +and mask for memory injections to be specified by the param1 and
> +param2 files in apei/einj.
> +
> +BIOS versions using the ACPI 5.0 specification have more control ove=
r
> +the target of the injection. For processor related errors (type 0x1,
> +0x2 and 0x4) the APICID of the target should be provided using the
> +param1 file in apei/einj. For memory errors (type 0x8, 0x10 and 0x20=
)
> +the address is set using param1 with a mask in param2 (0x0 is equiva=
lent
> +to all ones). For PCI express errors (type 0x80, 0x80 and 0x100) the
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^
                                     should be 0x40, 0x80 and 0x100

> +segment, bus, device and function are specified using param1:
> +
> +         31     24 23    16 15    11 10      8  7        0
> +	+-------------------------------------------------+
> +	| segment |   bus  | device | function | reserved |
> +	+-------------------------------------------------+
> +
> +An ACPI 5.0 BIOS may also allow vendor specific errors to be injecte=
d.
> +In this case a file named vendor will contain identifying informatio=
n
> +from the BIOS that hopefully will allow an application wishing to us=
e
> +the vendor specific extension to tell that they are running on a BIO=
S
> +that supports it. All vendor extensions have the 0x80000000 bit set =
in
> +error_type. A file vendor_flags controls the interpretation of param=
1
> +and param2 (1 =3D PROCESSOR, 2 =3D MEMORY, 4 =3D PCI). See your BIOS=
 vendor
> +documentation for details (and expect changes to this API if vendors
> +creativity in using this feature expands beyond our expectations).
>
>   For more information about EINJ, please refer to ACPI specification
> -version 4.0, section 17.5.
> +version 4.0, section 17.5 and ACPI 5.0, section 18.6.

In my own opinion, it is too hard for the one to use all kinds of combi=
nations
to control test conditions. If still keeping current parameters, I sugg=
est
adding some examples to clarify them.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
