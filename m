Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0B37F01A
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205852; cv=pass; b=E1D9PHOc/Ryk02d+2XiHyL9ss7kerxinXNYtqZWbWn5bnsk8Tl3rBv7M8VltAJyF0Uj/c6/ePjJlVHHqCYKva6mqAuAGxHtyYhZLZaEWtsZhJ5sAX++cMcHSj1ZGQBzhFQ3UEFl8Zk8zeS1SLZFBFTQqP4FWCu2a2xeGg1UA2kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205852; c=relaxed/simple;
	bh=CEmZYpSU7qe2qzYY0/pmXkQR0GlChQnTkZTIVGVQEfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzBdlfn1uYJFwieIwm2tMSfxDQj5TUAXmqzu5jw1LnNEUMnZxl74lGIJVX6lZqYTdm65lI54XV+aOMkmMvlWEcGrAU0a0GmOvAWBrsp9QgtIa3wOcCiKFywPcG/jYPgR/B4Ozov4dEdUvWOeppPfAcm84LJDRlG2lOqH/q9SkX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=jaHU72mV; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="jaHU72mV"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46ceca1e0bbso1124285b6e.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 01:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775205850; cv=none;
        d=google.com; s=arc-20240605;
        b=NHxGNhde5gJAr9YkrY0o65aNHlPHMsaD513ufi576dOGPrD4axrkrWfaJiqVhrNzZL
         uTNCgUUN9oBG9PZPyrt801epQvDThu4CYjl5d6kelPdaSo8DCANsvDXKBu+jxeJ8NcHt
         jio3E6tAsjLSmUavSj9yk0CagcP9Jh5c4NcZamNmwsiLevPuRLyAcZrjNUedZa6wPHdk
         bv97as1qKKYsymwRswSBVUZlCuIr/WPk0NLKX2PZRzq6//xIe8bWSCa87JPN6Ou5jZRN
         Yw4ITqA1B/CVfKuek/SUjNFd+5H5Xf2R8nEkGpDGxZAHp3AaLwEIPNu22Ty3V6+x1T7D
         GEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RF+JRoyl7L9bjm2RustUEzi2QSZF9I70Nt38bHT4J0=;
        fh=uJM7doXIMs6A9Xk+a2gh5kSVaIYCTuOt9ljDLdLzKmw=;
        b=C5oxbU8EbvuYJl5E2i0ngRDVEySx5G1pxyFuBNCLtvZXyTCt5bx4BUq7FwTYiPtvqa
         U44LsHwVLV05973csFPYHj2znQlkKv60isx0DFCq6HgF5yENIGm8UxqMXOvpI42xskPu
         7drgSZJjJTb2l4Ou1owT9GrkAP+XtXJ4jK2K31lThgJBW7MSWTgYFKdezvaE9XdLOvn1
         Vc6wL+jTC/ij1m16S6vnQOJp7rrpzNxtk0Ixf3TBqgJ4qcf7OcJ59/QUUydboldJTJFV
         l4zt2HywqwEAZHnB2ZmbmYhTFPxYdy61MrOvJ/KtQFLgsLk6N5QicLt+a0a6E3VC5Eys
         ApEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775205850; x=1775810650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RF+JRoyl7L9bjm2RustUEzi2QSZF9I70Nt38bHT4J0=;
        b=jaHU72mVfPUrWhv41mecJJFDzWVRgO2xyd+HyLoU5tHUg8uJfJ/CLfNGhd8xlVar6w
         1ymf1599/IW1N+55/vfN/8yVGObttP7g/K8r8gl6dDr1xlAVTltYu7DYoYZLy94RRydZ
         XaFKAZZ6QMeKGufzmN/Ql9zVLRXOLiaHRLAZRCC+vtdI+6j8CMUMZtW+5gHv8oGewgJX
         TcRxuxLc4RDvX/0sHmlJ/NCYZ2R8XHmOQtD65v/P7hkx+grQq5YsTtOR5QwkSJ40ut/F
         aFVPt+6lUF1ibyypELpoWR/aL+pXZA0l8j7/LtEy0nVNU07vxZ49lg13XEClHgFh8ycp
         lm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205850; x=1775810650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RF+JRoyl7L9bjm2RustUEzi2QSZF9I70Nt38bHT4J0=;
        b=mO6kVJNWFmSYzI8oz1VyfVBZk7CaiER2PbYH6BCdR7/1Cd/x+lHykKrw+dPLzmMh8/
         mZ7vkflYy06kOlfH80/GpsDxW8tW2UYvCHuMr9XKTPS/9pqA8EgD558Tr14iLwuoxxec
         jCx/GihOPRolEYt0cfFlcunSgxdC2NzTi9NmfhpFDBTVbyU5ylZdWB7dPreBO54haiTt
         3osYIirmoQxJq16DPlB4CxcY+40aebligVo4OGUEDElLTx33IGqlDQVd4q3eENBfvTzq
         ojyvnGAtN63MvBjmJHsTCbI/mNPxlAmDlDLzukfw0yCalC7umGhKbgP6TI2idbP32QgF
         9wtg==
