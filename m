Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCF1448D5
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235105; cv=none; b=K1KGeh+NBsSM7QyM2IFkjO+6X7VJBNLty+wucBMnjhPXHpVmdIFzhb4yJNrfBnF+fy42vV30GVNd82Bxet3sBDPCtpPVwgKGmirkTjgxPoOKg2tV+Vy+yYhhCcIjjDgw3ZgABT6VvwNeo2Dk8EcR45dRYch59nrcxHqyBSyeK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235105; c=relaxed/simple;
	bh=0fEl/EpcRNdBR795nMdXsYhvv+dRO78sewFk5Vx8a9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuNDYWhQJty/x/R2YEnwOd/Bh6NgKES/GflF2XsBkr+9xm8zY6D7gx96O3cc//Vm3GC/L27Ti0tYwHZdFwAhb1aSHeKX9NmY3V7G1MsAIR0FMbUMCv1pmc5wZElAmld33VfHRifk8oQDDDOAfLBRWTsxdLKc03gXd62PHPqe8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2kF6ZZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2kF6ZZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1800C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773235104;
	bh=0fEl/EpcRNdBR795nMdXsYhvv+dRO78sewFk5Vx8a9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q2kF6ZZoWPZfzX5use+FR0GZGifQ0pwj6QzvAbgYSmFyqFxN0kwFzyvEQ+H+6dAPk
	 AVrAHLUkYWmCOdpBc2Kuy9TgHf/SJK6fcZAXUFWaGJn1CIS2hs/5tGSOamPv3zUBac
	 n3dBNqyX6khzulN8b77hpUnpEUujY7cMYu92KCJwoMavkHsWogP0h8Hf5oA8kO3lTX
	 o7sG4ENe8DYZH9r34WOc5JSBI7LVNMcyzpquWtBOB1WRE3xe11kvrwjxWsXB/jRWFJ
	 X1ijQqECrNXdRxfhgMFF8F7ULGfNLtKh1YFps0gkV1DYtLGmHcPOQCNdgAsa8aJNFQ
	 r2xO+55RKPTeA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466ed3bc95eso1444294b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 06:18:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxClxcmtB2ykue9xOCZTBOY0pNln5bkDd1ojIjA2khz7ArE8ZJM
	2mVOTRAzZbEWnCew9WueJMat7s28/4pESEfKlhMn/tE6GTBEwdau3Jj9xlZAhEUDEzr+oSXY0EX
	Ig39XJBI2D9eG6KPpqgcqOa+DuIp4/y8=
X-Received: by 2002:a05:6808:6902:b0:463:f9ad:a4dd with SMTP id
 5614622812f47-467333b96f8mr1329246b6e.1.1773235103835; Wed, 11 Mar 2026
 06:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
 <20260310043449.1295-1-nathaniel.l.desimone@intel.com> <20260310043449.1295-2-nathaniel.l.desimone@intel.com>
In-Reply-To: <20260310043449.1295-2-nathaniel.l.desimone@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 14:18:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmpQO=N=54z87ZzuOYWx_16S7xPgo4H_-zQ+VPGKRftQ@mail.gmail.com>
X-Gm-Features: AaiRm53ghOJszr8LDmu6gkCznPVjRqnXS1380BRG6RIHDidk-oYB_NQUbPW3X2w
Message-ID: <CAJZ5v0jmpQO=N=54z87ZzuOYWx_16S7xPgo4H_-zQ+VPGKRftQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
To: Nate DeSimone <nathaniel.l.desimone@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:35=E2=80=AFAM Nate DeSimone
<nathaniel.l.desimone@intel.com> wrote:
>
> Add sysfs files at /sys/firmware/acpi/fpdt/FBPT and
> /sys/firmware/acpi/fpdt/S3PT that expose the raw contents of the
> FPDT subtables. Note that /sys/firmware/acpi/tables/FPDT only provides
> the top level table, not the subtables. Adding access to the subtables
> enables a usage model similar to /sys/firmware/dmi/tables/DMI, allowing
> userspace tools to interpret newer record types (e.g. String Event
> Records, Microcontroller Boot Performance Data Records, etc.) defined
> in recent ACPI specifications[1] without requiring kernel changes.
>
> [1]
> https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.html#p=
erformance-event-record-types
>
> Signed-off-by: Nate DeSimone <nathaniel.l.desimone@intel.com>
> ---
>  drivers/acpi/acpi_fpdt.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index 271092f2700a..35fe95acccab 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -141,6 +141,9 @@ static const struct attribute_group boot_attr_group =
=3D {
>         .name =3D "boot",
>  };
>
> +static BIN_ATTR(FBPT, 0400, sysfs_bin_attr_simple_read, NULL, 0);
> +static BIN_ATTR(S3PT, 0400, sysfs_bin_attr_simple_read, NULL, 0);
> +
>  static struct kobject *fpdt_kobj;
>
>  #if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
> @@ -254,9 +257,34 @@ static int fpdt_process_subtable(u64 address, u32 su=
btable_type)
>                         break;
>                 }
>         }
> +
> +       if (subtable_type =3D=3D SUBTABLE_FBPT) {
> +               bin_attr_FBPT.private =3D subtable_header;
> +               bin_attr_FBPT.size =3D length;
> +               result =3D sysfs_create_bin_file(fpdt_kobj, &bin_attr_FBP=
T);
> +               if (result)
> +                       goto err;

Is failing the function the right thing to do here (and below).

A failure to create the sysfs attribute is not critical I suppose, so
would printing a message be sufficient?

> +       } else if (subtable_type =3D=3D SUBTABLE_S3PT) {
> +               bin_attr_S3PT.private =3D subtable_header;
> +               bin_attr_S3PT.size =3D length;
> +               result =3D sysfs_create_bin_file(fpdt_kobj, &bin_attr_S3P=
T);
> +               if (result)
> +                       goto err;
> +       }
> +
>         return 0;
>
>  err:
> +       if (bin_attr_FBPT.private) {
> +               sysfs_remove_bin_file(fpdt_kobj, &bin_attr_FBPT);
> +               bin_attr_FBPT.private =3D NULL;
> +       }
> +
> +       if (bin_attr_S3PT.private) {
> +               sysfs_remove_bin_file(fpdt_kobj, &bin_attr_S3PT);
> +               bin_attr_S3PT.private =3D NULL;
> +       }
> +
>         if (record_boot)
>                 sysfs_remove_group(fpdt_kobj, &boot_attr_group);
>
>
> base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
> --
