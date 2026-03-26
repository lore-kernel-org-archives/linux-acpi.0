Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E62C08AB
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539164; cv=none; b=oS64zYvt40BqhRgmlzlzmbGBBUOlfKWk4rYiSxb7XfG8xGw0c41/iwNMPNHOOfD9f8l2Wl/f0uT0VGPK7dlIgj6YNMqEp8ZDz4TE5v2so+0CecoYqfRjrB7Ch2H5bMcUGqmn/NBQikEfd0VoxtqmvL4CKoCDvOkDn54xBlO2h0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539164; c=relaxed/simple;
	bh=aGPammMlS+MY9llgYLwFVqcAGKmSY6vGnlECdDqJR0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2BGAujQrfA3mVa3DjavOYTy8bGJKEdDIRWLfqfEwHnveA8nHH/WRGf31F0HF4WQa5KRdH298YcYfKuOn1Qp0r/aMDiPrA4YYD6xPIZY3uGXIVKrOj0j5Ku9fm742+9QWKPwWLZYVFxcRbWh28Kf3+NOmCir/+97ksd7H+fQtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgOw8ybX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgOw8ybX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3125EC19424
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774539164;
	bh=aGPammMlS+MY9llgYLwFVqcAGKmSY6vGnlECdDqJR0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YgOw8ybX4svTL558RVcv7nULFd0TNlrjG1/YPVNgWcnc8807BAb+n9XKTei0cjDl+
	 fhEkH2H6mVQJ0uvMoHgJme0xgf12cYcjl1n2Vp680B7W5S7pdv7tV1DrL6FuplU7cf
	 SzmlQ89UhH1m5dyVYJLJdT1VCRJmdsz8AmrUinRhBGX6nNDS8vg2FtXj5FKfe0Z5vn
	 COcWcy0LDq3DLRlnbyXS960VVEXsB4hj7RxQ1RYxVlhDmPKr8H5Xbeod7hrSHBCB2p
	 +N8LCHI+DXY5/vRBZ6MsN2SJcarhlDetM7Lnr2G7MTn8OuGdS4MMxtZdQ5gsNJfigO
	 AC3RhBYZBr88Q==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-467e044082dso418643b6e.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:32:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOL+VcUVCC80zenfujHRoVUOqtgwxXdXV3sSzMLZWFQgs38xzwB44MHDO/IGwCbZoFDaUmFPHnQJfk@vger.kernel.org
X-Gm-Message-State: AOJu0YwupI1S8B1to2J9nkKkKpJQ9A3NljIv0mn7aMn7s6XHgwv+tdRd
	C8vlnehWt/G3P/X08uVU6t1K6YbBpKH/oWhGD7wWFrMvPBIWMk5B1sNLb4CeiTuj7vpvzfRQfmC
	sqkewmoo0DtwBAO2liRKjFUNrpFGImLk=
X-Received: by 2002:a05:6808:5246:b0:467:ff72:95af with SMTP id
 5614622812f47-46a5c7951ffmr3662170b6e.50.1774539163193; Thu, 26 Mar 2026
 08:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324231456.701-1-nathaniel.l.desimone@intel.com> <20260324231456.701-2-nathaniel.l.desimone@intel.com>
In-Reply-To: <20260324231456.701-2-nathaniel.l.desimone@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 16:32:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hD2_PVf18yRUA-ZAP_7wbOJmZYqCt-2wJMDYjj9j_tQQ@mail.gmail.com>
X-Gm-Features: AQROBzAoP3Wuya_ueMbPPUvtZeMpTq0k2dwLHaomrTQHRiywSMUAq9x0HIKlcbA
Message-ID: <CAJZ5v0hD2_PVf18yRUA-ZAP_7wbOJmZYqCt-2wJMDYjj9j_tQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
To: Nate DeSimone <nathaniel.l.desimone@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:17=E2=80=AFAM Nate DeSimone
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
> index 271092f2700a..e75dd28d31a9 100644
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
> +                       pr_warn("Failed to create FBPT sysfs attribute.\n=
");
> +       } else if (subtable_type =3D=3D SUBTABLE_S3PT) {
> +               bin_attr_S3PT.private =3D subtable_header;
> +               bin_attr_S3PT.size =3D length;
> +               result =3D sysfs_create_bin_file(fpdt_kobj, &bin_attr_S3P=
T);
> +               if (result)
> +                       pr_warn("Failed to create S3PT sysfs attribute.\n=
");
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
> --

Both patches applied as 7.1 material, thanks!
