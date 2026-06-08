Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CE379C3D
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921302; cv=none; b=cbIEhm9Cmr3PIDQKf+zutRV85+TLsnlWcN7gppnWUlgfoYNg9oeTzriWTEAlrxru2ebLh3JW/ZmMjko2R5lzcrOZSp7sRm3IXK+Hb8y6qH1YntE2xpiU/mWybz4zIBiwheF+92nrisefLCtSntlqiICjYH7YGnc72Ld7nf6ETJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921302; c=relaxed/simple;
	bh=4x97u10WPQA6igiQIJfTndpOIGYqMwn0Ex4yNJjfw98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saSeRgWckUaXKjQuZYrcz6oeESu797UDmN7vtplqJmVmDVVuCRh5I1dUd2fcqxvuaNd/eUtcLkLlXMhfh02cJt6+szzL15P7sH8fyAhDMz5KAREPiVBWEFnvnZhJHfWI3hTQTJzWghXJnWPwFZ091K2Grc5n4fKutVqCRB8miVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aexewLCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aexewLCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F861F0089C
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780921301;
	bh=4x97u10WPQA6igiQIJfTndpOIGYqMwn0Ex4yNJjfw98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aexewLCDY6oJNDyREF8cyw1g40n1YhP7Wq+o32uj2sK2/GLfvHsKcPuBO3qQtF8wj
	 le08HK2JviZaeV5GKT3LqOqyDfuYOQT0v+JbvtGHjo5zbNyXuFH37VxUcaM/L45pEI
	 KJYvZIGIjOqqZ9sNek3NE6V2pMRg2G8Uy97vP375tp3BG4Ex7031pc+EN9VBMDW2Qf
	 ZoFeX+/5CK0sbPlii44YdzVLQXLQMU2fK+Iy9D/gk0egrKxWIrk7rw5Dh2qPtoy93D
	 vekXhMDijXTXTVqArNevW6+gCiVLFFrIYWluz5QSkMX+Zc9MGQ8/K0FTFkMpILIrGI
	 SsXuW5h2kSUgg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so4450260e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 05:21:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxZBWY4lJVNI2RO0m9V0ltwB7yQZZeuILWD8xVyRljdhilNwFM
	N4mHzMIGcb+Pr+bSfpf9OMRwvUmaYxoPJYh90lY+/ACfQwzxxkR4Y5S+zTQgo12mWW42fLCGUXs
	s3BpAPhNW7RiYvIhnpXo6wPM0ksZgDIc=
X-Received: by 2002:ac2:5fe9:0:b0:5aa:7083:51bc with SMTP id
 2adb3069b0e04-5aa87c23b43mr3237125e87.43.1780921299797; Mon, 08 Jun 2026
 05:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601194040.18223-1-miguel.vadillo@intel.com> <ah_bFVtDCzWPeE4z@kekkonen.localdomain>
In-Reply-To: <ah_bFVtDCzWPeE4z@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 14:21:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-wOi7atHzTpFmCgC-P3qRzG9d-941MCzXd=kzTbkQeg@mail.gmail.com>
X-Gm-Features: AVVi8Ccx4p9jSrFAw2U3kSbJtqpFb6_IQjpRfiURo9dQDT_HL2qhpP5vB07XXOE
Message-ID: <CAJZ5v0h-wOi7atHzTpFmCgC-P3qRzG9d-941MCzXd=kzTbkQeg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Honor _DEP for Intel CVS devices
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Miguel Vadillo <miguel.vadillo@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mehdi.djait@linux.intel.com, wei.a.xu@intel.com, 
	atul.raut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 9:43=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Miguel, Rafael,
>
> Thanks for the patch.
>
> On Mon, Jun 01, 2026 at 12:40:40PM -0700, Miguel Vadillo wrote:
> > CVS (Computer Vision Sensing) is an ACPI-enumerated device that sits
> > inline in the CSI-2 path between the camera sensor and Intel IPU.
> > On platforms where CVS is present, the camera sensor's ACPI node
> > declares a _DEP dependency on the CVS device.
> >
> > The CVS driver must be fully initialized before camera sensor drivers
> > probe, because CVS controls the CSI-2 link ownership handshake (via
> > GPIO REQ/RESP), the MIPI/CSI-2 lane configuration, and the camera
> > power domain. Without CVS ready, the sensor driver can bind but the
> > CSI-2 stream will not function correctly.
> >
> > The CVS driver calls acpi_dev_clear_dependencies() at the end of its
> > probe() to unblock waiting consumers once it is ready.
> >
> > Move the CVS HIDs from acpi_ignore_dep_ids[] to acpi_honor_dep_ids[]
> > so that camera sensor enumeration is deferred until the CVS driver has
> > finished probing, matching the behavior already in place for IVSC.
> >
> > Signed-off-by: Miguel Vadillo <miguel.vadillo@intel.com>
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Rafael: do you think this could still make it to 7.2? Otherwise cameras
> might not work on a some laptops where they did use to.
>
> The default configuration is appropriate in some laptops so camera used t=
o
> work without the CVS driver but now that we have the CVS driver merged an=
d
> the CVS device is part of the software node / ACPI graph, probing the
> camera sensor driver will in fact not take place at all (and obviously th=
e
> camera won't work in this case).

Applied as 7.2 material, thanks!
