Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692796;
	b=OaxE9qbXm7rAgv0OzejwfVrleaBHEk/4AT2z+H2o71sICBhH8kCOMOTitaxZT5GW5+N2
	 OYuWFsOJB2okwjXahXy3qaN+R8uGQkG1ajO6oj0gtIz+eFod3NEsyquBfGfNOY08P0fFk
	 rF1vVGjPgy9SjNKdjNAC62Qovxt/FzXTmOunwIhFBJ0Vituel2YbKvROiVP51ysOxqEGe
	 V9hk64llhpmynmlaFqKpRFBUQkFQvHOtE01CjhYUlv6jq/eqYQ5Aa/XmIzHCkEvb2TYFu
	 5ecgi4T5FbYol8eUKhNZSoaWokC9pPqXiwvFZmoChmPeK6HI4wh+Ou86DHfhFHbiAFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692796;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WoKfb/2yGGVSnXt6CYH/Pbj+IvavfA6u3d8Xn/n1Rd0=;
	b=rceSc/g+Xj8yk0M1A/5LLQ31FRJlSioNxQ501cueQx2JRI9Jz85MdBm4RwKzDfxbSsj5
	 TEBAhzjhXI8Iu+q7NLNzhoUlyvG9nNV4LQsC02ZT9x5Wb7SSEpN5jMDBHkplYgLqNP+J1
	 H2xfyFFseFu7ymRs3AiAVUDmDP+Xg9ObFPTFMkwPCIpbLh/DxJ/2RHako8P6yG6RBlDmh
	 uzMKOaef9JPpLy0rR8ZhYge+/bKhj53LPOA2GuQX4b6LH72aj5NiFxomv6xcIvgv9t/Rz
	 Y1TbV62VzwZWrkkpAGg1NUc+h+pFy5e+Rv6/fjX6jPn5B1W4A3/nq2WrwCN/qP+F00Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGT0N5Ne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD486606A31A
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGT0N5Ne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C791F031E2
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792692795;
	bh=WoKfb/2yGGVSnXt6CYH/Pbj+IvavfA6u3d8Xn/n1Rd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HGT0N5NekN0KEUSsObqhZrI0IV6Jy0/nsLWp5XhIGufZMljEMcfM81bQMi+uQ9gwf
	 CrYb4CFqawsRdcoxpa3pfccQ2SVip8zroqYY0HM//eETThHjGtBSjB0V19vcWgfaLH
	 guThOcgte4ydi4eTG52G7kKUEtPHZh4RKQ00zlmsx+GZdpg7WTnRF9mlomNGZ/Sn7N
	 AgkyZk+A2UWvdexa8X7raknOxt2rd5Dfrj8Fqao+EKo3dvFO6ch+d+CzFKOtG9U3bs
	 v5hcBHRSG1hjA8IPySHccloEpBljpj/+Zm3Vl0pD+lMOvppU3lFDHJUGqugn4KY9ad
	 U8tueRB35WcvQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso8816e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 11:13:15 -0700 (PDT)
X-Gm-Message-State: AFq9FYJ5Br9iR57GXvGjFXW/CXli9g4TFHWowwqLwG4P+Ad2SqoS9mhk
	+HBNlAdNayS8UDcO1ypdKKx+tI4yyYk1xRbbeN8XYDAcc1ylknCeC9HEdHAQtGIh1nJLDNKDwbY
	YryGYpZ29htGnFuQoyZvcntatjMYOt8g=
X-Received: by 2002:a05:6512:238f:b0:5bc:b23c:f7dc with SMTP id
 2adb3069b0e04-5bfa1c6ad0fmr2527167e87.9.1792692793746; Thu, 22 Oct 2026
 11:13:13 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019145421.47181-1-leonard@lausen.nl> <20261019145421.47181-2-leonard@lausen.nl>
In-Reply-To: <20261019145421.47181-2-leonard@lausen.nl>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 20:10:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihGqbpJQiic7DkPw19LG-XXL4BmDht-0Mdx8PFNMh+Kg@mail.gmail.com>
X-Gm-Features: AclHuK8OnYNaemA-MReRJfiarOYd7azLSGRGGQtr9eN1fRbWuuXKTTqItN58h4A
Message-ID: <CAJZ5v0ihGqbpJQiic7DkPw19LG-XXL4BmDht-0Mdx8PFNMh+Kg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPICA: Initialize ParserState.AmlEnd in AcpiInstallMethod
To: Leonard Lausen <leonard@lausen.nl>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, acpica-devel@lists.linux.dev, 
	Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>, Ivan Hu <ivan.hu@canonical.com>, 
	Joshua Grisham <josh@joshuagrisham.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 4:54=E2=80=AFPM Leonard Lausen <leonard@lausen.nl> =
wrote:
>
> From: Ivan Hu <ivan.hu@canonical.com>
>
> In AcpiInstallMethod(), the local ParserState is stack-allocated and
> only ParserState.Aml was initialized. Parser helpers called by this path
> read ParserState.AmlEnd for bounds checking: AcpiPsPeekOpcode() reads it
> before validating the first AML opcode, and AcpiPsGetNextPackageEnd()
> reads it indirectly via AcpiPsGetNextPackageLength(). The subsequent
> package-limit check also compares against ParserState.AmlEnd. Because
> AmlEnd was never set, these checks operated on an uninitialized value,
> which Coverity flagged as an uninitialized read (CID 1684785) and which
> could lead to incorrect parser bounds decisions.
>
> Coverity report:
>
> *** CID 1684785:         Memory - illegal accesses  (UNINIT)
> /src/acpica/source/components/namespace/nsxfname.c: 712             in Ac=
piInstallMethod()
>         ParserState.Aml +=3D AcpiPsGetOpcodeSize (Opcode);
> >>>     CID 1684785:         Memory - illegal accesses  (UNINIT)
> >>>     Using uninitialized value "ParserState.AmlEnd" when calling
>         "AcpiPsGetNextPackageEnd".
>         ParserState.PkgEnd =3D AcpiPsGetNextPackageEnd (&ParserState);
>
> Initialize ParserState.AmlEnd to the end of the table
> (Buffer + Table->Length) so the parser bounds checks operate on a valid
> limit.
>
> Link: https://github.com/open-acpica/acpica/commit/19429ef91ebfb2144c9180=
38dce13e297b4ef051
> Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> ---
>  drivers/acpi/acpica/nsxfname.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfnam=
e.c
> index b6534187cd43..fcd94947fedb 100644
> --- a/drivers/acpi/acpica/nsxfname.c
> +++ b/drivers/acpi/acpica/nsxfname.c
> @@ -503,6 +503,7 @@ acpi_status acpi_install_method(u8 *buffer)
>         /* First AML opcode in the table must be a control method */
>
>         parser_state.aml =3D buffer + sizeof(struct acpi_table_header);
> +       parser_state.aml_end =3D buffer + table->length;
>         opcode =3D acpi_ps_peek_opcode(&parser_state);
>         if (opcode !=3D AML_METHOD_OP) {
>                 return (AE_BAD_PARAMETER);
> --

Applied as 7.4-rc material, thanks!
