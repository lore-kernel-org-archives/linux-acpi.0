From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 1/5] EFI: Provide registration for efi_init.. etc efi
 public  function
Date: Thu, 9 Feb 2012 11:01:28 -0500
Message-ID: <20120209160128.GA32058@phenom.dumpdata.com>
References: <1328758250-23989-1-git-send-email-liang.tang@oracle.com>
 <1328758328-24156-1-git-send-email-liang.tang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:60425 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab2BIQEa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2012 11:04:30 -0500
Content-Disposition: inline
In-Reply-To: <1328758328-24156-1-git-send-email-liang.tang@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Liang <liang.tang@oracle.com>
Cc: mjg59@srcf.ucam.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Feb 09, 2012 at 11:32:08AM +0800, Tang Liang wrote:
> The efi public functions are changed to function pointer in efi_init_=
funcs
> struct.
> They act as efi generic functions as default.
> As a benefit from this change, we can register xen efi init func.
>=20
> Signed-off-by: Tang Liang <liang.tang@oracle.com>
> ---
>  arch/x86/platform/efi/efi.c |   65 +++++++++++++++++++++++++++++++++=
++++++---
>  include/linux/efi.h         |   12 +++++++-
>  2 files changed, 71 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.=
c
> index 4cf9bd0..d567e29 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -50,6 +50,23 @@
>  #define PFX 		"EFI: "
> =20
>  int efi_enabled;
> +
> +static void efi_init_generic(void);
> +
> +static void efi_enter_virtual_mode_generic(void);
> +static u32 efi_mem_type_generic(unsigned long phys_addr);
> +static u64 efi_mem_attributes_generic(unsigned long phys_addr);
> +
> +struct efi_init_funcs efi_generic_funcs =3D {
> +	.__efi_init		     =3D efi_init_generic,
> +	.__efi_reserve_boot_services =3D efi_reserve_boot_services_generic,

Hmm, did you compile test this? I get:

/home/konrad/ssd/linux/arch/x86/platform/efi/efi.c:62: error: =E2=80=98=
efi_reserve_boot_services_generic=E2=80=99 undeclared here (not in a fu=
nction)

The patch below fixes it:


=46rom 6ecdc001b99f06f73fe55ea24663c9a3921c285e Mon Sep 17 00:00:00 200=
1
=46rom: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Thu, 9 Feb 2012 10:59:17 -0500
Subject: [PATCH] efi: Fix compiler error introduced by moving of the co=
de
 decleration.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The compiler error is :

arch/x86/platform/efi/efi.c:62: error: =E2=80=98efi_reserve_boot_servic=
es_generic=E2=80=99 undeclared here (not in a function

And declearing it before the use fixes the issue.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/platform/efi/efi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index d7b19ee..c21b325 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -56,6 +56,7 @@ static void efi_init_generic(void);
 static void efi_enter_virtual_mode_generic(void);
 static u32 efi_mem_type_generic(unsigned long phys_addr);
 static u64 efi_mem_attributes_generic(unsigned long phys_addr);
+static void efi_reserve_boot_services_generic(void);
=20
 struct efi_init_funcs efi_generic_funcs =3D {
 	.__efi_init		     =3D efi_init_generic,
--=20
1.7.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
