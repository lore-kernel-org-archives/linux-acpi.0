Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180397;
	b=QdfCkLGWtiB/pRX6hXb73Z3eQm5koz/QOjOLc1U9HhiqncK4ZUC1f6lr6Cj4Sbq0oZwK
	 ShznU5xRmnBWvKqZLg3bwiDGUFqbkE7Kfm176Mn59l6yYEs+Bcejt2i5mlznuBFhwhJWF
	 A7voHkIzooVC4Djfzh6cZncWOZyd05PzvtJcexqenijp0yIVaSRyotKqVx1nNZcz5+DAq
	 YHin01sRXYAa94S8j9Mm5OyvCIsgkWIsjyZyu0qQk+IBDovTgmpUwqpaUrMiQNfL4cUYH
	 EZ5rqZz3ifVd84qS3EseQhsR14mRfy7EkYKk2RmWkKLUOn86ZO9Z4dPJgl80kkrcbMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180397;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WWyp6r5wDDG04V+vWcV+yUaXF/hhm1BKes3FoIGNab0=;
	b=2+dwyzbC6W3cPMOeXiNumnhiw+kUw8anCigCY0EWODbwBG8v4AGpY0LY0qbOyLj6nL2o
	 JsyX+fv4MHJhLVqoUZjypnr0+zaEXeYL7Iq0i6CQ14s/U1PxCXBpP7q2tfDOvHIJsfv4q
	 Pt2w4TZ+ivIwrp31G7IrAuLqU+jprBtojMlREGH9KxhGi124BmC+g+pQFf9AhjUu3Z9E3
	 HqGU2jYtlxVpm4HV9PM9V5jI7vj/pWF962+QjriFIq/I0hMvaGjR9oxbK3BnGWyR4jmy9
	 aZUw79GcA4PyMNARMSJdfF36ztQBXe7+xS0s/2NqPXK8f9QEjoqNxwCUJA1jdVCt0QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TneN1nC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9C606A326
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TneN1nC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50321F000C4
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180396;
	bh=WWyp6r5wDDG04V+vWcV+yUaXF/hhm1BKes3FoIGNab0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TneN1nC9TyAgi8ImFKUiCv3HSslXgGH4HSRVQ8BTkzTlscG1x6Rmd8jy58GfleqZL
	 95i+6iG7eq64nuh1z0i9ybuTG+VsmqmjQcfr7eE+rtFDN+Mv5F+6xf4uDxKF3lyaDT
	 AT6M8FTW5i8Eu3DCDaCaHgmgFuPSi9gSi1knzKi3Hnga/34vhIESOG5s+BQkr3yp/+
	 xpJTrMZCLwR/mQvHBtWIBXT70uzG40o+DYQ4ElFWmSNrr6PDQla7uY7wLRIhMzspj1
	 m9AIPRHrmi1/Mjhwt9uqXrti3HpGMw+v0zcQTDV7ULU2CZ+f2LtChTL/Dp9mjThO7f
	 COsZ5klA4lpHQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c126f80426so704102e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 05:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEgRY6EEpWiVAZKbNtrx4kEM0HcaEgMcM29Xh3GOQwx8ToGYLf5PBy8NQ6gwAUPAqQZv64bAO+B+5dk@vger.kernel.org
X-Gm-Message-State: APuU4Z+ytYKJknnu0RNLyWS7CaOHtPYqbSD8eaMQcx3Aut+9K6krrQKo
	GsxguRkXwAhQqCvcTQMKhOMlYt5KVtfhFv6xzAW3+sR6gxUwaNhGTEZeaSyUhlkfMayO5/+VYjj
	1J0MZ3rxn5f6zxWtZ+bv7DBKquzEdO00=
X-Received: by 2002:ac2:4c4b:0:b0:5c0:a54:5d4c with SMTP id
 2adb3069b0e04-5c1bc8635bfmr941652e87.36.1795180395199; Fri, 20 Nov 2026
 05:13:15 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113131243.28214-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261113131243.28214-1-atharvatiwarilinuxdev@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:13:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jBBt0a3eQO_qYX=HNGUqDJDSnL8UAhjfZ0GXMvNZL4gQ@mail.gmail.com>
