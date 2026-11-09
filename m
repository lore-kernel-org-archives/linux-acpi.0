Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252012;
	b=JSaHe8/CJBdA++yVxw1K1TIwbAqobbvgbnkRMNkgq+YjgNoNmc7GebdnV13kyLVCHx9q
	 +IHxJY011tDrrdVuyQ/JMLe2+JNMEvnQUnpgf8L4Z5NJJ16S/LAZvWVREQkDOJ/g0ojVn
	 jWjHsGN4b3KWZZ8dUWb+6LUit73hOCoHRRFIyEyvQ83FdDBG7YJr2rdPkcD/A8hUWx60J
	 1sqWr2JrxdPvCEycZNGvL11c8ArqHgyJqLfz829ff8/uDn6Oc9wRWGVJ0VKLO/kwRf9Tt
	 zKkJaCmlExZIN+d3MOx3KLgMvrGrtTZnzOQTelRVxtXJ93EU4tHwBjbwWsduiFW3S2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252012;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xu2nW/Iy/kEVEZarXQTAQA9kyZ4pEzHrOyNF0r/PGSo=;
	b=dNVV5Rex5sc+xf90OzEVUdIW5UQeRppc4EGJ1hORtm5RAB8BtLrcfrBRM8wOQt4kpOFs
	 2YLS05g3onlvZnRIcklHchcjzoDE6IvPZtEKqr8GWdxBKrluIFR9OXMHZ/pUrPRevpex6
	 92CoJVf/oeVRz1O/rUtjj0zE3A/qZj5PpMcuExNveBSIBFZ6QzpDm3Mv58GklTkLp3v5R
	 q+LHg2KZ1E/sonAcv0/Yw6HeG3VVqFejPVkeZ2bvnhJbMSaKVSql8zm5uD7V+6MEZyGxg
	 RyD4EB9Y4y93jPAJuzumHPSjWAZ1VU1TDfh5viKZTMqSkPWTS8eqEM0cHQy7bleR3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYuFsW01;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE98606A32A
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYuFsW01
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA21F008A2
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252012;
	bh=xu2nW/Iy/kEVEZarXQTAQA9kyZ4pEzHrOyNF0r/PGSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RYuFsW01IhMwyc1EYwEjerSaF5Soc/2GLj/kQNcK3U4a9f06HFtpXjD+sslLIH6W1
	 YzFdmcSCXeCu8sO/KT1xWvKIagOeB8TLu+H1lq5wJYvLVT3duWwvkoP4T7+QMQuxbf
	 63XyB9EM9c+4kBr3fN89Zv2Z1Gr3stMxP4AKD+HuxN4Sxi9rKJ3lX+gRo7YhfoMLd3
	 9O2knycqwE+3U/nOkPR1lCZhkaLdfSITLS7RCAEQAmz0hhPUKZKj2jq77w0OtDhV6d
	 yrJYec/bPR2TppUeRRVX5Rz+aP4Dg7rrCnJCqhs6Mti6ITc8JBsDyQuaw2F+qp9yKn
	 SycKOW2sb9o0Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so10272691fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 11:20:12 -0800 (PST)
X-Gm-Message-State: APuU4Z+UDQU+5VSygFD2Ptk8EVxpZuyJ+BRiUadmQqEK7gMrKVDEq9o7
	RYpJjm0RXoa2uoVBs5dzOjPMIwfcordGigqwV7Yfg0IcEe6EesMScz1KNPBcC2xn0NOEHBJ3tdT
	9Y9dlQCVKYW0MTMT68HAQ6lnmPJnQtnA=
X-Received: by 2002:a05:651c:1b14:b0:3a3:5a01:a794 with SMTP id
 38308e7fff4ca-3ae0955c9f7mr555661fa.1.1794252010431; Mon, 09 Nov 2026
 11:20:10 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023060426.3821716-1-yong.hu@windriver.com>
In-Reply-To: <20261023060426.3821716-1-yong.hu@windriver.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 20:19:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jNziZrnjJ8Yjq0X97oaJf-OR9=Xwe2J4b4jvcSAZEpoA@mail.gmail.com>
X-Gm-Features: AclHuK_c-aMWohLE9hE7o9IOTB9jsL5x5x6mbotib79oa8bxGW9n3HIhL8qS0bM
Message-ID: <CAJZ5v0jNziZrnjJ8Yjq0X97oaJf-OR9=Xwe2J4b4jvcSAZEpoA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Initialize parser_state.aml_end in acpi_install_method()
To: Yong Hu <yong.hu@windriver.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:06=E2=80=AFAM Yong Hu <yong.hu@windriver.com> wro=
te:
>
> In acpi_install_method(), the local parser_state is stack-allocated and
> only parser_state.aml was initialized. Parser helpers called by this path
> read parser_state.aml_end for bounds checking: acpi_ps_peek_opcode() read=
s
> it before validating the first AML opcode, and acpi_ps_get_next_package_e=
nd()
> reads it indirectly via acpi_ps_get_next_package_length(). The subsequent
> package-limit check also compares against parser_state.aml_end. Because
> aml_end was never set, these checks operated on an uninitialized value,
> which could lead to incorrect parser bounds decisions.
>
> Initialize parser_state.aml_end to the end of the table (buffer +
> table->length) so the parser bounds checks operate on a valid limit.
>
> Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
> Link: https://github.com/acpica/acpica/commit/19429ef91ebfb2144c918038dce=
13e297b4ef051
> Signed-off-by: Yong Hu <yong.hu@windriver.com>
> ---
>  drivers/acpi/acpica/nsxfname.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfnam=
e.c
> index fabae9b08e31..b1234567890a 100644
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

This should be fixed by commit ec696f34774d ACPICA: Initialize
parser_state.aml_end in acpi_install_method().

Thanks!
