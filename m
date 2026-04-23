Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C443F0A83;
	Thu, 23 Apr 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950226; cv=none; b=hIFffz9pjtaYa2YHODihj8oooXBnRUEcxD12SsYWqzplfhASSHHS8Lqu1Sx369UjXN0drd/dTjE7bNTy8wwNYLd1QMA5aEHC/4M3E7xq42j+LYU49JS+4ObW19LZvtbDeRevm6ctZaHRyL2C89QoJYN49nMcUfPbQwiivN4Boik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950226; c=relaxed/simple;
	bh=vGXpRG4LLVh/X3uWoVL6OrFPCcZtVGxI9u6JpzE/53g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQyT++fw+eR740wjW+3QnSIlz+pXsTTBQhLV3ci+GXzdhvfcGVvRHsSiPXXOLO5UINcDknMLQDcHCi5zQFhFuUggJBCtLNa82hb9EHwdvcjwh1slBOmNaqc3wtlyzCvDi8rkf0zusAHm50ylvBmPgWgvs+qtSZNV1cV3mUakFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVImt7XQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVImt7XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BDBC2BCAF;
	Thu, 23 Apr 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776950225;
	bh=vGXpRG4LLVh/X3uWoVL6OrFPCcZtVGxI9u6JpzE/53g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVImt7XQgNWB9VcLbWJr+0mErEjwXABcnRKo9AJPAfA8i8vo6kw1+TFjNKcziG/SZ
	 a8RHW6qmSVqsH0z2qOQ/COItkV8Z1qbAKjT8jH62mETkAo32uvhSBykMWuo4tOoN4W
	 8QZfcbyjz41JSC3gICpXduv8KwMveIFqdY/DmQ5O45Xkft+diO/jEuWHXH/kVpNvlX
	 pjotFbmfUU/BMgc0VztJpO74742hjn3G7prP1FW2nlC/BSydey/qCkCr2jaPY74bYC
	 e3FBvVTEEp40MXGE1LsrNAkUICRFoHZu6aEuLByCUmG9nZc6dY2WoxZg9VB+o8U9rj
	 s19O40OobjELQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Thu, 23 Apr 2026 15:17:01 +0200
Message-ID: <4738258.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY0tgWJ=QQ48=aYTiQd994Z+9e=BAFN1OFTvzP9KE46t8A@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0j+WO2yP53nvjshFfEo+ETWiyCo7LohoN2DoORVd_NFbw@mail.gmail.com>
 <CAGAxtY0tgWJ=QQ48=aYTiQd994Z+9e=BAFN1OFTvzP9KE46t8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, April 22, 2026 4:48:41 PM CEST Evgeny Sagatov wrote:
> > There are two cpufreq governors to choose from.  Have you decided to co=
mpile out the other ones on purpose?
>=20
> Powersave is compiled into the stock Debian kernel as a module, so it
> does not appear in this list.
>=20
> I changed governor to powersave and pressed the power button. The PC
> shut down normally.

Interesting.

Can you please also check what happens if you change the cpufreq governor
to "performance" (on all CPUs) before pressing the power button?

The difference is that with the "performance" governor the CPUs will be
running at the highest frequency.

> =D1=81=D1=80, 22 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:04, R=
afael J. Wysocki <rafael@kernel.org>:
> >
> > On Wed, Apr 22, 2026 at 3:34=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@=
gmail.com> wrote:
> > >
> > > # grep -r . /sys/devices/system/cpu/cpufreq/
> > > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq:2000000
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_available_governors:p=
erformance
> > > schedutil
> >
> > There are two cpufreq governors to choose from.  Have you decided to
> > compile out the other ones on purpose?
> >
> > It might be useful to compile the powersave governor in and try to
> > switch over to it (on all CPUs) before pressing the power button
> > (without any patches applied).
> >
> > > /sys/devices/system/cpu/cpufreq/policy2/freqdomain_cpus:2
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor:schedutil
> > > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_max_freq:2834000
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_available_frequencies=
:2834000
> > > 2000000
> >
> > The frequency scaling on this CPU is quite limited (only 2 states to
> > choose from).
> >
> > > /sys/devices/system/cpu/cpufreq/policy2/related_cpus:2
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:2000088
> >
> > Interestingly, this number doesn't match the available choices (maybe
> > due to a rounding error or similar).
> >
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed:<unsupported>
> > > grep: /sys/devices/system/cpu/cpufreq/policy2/stats/reset: Access den=
ied
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:   From  : =
   To
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:         :
> > > 2834000   2000000
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2834000:
> > >       0       762
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2000000:
> > >     761         0
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/total_trans:1523
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2834000 6=
606
> > > /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2000000 2=
48733
> > > /sys/devices/system/cpu/cpufreq/policy2/affected_cpus:2
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2834000
> > > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:16=
0000
> > > /sys/devices/system/cpu/cpufreq/policy2/scaling_driver:acpi-cpufreq
> > > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_min_freq:2000000
> > > /sys/devices/system/cpu/cpufreq/policy2/bios_limit:2834000
> >
> > The fact that acpi-cpufreq is the scaling driver may be related to the
> > power button issue in principle.
> >
> > I'm still going to send you another debug patch for the button driver t=
hough.

So the patch is appended.  It causes a message to be printed into the kernel
log every time the power button is pressed if all goes well, but the system
will not shut down (it is also not expected to hang).

Please see if that happens with the patch applied (it is a replacement for =
the
previous debug patch).  In principle it should work without changing the
cpufreq governor.

=2D--
 drivers/acpi/button.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

=2D-- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -473,14 +473,12 @@ static void acpi_button_notify(acpi_hand
 					event, ++button->pushed);
 }
=20
=2Dstatic void acpi_button_notify_run(void *data)
=2D{
=2D	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
=2D}
=2D
 static u32 acpi_button_event(void *data)
 {
=2D	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
+	struct acpi_button *button =3D data;
+
+	dev_info(button->dev, "ACPI button event\n");
+
 	return ACPI_INTERRUPT_HANDLED;
 }
=20