X-Gm-Features: Aa3M54qwtXTjQVOXHBd3RZ7NnTdE0YnhQ0bCOANv8z_VabKAf08TJ_3hPCSSvPk
Message-ID: <CAJZ5v0jBBt0a3eQO_qYX=HNGUqDJDSnL8UAhjfZ0GXMvNZL4gQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: Use Apple-specific methods for P/C-states
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:12=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> Use APSS and ACST instead of _PSS and _CST when available on Intel Macs
> as they include better P/C-States.
> These methods are used in macOS (X86PlatformPlugin.kext),
> and when not found we fallback to generic _PSS and _CST methods.
>
> Changes in v2:
> - Improved description of the patch
> - Replaced goto's and if statement's with new functions
> - Added support to differentiate _PSS and APSS in debug info/error info
> - Added support to differentiate _CST and ACST in debug info/error info
> - Used Package instead of variable for ACST description
>
> Link to v1:
> https://lore.kernel.org/all/20261015204450.1270-1-atharvatiwarilinuxdev@g=
mail.com/
>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/acpi/acpi_processor.c    | 80 +++++++++++++++++++++-----------
>  drivers/acpi/processor_perflib.c | 43 +++++++++++++----
>  2 files changed, 86 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 5fbab5417..bbe471b3c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <linux/platform_device.h>
>
>  #include <acpi/processor.h>
> @@ -815,6 +816,22 @@ bool acpi_processor_claim_cst_control(void)
>  }
>  EXPORT_SYMBOL_NS_GPL(acpi_processor_claim_cst_control, "ACPI_PROCESSOR_I=
DLE");
>
> +static int acpi_processor_apple_acst(acpi_handle handle, struct acpi_buf=
fer *buffer)

bool?

> +{
> +       acpi_status status;
> +
> +       if (!x86_apple_machine)
> +               return 0;
> +
> +       status =3D acpi_evaluate_object(handle, "ACST", NULL, buffer);
> +       if (ACPI_FAILURE(status)) {
> +               buffer->length =3D ACPI_ALLOCATE_BUFFER;
> +               buffer->pointer =3D NULL;
> +               return 0;
> +       }
> +
> +       return 1;
> +}
>  /**
>   * acpi_processor_evaluate_cst - Evaluate the processor _CST control met=
hod.
>   * @handle: ACPI handle of the processor object containing the _CST.
> @@ -837,28 +854,35 @@ int acpi_processor_evaluate_cst(acpi_handle handle,=
 u32 cpu,
>         acpi_status status;
>         u64 count;
>         int last_index =3D 0;
> -       int i, ret =3D 0;
> +       int i, ret =3D 0, base =3D 0;
> +       bool using_acst =3D false;

What about

    const char *method =3D "_CST";

>
> -       status =3D acpi_evaluate_object(handle, "_CST", NULL, &buffer);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_handle_debug(handle, "No _CST\n");
> -               return -ENODEV;
> +       using_acst =3D acpi_processor_apple_acst(handle, &buffer);
> +       if (using_acst)
> +               base =3D 1; /* ACST is a 4 field package we need to skip =
the first field */
> +
> +       if (!using_acst) {
> +               status =3D acpi_evaluate_object(handle, "_CST", NULL, &bu=
ffer);
> +               if (ACPI_FAILURE(status)) {
> +                       acpi_handle_debug(handle, "No _CST\n");
> +                       return -ENODEV;
> +               }
>         }

if (acpi_processor_apple_acst(handle, &buffer)) {
    base =3D 1; /* ACST is a 4 field package we need to skip the first fiel=
d */
    method =3D "ACST";
} else {
    status =3D acpi_evaluate_object(handle, "_CST", NULL, &buffer);
        if (ACPI_FAILURE(status)) {
            acpi_handle_debug(handle, "No _CST\n");
            return -ENODEV;
       }
}

and using "method" wherever the ternary operator would be used below?

>
>         cst =3D buffer.pointer;
>
> -       /* There must be at least 2 elements. */
> -       if (!cst || cst->type !=3D ACPI_TYPE_PACKAGE || cst->package.coun=
t < 2) {
> -               acpi_handle_warn(handle, "Invalid _CST output\n");
> +       /* There must be at least 2 elements for _CST and at least 3 elem=
ents for ACST. */
> +       if (!cst || cst->type !=3D ACPI_TYPE_PACKAGE || cst->package.coun=
t < base + 2) {
> +               acpi_handle_warn(handle, "Invalid %s output\n", using_acs=
t ? "ACST" : "_CST");
>                 ret =3D -EFAULT;
>                 goto end;
>         }
>
> -       count =3D cst->package.elements[0].integer.value;
> +       count =3D cst->package.elements[base].integer.value;
>
>         /* Validate the number of C-states. */
> -       if (count < 1 || count !=3D cst->package.count - 1) {
> -               acpi_handle_warn(handle, "Inconsistent _CST data\n");
> +       if (count < 1 || count !=3D cst->package.count - 1 - base) {
> +               acpi_handle_warn(handle, "Inconsistent %s data\n", using_=
acst ? "ACST" : "_CST");
>                 ret =3D -EFAULT;
>                 goto end;
>         }
> @@ -882,24 +906,24 @@ int acpi_processor_evaluate_cst(acpi_handle handle,=
 u32 cpu,
>
>                 memset(&cx, 0, sizeof(cx));
>
> -               element =3D &cst->package.elements[i];
> +               element =3D &cst->package.elements[base + i];
>                 if (element->type !=3D ACPI_TYPE_PACKAGE) {
> -                       acpi_handle_info(handle, "_CST C%d type(%x) is no=
t package, skip...\n",
> -                                        i, element->type);
> +                       acpi_handle_info(handle, "%s C%d type(%x) is not =
package, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 element->type);
>                         continue;
>                 }
>
>                 if (element->package.count !=3D 4) {
> -                       acpi_handle_info(handle, "_CST C%d package count(=
%d) is not 4, skip...\n",
> -                                        i, element->package.count);
> +                       acpi_handle_info(handle, "%s C%d package count(%d=
) is not 4, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 element->package.count);
>                         continue;
>                 }
>
>                 obj =3D &element->package.elements[0];
>
>                 if (obj->type !=3D ACPI_TYPE_BUFFER) {
> -                       acpi_handle_info(handle, "_CST C%d package elemen=
t[0] type(%x) is not buffer, skip...\n",
> -                                        i, obj->type);
> +                       acpi_handle_info(handle, "%s C%d package element[=
0] type(%x) is not buffer, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 obj->type);
>                         continue;
>                 }
>
> @@ -907,8 +931,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u=
32 cpu,
>
>                 obj =3D &element->package.elements[1];
>                 if (obj->type !=3D ACPI_TYPE_INTEGER) {
> -                       acpi_handle_info(handle, "_CST C[%d] package elem=
ent[1] type(%x) is not integer, skip...\n",
> -                                        i, obj->type);
> +                       acpi_handle_info(handle, "%s C[%d] package elemen=
t[1] type(%x) is not integer, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 obj->type);
>                         continue;
>                 }
>
> @@ -947,8 +971,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u=
32 cpu,
>                                 cx.entry_method =3D ACPI_CSTATE_HALT;
>                                 snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI=
 HLT");
>                         } else {
> -                               acpi_handle_info(handle, "_CST C%d declar=
es FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
> -                                                i);
> +                               acpi_handle_info(handle, "%s C%d declares=
 FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
> +                                                using_acst ? "ACST" : "_=
CST", i);
>                                 continue;
>                         }
>                 } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO)=
 {
> @@ -956,8 +980,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u=
32 cpu,
>                         snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT =
0x%x",
>                                  cx.address);
>                 } else {
> -                       acpi_handle_info(handle, "_CST C%d space_id(%x) n=
either FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
> -                                        i, reg->space_id);
> +                       acpi_handle_info(handle, "%s C%d space_id(%x) nei=
ther FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 reg->space_id);
>                         continue;
>                 }
>
> @@ -966,8 +990,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u=
32 cpu,
>
>                 obj =3D &element->package.elements[2];
>                 if (obj->type !=3D ACPI_TYPE_INTEGER) {
> -                       acpi_handle_info(handle, "_CST C%d package elemen=
t[2] type(%x) not integer, skip...\n",
> -                                        i, obj->type);
> +                       acpi_handle_info(handle, "%s C%d package element[=
2] type(%x) not integer, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 obj->type);
>                         continue;
>                 }
>
> @@ -975,8 +999,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u=
32 cpu,
>
>                 obj =3D &element->package.elements[3];
>                 if (obj->type !=3D ACPI_TYPE_INTEGER) {
> -                       acpi_handle_info(handle, "_CST C%d package elemen=
t[3] type(%x) not integer, skip...\n",
> -                                        i, obj->type);
> +                       acpi_handle_info(handle, "%s C%d package element[=
3] type(%x) not integer, skip...\n",
> +                                        using_acst ? "ACST" : "_CST", i,=
 obj->type);
