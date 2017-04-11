From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/2] ACPI: ACPICA: Cleanup drivers/acpi/acpica Makefile
Date: Tue, 11 Apr 2017 07:19:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE8DA28@SHSMSX101.ccr.corp.intel.com>
References: <796420b4be45373de2e0c6148062fb8d8ddbbcb4.1490930522.git.lv.zheng@intel.com>
 <201704021640.4xwSssrU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33426 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753600AbdDKHbE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 03:31:04 -0400
In-Reply-To: <201704021640.4xwSssrU%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lkp <lkp@intel.com>

Hi, Rafael

According to the test, PATCH 02 is not possible unless ACPICA debugging fun=
ction stubs are correctly prepared for ACPI_DEBUG_OUTPUT=3Dn.
So please help to drop PATCH 02 and only PATCH 01 is useful for now.

Thanks and best regards
Lv


> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kern=
el.org] On Behalf Of kbuild
> test robot
> Subject: Re: [PATCH 2/2] ACPI: ACPICA: Cleanup drivers/acpi/acpica Makefi=
le
>=20
> Hi Lv,
>=20
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on v4.11-rc4 next-20170331]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Lv-Zheng/ACPI-ACPICA-Add=
-non-linux-host-build-
> support/20170402-125838
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it linux-next
> reproduce:
>         # apt-get install sparse
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/platform/x86/panasonic-laptop.c:266:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:282:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:289:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:295:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:306:25: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:462:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:478:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 3 given
>    drivers/platform/x86/panasonic-laptop.c:514:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:521:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:560:9: sparse: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 3 given
>    drivers/platform/x86/panasonic-laptop.c:579:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:585:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:605:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    drivers/platform/x86/panasonic-laptop.c:611:17: sparse: macro "ACPI_AC=
TUAL_DEBUG" requires 6
> arguments, but only 2 given
>    include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address=
': unknown attribute
>    drivers/platform/x86/panasonic-laptop.c:266:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:579:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:585:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:605:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:611:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:560:9: sparse: undefined ident=
ifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:282:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:289:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:295:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:306:25: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:462:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:478:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:514:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c:521:17: sparse: undefined iden=
tifier 'ACPI_ACTUAL_DEBUG'
>    drivers/platform/x86/panasonic-laptop.c: In function 'acpi_pcc_get_sqt=
y':
>    drivers/platform/x86/panasonic-laptop.c:267:38: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>           "evaluation error HKEY.SQTY\n"));
>                                          ^
>    In file included from include/acpi/acpi.h:61:0,
>                     from include/linux/acpi.h:33,
>                     from drivers/platform/x86/panasonic-laptop.c:128:
>    include/acpi/acoutput.h:338:41: error: 'ACPI_ACTUAL_DEBUG' undeclared =
(first use in this function)
>     #define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
>                                             ^
>    drivers/platform/x86/panasonic-laptop.c:266:3: note: in expansion of m=
acro 'ACPI_DEBUG_PRINT'
>       ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>       ^~~~~~~~~~~~~~~~
>    include/acpi/acoutput.h:338:41: note: each undeclared identifier is re=
ported only once for each
> function it appears in
>     #define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
>                                             ^
>    drivers/platform/x86/panasonic-laptop.c:266:3: note: in expansion of m=
acro 'ACPI_DEBUG_PRINT'
>       ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>       ^~~~~~~~~~~~~~~~
>    drivers/platform/x86/panasonic-laptop.c: In function 'acpi_pcc_retriev=
e_biosdata':
>    drivers/platform/x86/panasonic-laptop.c:283:38: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>           "evaluation error HKEY.SINF\n"));
>                                          ^
>    In file included from include/acpi/acpi.h:61:0,
>                     from include/linux/acpi.h:33,
>                     from drivers/platform/x86/panasonic-laptop.c:128:
>    include/acpi/acoutput.h:338:41: error: 'ACPI_ACTUAL_DEBUG' undeclared =
(first use in this function)
>     #define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
>                                             ^
>    drivers/platform/x86/panasonic-laptop.c:282:3: note: in expansion of m=
acro 'ACPI_DEBUG_PRINT'
>       ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>       ^~~~~~~~~~~~~~~~
>    drivers/platform/x86/panasonic-laptop.c:289:58: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>       ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF\n"));
>                                                              ^
>    drivers/platform/x86/panasonic-laptop.c:296:39: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>          "SQTY reports bad SINF length\n"));
>                                           ^
>    drivers/platform/x86/panasonic-laptop.c:307:34: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>           "Invalid HKEY.SINF data\n"));
>                                      ^
>    drivers/platform/x86/panasonic-laptop.c: In function 'acpi_pcc_generat=
e_keyinput':
>    drivers/platform/x86/panasonic-laptop.c:463:38: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>          "error getting hotkey status\n"));
>                                          ^
>    In file included from include/acpi/acpi.h:61:0,
>                     from include/linux/acpi.h:33,
>                     from drivers/platform/x86/panasonic-laptop.c:128:
>    include/acpi/acoutput.h:338:41: error: 'ACPI_ACTUAL_DEBUG' undeclared =
(first use in this function)
>     #define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
>                                             ^
>    drivers/platform/x86/panasonic-laptop.c:462:3: note: in expansion of m=
acro 'ACPI_DEBUG_PRINT'
>       ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>       ^~~~~~~~~~~~~~~~
>    drivers/platform/x86/panasonic-laptop.c:479:44: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 3 given
>           "Unknown hotkey event: %d\n", result));
>                                                ^
>    drivers/platform/x86/panasonic-laptop.c: In function 'acpi_pcc_init_in=
put':
>    drivers/platform/x86/panasonic-laptop.c:515:47: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>           "Unable to setup input device keymap\n"));
>                                                   ^
>    In file included from include/acpi/acpi.h:61:0,
>                     from include/linux/acpi.h:33,
>                     from drivers/platform/x86/panasonic-laptop.c:128:
>    include/acpi/acoutput.h:338:41: error: 'ACPI_ACTUAL_DEBUG' undeclared =
(first use in this function)
>     #define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
>                                             ^
>    drivers/platform/x86/panasonic-laptop.c:514:3: note: in expansion of m=
acro 'ACPI_DEBUG_PRINT'
>       ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>       ^~~~~~~~~~~~~~~~
>    drivers/platform/x86/panasonic-laptop.c:522:43: error: macro "ACPI_ACT=
UAL_DEBUG" requires 6
> arguments, but only 2 given
>           "Unable to register input device\n"));
>=20
> vim +/ACPI_ACTUAL_DEBUG +266 drivers/platform/x86/panasonic-laptop.c
>=20
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 250  	status =3D
> acpi_evaluate_object(pcc->handle, METHOD_HKEY_SSET,
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 251
> &params, NULL);
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 252
> 9fab10cd drivers/platform/x86/panasonic-laptop.c Axel Lin     2010-07-07 =
 253  	return (status =3D=3D
> AE_OK) ? 0 : -EIO;
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 254  }
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 255
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 256  static inline int
> acpi_pcc_get_sqty(struct acpi_device *device)
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 257  {
> 3e2dab9a drivers/misc/panasonic-laptop.c         Len Brown    2008-10-11 =
 258  	unsigned long long
> s;
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 259  	acpi_status status;
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 260
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 261  	status =3D
> acpi_evaluate_integer(device->handle, METHOD_HKEY_SQTY,
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 262
> NULL, &s);
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 263  	if
> (ACPI_SUCCESS(status))
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 264  		return s;
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 265  	else {
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
@266
> 	ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 267
> "evaluation error HKEY.SQTY\n"));
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 268  		return -
> EINVAL;
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 269  	}
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 270  }
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 271
> e253fb94 drivers/platform/x86/panasonic-laptop.c Jean Delvare 2010-10-21 =
 272  static int
> acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 273  {
> 709ee531 drivers/misc/panasonic-laptop.c         Harald Welte 2008-09-23 =
 274  	acpi_status status;
>=20
> :::::: The code at line 266 was first introduced by commit
> :::::: 709ee531c153038d81b30649b9eeed3c44a4d5cc panasonic-laptop: add Pan=
asonic Let's Note laptop
> extras driver v0.94
>=20
> :::::: TO: Harald Welte <laforge@gnumonks.org>
> :::::: CC: Len Brown <len.brown@intel.com>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
