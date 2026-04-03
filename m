Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE413CA480;
	Fri,  3 Apr 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231812; cv=none; b=R4XzmfGlKVcuNDzaS3LkA3fLOxQm5lxqZJAKrRKyEASWBNnzQ5le4POy4u05c2l9YeRPEtrGtsGrY9xlsZz36YtWZqdSruof3DfNbjF3R/eiGXe1xpJWtRn83IAyXu4CvZoqZSBdpqH3fNjB5w/gq6UXZkrCfwPcA7C6Vjj6/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231812; c=relaxed/simple;
	bh=d7Oo0NCSB/TG7jbObkGRS2GwGcfinzzv50WNHyopH6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B0KBYAO5/6RfVfSEKaBIlKa8KaTBYn4wnych7lLFPEV335VZy9ZbvJgYp2IIYwBOWIYFCkBsDaS//3KWYkBI+RIyBXWk1RAxRydWFpaKOSynOnd+MQRPSwR2d6wYpAwyRI57W50mwgjXIzLlU5zcScj9VbCOsaQoXMD6kV5w1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDuQGWsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDuQGWsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B9C4CEF7;
	Fri,  3 Apr 2026 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231812;
	bh=d7Oo0NCSB/TG7jbObkGRS2GwGcfinzzv50WNHyopH6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=vDuQGWsd8QjhkNmjZwJqNsn/66q3asMVzCxK4dx+Vn7n6UW1okRN6NC0y1g80zlKi
	 FtgRcmSF7JiVRYcH3bfgDeQ2FRrhpU314jpOoMnxhugJBPxUzreMLTng++QxsSNs/8
	 8HaaS1USR95pxBz8nLW/0jG559kASlibAcIt5lb3Ni7OCB1p2dFR2ES7DYos+KPlcK
	 gURc5TZiOLgIGInJJ4oNyZiWol1LG09ob+BfxEpjFFO7buFcc+khhjwwxSWnIsZTre
	 oH6m72Nvl+DZh5HrKWGh84ducWsapz4l1JSI1NS1NqjrOve54IejsX23ikuTuGFHoB
	 FeZsa7hegO/UQ==
Date: Fri, 3 Apr 2026 09:56:47 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Anup Patel <anup@brainfault.org>
cc: Paul Walmsley <pjw@kernel.org>, Anup Patel <anup.patel@oss.qualcomm.com>, 
    Sunil V L <sunilvl@oss.qualcomm.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Anup Patel <apatel@ventanamicro.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>, 
    Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
    Andrew Jones <andrew.jones@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
    Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Nutty Liu <nutty.liu@hotmail.com>, linux-riscv@lists.infradead.org, 
    Andrew Jones <ajones@ventanamicro.com>, Will Deacon <will@kernel.org>, 
    Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 1/1] RISC-V: Add common csr_read_num() and csr_write_num()
 functions
In-Reply-To: <CAAhSdy28oPgzaaZj94F-MToTYT6WTWsiSVpuy0VzLkM_maSP0g@mail.gmail.com>
Message-ID: <e8a5e3b7-b68a-8b92-192f-985a0559eb95@kernel.org>
References: <20260204155309.763597-1-anup.patel@oss.qualcomm.com> <20260204155309.763597-2-anup.patel@oss.qualcomm.com> <603b0a16-4965-2689-d3ea-3f9db0cc49aa@kernel.org> <CAAhSdy28oPgzaaZj94F-MToTYT6WTWsiSVpuy0VzLkM_maSP0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2101813137-1775231811=:751248"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2101813137-1775231811=:751248
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 3 Apr 2026, Anup Patel wrote:

> On Fri, Apr 3, 2026 at 1:55 PM Paul Walmsley <pjw@kernel.org> wrote:
> >
> > On Wed, 4 Feb 2026, Anup Patel wrote:
> >
> > > From: Anup Patel <apatel@ventanamicro.com>
> > >
> > > In RISC-V, there is no CSR read/write instruction which takes CSR
> > > number via register so add common csr_read_num() and csr_write_num()
> > > functions which allow accessing certain CSRs by passing CSR number
> > > as parameter. These common functions will be first used by the
> > > ACPI CPPC driver and RISC-V PMU driver.
> > >
> > > Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
> > > as CPPC register and the RISC-V SBI specification allows arbitrary
> > > CSR number as PMU hardware counter. This means ACPI CPPC driver and
> > > RISC-V PMU driver no longer need to do sanity checks on CSR number
> > > which are now done by the common csr_read_num() and csr_write_num()
> > > functions.
> >
> > I recall that when we discussed this patch on a call a few months ago, it
> > was brought up that it seemed useful to restrict which CSRs could be read
> > or written at runtime, on a per-vendor basis.  That way, the FFH interface
> > couldn't be used to read or write custom CSRs that had nothing to do with
> > CPPC or PMU functions.
> >
> > Are you still planning to implement that change?
> 
> The current csr_read_num() and csr_write_num() only allows
> HPM counters and custom CSR space (as defined by the Priv
> spec) to be accessible via ACPI FFH. The ACPI FFH interface
> is very flexible and allows vendors to specify the CSR number
> in the ACPI table itself so we don't need to compile kernel on
> per-vendor basis.
> 
> In other words, the current approach allows same Linux kernel
> image for multiple vendor even if they use custom CSRs in their
> ACPI FFH interface.

I understand that part.  The part that I don't like is that with this 
patch, the FFH interface could also be used to read and write custom CSRs 
that have nothing to do with CPPC or PMU functions.  That doesn't seem 
like a good idea.  What I had in mind was to add a way to restrict the 
custom CSRs that the kernel would allow FFH to use, via a mechanism other 
than the ACPI table - e.g., sysfs, or the kernel command line, etc.


- Paul
--8323329-2101813137-1775231811=:751248--