>                         continue;
>                 }
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
> index 9e25d6124..9b9533649 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -17,6 +17,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <acpi/processor.h>
>  #ifdef CONFIG_X86
>  #include <asm/cpufeature.h>
> @@ -313,6 +314,23 @@ static void amd_fixup_frequency(struct acpi_processo=
r_px *px, int i)
>         }
>  }
>
> +static int acpi_evaluate_apple_apss(acpi_handle handle, struct acpi_buff=
er *buffer)

bool?

> +{
> +       acpi_status status;
> +
> +       if (!x86_apple_machine)
> +               return 0;
> +
> +       status =3D acpi_evaluate_object(handle, "APSS", NULL, buffer);
> +       if (ACPI_FAILURE(status)) {
> +               buffer->length =3D ACPI_ALLOCATE_BUFFER;
> +               buffer->pointer =3D NULL;
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
>  static int acpi_processor_get_performance_states(struct acpi_processor *=
pr)
>  {
>         int result =3D 0;
> @@ -323,16 +341,21 @@ static int acpi_processor_get_performance_states(st=
ruct acpi_processor *pr)
>         union acpi_object *pss =3D NULL;
>         int i;
>         int last_invalid =3D -1;
> +       bool using_apss;

And here you can do it like in acpi_processor_evaluate_cst() above.

> -       status =3D acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer=
);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
> -               return -ENODEV;
> +       using_apss =3D acpi_evaluate_apple_apss(pr->handle, &buffer);
> +
> +       if (!using_apss) {
> +               status =3D acpi_evaluate_object(pr->handle, "_PSS", NULL,=
 &buffer);
> +               if (ACPI_FAILURE(status)) {
> +                       acpi_evaluation_failure_warn(pr->handle, "_PSS", =
status);
> +                       return -ENODEV;
> +               }
>         }
>
>         pss =3D buffer.pointer;
>         if (!pss || pss->type !=3D ACPI_TYPE_PACKAGE) {
> -               pr_err("Invalid _PSS data\n");
> +               pr_err("Invalid %s data\n", using_apss ? "APSS" : "_PSS")=
;
>                 result =3D -EFAULT;
>                 goto end;
>         }
> @@ -360,7 +383,8 @@ static int acpi_processor_get_performance_states(stru=
ct acpi_processor *pr)
>                 status =3D acpi_extract_package(&(pss->package.elements[i=
]),
>                                               &format, &state);
>                 if (ACPI_FAILURE(status)) {
> -                       acpi_handle_warn(pr->handle, "Invalid _PSS data: =
%s\n",
> +                       acpi_handle_warn(pr->handle, "Invalid %s data: %s=
\n",
> +                                        using_apss ? "APSS" : "_PSS",
>                                          acpi_format_exception(status));
>                         result =3D -EFAULT;
>                         kfree(pr->performance->states);
> @@ -384,8 +408,8 @@ static int acpi_processor_get_performance_states(stru=
ct acpi_processor *pr)
>                 if (!px->core_frequency ||
>                     (u32)(px->core_frequency * 1000) !=3D px->core_freque=
ncy * 1000) {
>                         pr_err(FW_BUG
> -                              "Invalid BIOS _PSS frequency found for pro=
cessor %d: 0x%llx MHz\n",
> -                              pr->id, px->core_frequency);
> +                              "Invalid BIOS %s frequency found for proce=
ssor %d: 0x%llx MHz\n",
> +                              using_apss ? "APSS" : "_PSS", pr->id, px->=
core_frequency);
>                         if (last_invalid =3D=3D -1)
>                                 last_invalid =3D i;
>                 } else {
> @@ -402,7 +426,8 @@ static int acpi_processor_get_performance_states(stru=
ct acpi_processor *pr)
>
>         if (last_invalid =3D=3D 0) {
>                 pr_err(FW_BUG
> -                          "No valid BIOS _PSS frequency found for proces=
sor %d\n", pr->id);
> +                          "No valid BIOS %s frequency found for processo=
r %d\n",
> +                          using_apss ? "APSS" : "_PSS",  pr->id);
>                 result =3D -EFAULT;
>                 kfree(pr->performance->states);
>                 pr->performance->states =3D NULL;
> --
> 2.55.0
>