X-Forwarded-Encrypted: i=1; AJvYcCUR01gxYWiVc5WhkLAgOnahmRxzVVa3J3cEJd2vMsgSRIjesAhNwkI5TOIbAXt1DiKBqpnWbt0+Ay7F@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbAcjtaywh8Z8nxqMHhMpuM7jmafHgDdZygbVnrUMYLE+qagX
	Oe9DWNavs4JyKT5Uutp4M/UW8E6QPs7UU8HUav3o4yYUi/1Dc90lxIJcBWx7xAQ21fxMkawxGAx
	i4R21ONdTPhEc4cBh8+Ra1gmNaB4x12WGJ6I2kDCBAg==
X-Gm-Gg: ATEYQzwc1mZF0y9HLsE+RE5e5gxjHzcYw5D/iE8e7lVmWyyfVMq4dXjX2HxBUZi/mSm
	yhJ/etA4a/AQpCDYK5ZMA3Mivyzrp7H6LyOV+LrSaLAVLCT+tCNiQl28IXeV136R2o9IXu7pj2j
	n+Rm/gsmGa0OHV6Odocf18EgDsu4gOPr5OUggrOkGYNjfadeb3eJ51MUcie37a1iOE359EnOvRa
	a1iW1qZRobs2UfF1TIBoEZ/BeZgfNbTftjsYmrG2R73Kae2/+leaGSB+Aw9ICtifJmf6EBUwCIa
	KFS8MKczcjlw4PZ0Ytmlv2RATltP3y4+4T2NZwR5GNmJl6s4fTx4XtyYfbRC9g0495BVEeN74cZ
	EJodJPP3wiTFxKbMpRkjDt5yUOQ==
X-Received: by 2002:a05:6820:8504:b0:67e:3c4a:eac2 with SMTP id
 006d021491bc7-68220941f6amr789592eaf.58.1775205850507; Fri, 03 Apr 2026
 01:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204155309.763597-1-anup.patel@oss.qualcomm.com>
 <20260204155309.763597-2-anup.patel@oss.qualcomm.com> <603b0a16-4965-2689-d3ea-3f9db0cc49aa@kernel.org>
In-Reply-To: <603b0a16-4965-2689-d3ea-3f9db0cc49aa@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 14:13:57 +0530
X-Gm-Features: AQROBzCX8E-gtZHtQYOERzN8D99nSVmVtNsF3Vjmsbb9BTHno86I9RztOZG8SnM
Message-ID: <CAAhSdy28oPgzaaZj94F-MToTYT6WTWsiSVpuy0VzLkM_maSP0g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Paul Walmsley <pjw@kernel.org>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Sunil V L <sunilvl@oss.qualcomm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Anup Patel <apatel@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Atish Patra <atishp@rivosinc.com>, 
	linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>, 
	Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 1:55=E2=80=AFPM Paul Walmsley <pjw@kernel.org> wrote=
:
>
> Hi Anup,
>
> On Wed, 4 Feb 2026, Anup Patel wrote:
>
> > From: Anup Patel <apatel@ventanamicro.com>
> >
> > In RISC-V, there is no CSR read/write instruction which takes CSR
> > number via register so add common csr_read_num() and csr_write_num()
> > functions which allow accessing certain CSRs by passing CSR number
> > as parameter. These common functions will be first used by the
> > ACPI CPPC driver and RISC-V PMU driver.
> >
> > Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
> > as CPPC register and the RISC-V SBI specification allows arbitrary
> > CSR number as PMU hardware counter. This means ACPI CPPC driver and
> > RISC-V PMU driver no longer need to do sanity checks on CSR number
> > which are now done by the common csr_read_num() and csr_write_num()
> > functions.
>
> I recall that when we discussed this patch on a call a few months ago, it
> was brought up that it seemed useful to restrict which CSRs could be read
> or written at runtime, on a per-vendor basis.  That way, the FFH interfac=
e
> couldn't be used to read or write custom CSRs that had nothing to do with
> CPPC or PMU functions.
>
> Are you still planning to implement that change?
>

The current csr_read_num() and csr_write_num() only allows
HPM counters and custom CSR space (as defined by the Priv
spec) to be accessible via ACPI FFH. The ACPI FFH interface
is very flexible and allows vendors to specify the CSR number
in the ACPI table itself so we don't need to compile kernel on
per-vendor basis.

In other words, the current approach allows same Linux kernel
image for multiple vendor even if they use custom CSRs in their
ACPI FFH interface.

Regards,
Anup
