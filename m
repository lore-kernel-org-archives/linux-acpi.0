Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2432C94A;
	Tue, 28 Apr 2026 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398014; cv=none; b=Z71LLUWDDSR+/K+fCIlgoPd+HT0+aWuX6Ch8CwtS0i3xFu6yc5gy6Sw6mOFwy/pQvycRhUDNz86FxR9Jx0aQtZKd02KsMGmeIEsY0PGHG/ipAI6sGwGAXY0M9yFlu2MfjsfhwdjJMc+6eFCzTV49edusEVg9SwdieIMZtLST8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398014; c=relaxed/simple;
	bh=wlZZpjzxWAOt7ylLcWj2difhc5YFhk+f8toFmHOjMUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHzmPxQEbJkTlHwEHXQUJFsSB2I/C91a768Rv5aIFx6ITblp9ii3yD7MhGp3fV/3YKcoki/LSYz54wM7zqXANONw9mnTwqtpzUxi//Q8uI9q9Sze/4XiSAR26Y7n60x99nehNfyVMFmDnl1QRQqMmWruGHpN9qVZXLw2Xlpbptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDHVfQPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDHVfQPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1BCC2BCAF;
	Tue, 28 Apr 2026 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777398014;
	bh=wlZZpjzxWAOt7ylLcWj2difhc5YFhk+f8toFmHOjMUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDHVfQPnkfDIjCcOqnkd2//91tKxxz7Ye2BN6Ytuf8Fz4k7mOP2Df8vuA4Z/9QeWs
	 BbKdVkIcaDJqjDTKKt13cGWZdvbdvnhkchkHdr3f4AdmEYoHx74j30JS49irn7xfxl
	 zp0ARMxKIXOoOiFoZ6sm9cb5Z5/nXwdr3W4A/kKQLMUBFWr9RD3x0yonSAkXbUtVFp
	 vzl9xiWAqbHa2sWHzk/jrUX7A0GDT/HqG6FaFeh/yaEhpqaJj2AygUFddftllpyHGc
	 giLw8gzMJjlU01kXzeDUhXtPw5KAOHkknzU8hW1jpdQuUnfaX9xtJN/aG73cHy4/0T
	 H5qoCPnCssCUw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Tue, 28 Apr 2026 19:40:11 +0200
Message-ID: <6281827.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY2QRhfoP5NjMQOg5WB15DpPcmX3aBWEy70xYKGMveZ_zg@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <6006426.DvuYhMxLoT@rafael.j.wysocki>
 <CAGAxtY2QRhfoP5NjMQOg5WB15DpPcmX3aBWEy70xYKGMveZ_zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, April 27, 2026 11:49:51 PM CEST Evgeny Sagatov wrote:
> apr 28 00:48:34 srv kernel: ACPI power button event
> apr 28 00:48:34 srv kernel: ACPI event status I/O port number: 1024
>=20
> =D0=BF=D0=BD, 27 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 23:31, R=
afael J. Wysocki <rafael@kernel.org>:
> >
> > On Monday, April 27, 2026 10:12:33 PM CEST Evgeny Sagatov wrote:
> > > dmesg | grep "frequency scaling"
> > > [    8.552380] acpi_cpufreq: CPU0: Using I/O space for frequency scal=
ing
> > > [    8.552386] acpi_cpufreq: CPU0: frequency scaling I/O port number:=
 2176
> > > [    8.552478] acpi_cpufreq: CPU1: Using I/O space for frequency scal=
ing
> > > [    8.552480] acpi_cpufreq: CPU1: frequency scaling I/O port number:=
 2176
> > > [    8.552584] acpi_cpufreq: CPU2: Using I/O space for frequency scal=
ing
> > > [    8.552586] acpi_cpufreq: CPU2: frequency scaling I/O port number:=
 2176
> > > [    8.552668] acpi_cpufreq: CPU3: Using I/O space for frequency scal=
ing
> > > [    8.552670] acpi_cpufreq: CPU3: frequency scaling I/O port number:=
 2176

The I/O ports that play the role in this issue are separate from each other=
 in
the address space, but that need not mean that they are physically independ=
ent.

My current theory is that accessing one of them while an access to the other
one is still in progress may cause the platform to lock up, or there is an
access pattern that causes that to happen.

Let's first test the simplest variant of that theory and see what happens if
all I/O port accesses in acpi_os_write_port() are serialized, which is done
in the patch below (it is a replacement for all of the patches sent so far).

In addition, that patch causes schedutil to use the slow path for updating =
the
frequency because the I/O space is generally somewhat too slow to be used
from the scheduler context relatively often, but that should not affect the
behavior related to I/O space accesses.

Please check if the system still locks up after pressing the power button
with this patch applied.

=2D--
 drivers/acpi/osl.c             |    9 +++++++--
 drivers/cpufreq/acpi-cpufreq.c |    9 ++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

=2D-- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -700,8 +700,10 @@ EXPORT_SYMBOL(acpi_os_read_port);
=20
 acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 {
=2D	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
=2D		return AE_NOT_IMPLEMENTED;
+#ifdef CONFIG_HAS_IOPORT
+	static DEFINE_RAW_SPINLOCK(acpi_os_write_port_lock);
+
+	guard(raw_spinlock_irqsave)(&acpi_os_write_port_lock);
=20
 	if (width <=3D 8) {
 		outb(value, port);
@@ -715,6 +717,9 @@ acpi_status acpi_os_write_port(acpi_io_a
 	}
=20
 	return AE_OK;
+#else
+	return AE_NOT_IMPLEMENTED;
+#endif
 }
=20
 EXPORT_SYMBOL(acpi_os_write_port);
=2D-- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -878,6 +878,10 @@ static int acpi_cpufreq_cpu_init(struct
 	policy->freq_table =3D freq_table;
 	perf->state =3D 0;
=20
+	policy->fast_switch_possible =3D !acpi_pstate_strict &&
+		!(policy_is_shared(policy) &&
+		  policy->shared_type !=3D CPUFREQ_SHARED_TYPE_ANY);
+
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		/*
@@ -887,6 +891,8 @@ static int acpi_cpufreq_cpu_init(struct
 		 * unknown and not detectable via IO ports.
 		 */
 		policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu);
+		/* I/O spcase is too slow for fast switching. */
+		policy->fast_switch_possible =3D false;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
@@ -912,9 +918,6 @@ static int acpi_cpufreq_cpu_init(struct
 	 */
 	data->resume =3D 1;
=20
=2D	policy->fast_switch_possible =3D !acpi_pstate_strict &&
=2D		!(policy_is_shared(policy) && policy->shared_type !=3D CPUFREQ_SHARED_=
TYPE_ANY);
=2D
 	if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
=20



