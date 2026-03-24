Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413302D94BA
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394499; cv=none; b=U4oZhao5uvG7MxjDC/UndE2eR5aGgw8x4RGcNwGHFoSZDG24pn0ut3y2aLFbr37wruz0F1jwen3L9cZJYRJxTNpqewUBGMUN6yHvHwCHrC+nMy2N0qcXHci1gRszQ4lmf5DZB5edJZvJ5uGVZZAVhfY301dVpdVnL/Am7IpW9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394499; c=relaxed/simple;
	bh=2EEHKQtZt/OAwYIRsBCvwm+UoqpWu3DIuK2UzR9r9uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhsxKo7J9TVniCUlrCJwwyj+Qdkr7w+VHvN5qgZsT6wkn+IWL6uMa4m3GDrupJQBIeCKtIR+IMk/DuLL8/t6j9anc6C2MUcN+Hl/A9kcDu3EFdvNVaY0AJa8W2Vkr970jNczAlL1rB/uwd+a+4tCZU9E6p5ub0m2wz3IF93r8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb95FQqW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb95FQqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774394498; x=1805930498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2EEHKQtZt/OAwYIRsBCvwm+UoqpWu3DIuK2UzR9r9uk=;
  b=hb95FQqWQW+bEAO2fJCvQ06Z6UFpuZMQ3NQkXpD1hcGo7+fdKic8djPn
   HW710sxpisTpWaS4NhXdc+RltIf4fmSmbl7i04G4QbJp7/NQPsSC5zTTW
   5RCZCtpuoC9iSW+fufg4F4vzF9ewzOuRxpwh5pKmID80LzAv1Wg7sxTJ6
   X/yaqY927lm+1UA40Clrcrq3rdgZ/NsLnMqYpO991Q1bdEUrsMjVoPSkG
   r2tv29GLl7zgYfv69JFB9LVfHRSUKTtuiZDTkI7Cr2HQ4ER7k4gfTaLqC
   sbLT19y50BYYmW1dfi7aKR65ppTPfXR5WhLFCv/bdGjRZ6XFPoOVM5wLm
   g==;
X-CSE-ConnectionGUID: D6tiZdK2TS68/mionn8n1w==
X-CSE-MsgGUID: MAC2kE8WQaaw1vPzvOP4UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98047187"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="98047187"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:21:38 -0700
X-CSE-ConnectionGUID: vRgZnQDEQ0KYdhoWxz2r7g==
X-CSE-MsgGUID: xAqN5YjLTKKKzC5iVeYVPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223560851"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:21:38 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	tony.luck@intel.com
Subject: Re: [PATCH v2 1/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Tue, 24 Mar 2026 16:20:44 -0700
Message-ID: <20260324232045.763-1-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <CAJZ5v0jmpQO=N=54z87ZzuOYWx_16S7xPgo4H_-zQ+VPGKRftQ@mail.gmail.com>
References: <CAJZ5v0jmpQO=N=54z87ZzuOYWx_16S7xPgo4H_-zQ+VPGKRftQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 14:18:13 +0100 Rafael J. Wysocki
<rafael@kernel.org> wrote:
> On Tue, Mar 10, 2026 at 5:35=E2=80=AFAM Nate DeSimone
> <nathaniel.l.desimone@intel.com> wrote:
> >
> > +static BIN_ATTR(FBPT, 0400, sysfs_bin_attr_simple_read, NULL, 0);
> > +static BIN_ATTR(S3PT, 0400, sysfs_bin_attr_simple_read, NULL, 0);
> > +
> >  static struct kobject *fpdt_kobj;
> >
> >  #if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
> > @@ -254,9 +257,34 @@ static int fpdt_process_subtable(u64 address, u32 su=
> btable_type)
> >                         break;
> >                 }
> >         }
> > +
> > +       if (subtable_type =3D=3D SUBTABLE_FBPT) {
> > +               bin_attr_FBPT.private =3D subtable_header;
> > +               bin_attr_FBPT.size =3D length;
> > +               result =3D sysfs_create_bin_file(fpdt_kobj, &bin_attr_FBP=
> T);
> > +               if (result)
> > +                       goto err;
>
> Is failing the function the right thing to do here (and below).
>
> A failure to create the sysfs attribute is not critical I suppose, so
> would printing a message be sufficient?

Thank you for the feedback!

I have sent a new V3 patch series with the sysfs_create_bin_file() failure
handling changed from a hard error to a non-fatal warning.

> > +       } else if (subtable_type =3D=3D SUBTABLE_S3PT) {
> > +               bin_attr_S3PT.private =3D subtable_header;
> > +               bin_attr_S3PT.size =3D length;
> > +               result =3D sysfs_create_bin_file(fpdt_kobj, &bin_attr_S3P=
> T);
> > +               if (result)
> > +                       goto err;
> > +       }
> > +
> >         return 0;
> >
> >  err:
> > +       if (bin_attr_FBPT.private) {
> > +               sysfs_remove_bin_file(fpdt_kobj, &bin_attr_FBPT);
> > +               bin_attr_FBPT.private =3D NULL;
> > +       }
> > +
> > +       if (bin_attr_S3PT.private) {
> > +               sysfs_remove_bin_file(fpdt_kobj, &bin_attr_S3PT);
> > +               bin_attr_S3PT.private =3D NULL;
> > +       }
> > +
> >         if (record_boot)
> >                 sysfs_remove_group(fpdt_kobj, &boot_attr_group);
> >
> >
> > base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
> > --

Best Regards,
-Nate
