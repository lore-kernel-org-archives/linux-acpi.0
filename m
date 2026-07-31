Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53E4207A
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505324; cv=none; b=Nxw8cjLURB+rrlmTE5/Sa/Inv3gG9cxrcAbmQo/oHATsCVvh+roxKpsC7GimQ3IKkkhmJB7afXDMJ34I+NziUXLA0myxZVYyQVbnpLwktb81leggB185w4JQPqVw42/F5c6NKsSJj3+vJkN9/3qNAlIwkepC3Cj9qKWkH6wZG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505324; c=relaxed/simple;
	bh=xulBkEBoW/Vipy84Mg1gXjd7RRHLkaEtxMYygUAymjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARPeTQnJ87nBBVeemhrt9J8wDhx2PcTCpaQaEO6yFH9qQJwhLyXGtAzmn0+8AY241sflODEBIECal9YRzLyDzqGs8Gcy3dJglOiAbvA8+vxI0/qmoCpuD45Dnmgfc3dX3u2VaDga4C8V80PqWwwWQiBCLwzKOk5/xlZjsxrxleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1ojylSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1ojylSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F69F1F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505323;
	bh=ziwLSFeYv7qGbVdCZPRrsO565whIeVlucmgjj21mw1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U1ojylSKuWWLfky1GUKvMT2MZqtpbSzt4yMaqJGVjklzuNJ49wMPdFUdVyqSlxHSY
	 pB7W0SJdpG5gwAoLV3Y+oaloPSfyGfXd9QjS3dbSQi3v8bz0Ak5ZxW+5LGpPUbtL9r
	 4eno3/GVoAFCVZ2ywWFdzDdgKzcggT1EFMv/hcWaxelRGxoerbFrse+HsgEggpvrSv
	 v9uxpYGA3H2y54UckUAYhH6/UYrUnKMWmBY/p6wCDL+0HFADoSYmSclzPhr6mcUO2c
	 uMy0OOGn7y/UgZCS2dBPf6P6sg5nWQtbdvDEdFMi02rVrw9Poe1sNYRvm7UdAYxulT
	 mWROV4CN0IC4g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39da69c5ba3so7664571fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 06:42:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqjw5B37/gujyLwjKgIF4+QBAT8BpwFCeQ+JtSxbNZQWHk14/APbjvWwa0qYCHxRvqmJyViTWrKdVEd@vger.kernel.org
X-Gm-Message-State: AOJu0YxruktxMtxH16egnrHXyIQpuCiqNHULikcHLwtK+5i/tejds+4j
	gL9bl+nXG+xSnyCGfffRsD+fMyyu6FHWGoKBkiWMJLcuC8+ahtr0b9Ayojc7HpiOmWuXC5J6qeD
	D+V7V0WGobB+4Gvh70yOI1030BB5TNNk=
X-Received: by 2002:a05:6512:251e:b0:5b1:6130:b83a with SMTP id
 2adb3069b0e04-5b2e1ffe663mr473612e87.55.1785505321560; Fri, 31 Jul 2026
 06:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com> <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com> <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
 <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com> <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
 <588c2e18-e6fb-4fc1-95d5-7a5dd0f556fe@gmail.com>
In-Reply-To: <588c2e18-e6fb-4fc1-95d5-7a5dd0f556fe@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 15:41:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gXtKEaNDdSRqd57zg9GbFN-VDHrU5-=EEQPdSa9Zk-xw@mail.gmail.com>
X-Gm-Features: AUfX_myny4EGedYcM4sa8xfU_VQjyCSaiBahOaU8wNq2oZCnensu24184gcoNy0
Message-ID: <CAJZ5v0gXtKEaNDdSRqd57zg9GbFN-VDHrU5-=EEQPdSa9Zk-xw@mail.gmail.com>
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Julian Silver <mendaxca@gmail.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:06=E2=80=AFPM Julian Silver <mendaxca@gmail.com> =
wrote:
>
> On 2026-07-31 19:58:32, Rafael J. Wysocki (Intel) wrote:
> > Please boot with "intel_idle.states_off=3D16" in the kernel command lin=
e
> > and see if the problem is still there.  If this doesn't help, please
> > also try "intel_idle.states_off=3D24".
>
> "intel_idle.states_off=3D16" does not help.  "intel_idle.states_off=3D24"=
 works.
> Note that the test is performed on vanilla kernel v7.2-rc5(without the pa=
tch).

Yes, that's what I meant, thanks!

The kernel command line switch that works causes idle states 3 and 4
(C3 and C6) to be disabled by default.  These CPU idle states allow
the processor to enter package idle states (PC2 or deeper), so what
(most likely) happens is that the package idle states on this platform
somehow interfere with EHCI probing (causing the latter time out).  It
is basically a platform issue that was previously hidden.

Note that you can re-enable idle states disabled by default by doing (as ro=
ot)

# echo 0 | tee /sys/devices/system/cpu/cpu*/cpuidle/state[3-4]/disable

Before the commit in question EHCI was probed before the intel_idle
initialization and so package idle states were not used at that time
and before, but that was only due to the initialization ordering based
on driver name (so fragile anyway).

I'm not sure how to address this cleanly because moving the intel_idle
initialization back to the device_initcall() level won't guarantee the
working initialization ordering (for instance, if ehci-pci is a
module), but let me send you one more debug patch.
