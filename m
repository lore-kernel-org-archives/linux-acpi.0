Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9D221275
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800641; cv=none; b=dllnDw9i4tdwaTQcykxy884Shn3BDuKCgRQuMc5hffAaW44ckcJ83xXTdq2P+FYAsM0KyRwbaCIK6F/oXAHPdnixFEwTz7bd0L1gQ61BpXt7PDJ6hL6GiR7kbr/5Y0sFq7wx/TvDQgQKNp6AlC0ehc3HFvD7jIgqkTcZik8dxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800641; c=relaxed/simple;
	bh=5iGPad1azxRrEE2npdhqcO+ZngMeuq5NOnaWW9QCkRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7Swk2OWvNJpcS3toNRAh1dv8/YLdBB1B7yj0Cw+6KMXE+foHg0pyCorGMxw9Q670TG8Vg31BV+Fm51251KiRZte7ag6/ZLm1tgocm3bX5r2W/cjo4fSt7SHCc1vj9SnWdoV5mlySHvJItaqRBOmNzBNrx8fGPKhk2qOC2eBCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsUbEqlE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsUbEqlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9604FC4CEF7;
	Fri,  6 Mar 2026 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800641;
	bh=5iGPad1azxRrEE2npdhqcO+ZngMeuq5NOnaWW9QCkRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsUbEqlEYDbep36WwVOVJqKOJ1Sac3c3vzQN6jNrOjKL1KVi0b/XIC7Mdy/jifAdR
	 D4RFp8kav6WvQK3XgWvHYzIud2TQqcwvObBHYS1UHVbDTs3v1Dk9ZBB0UzfcpZ0rbn
	 HAoSBNZLGoyoGyTvjreWKlDNEf1hKmthNNktbVAPT+KBD8gTL0bRbU+aR0YfLTdrsE
	 J70Y/JKKisb7x6628EIUf1axzN7pB2ANnoA6oZP5nqYIleLKbj2jXge+yH8YMBBLVp
	 zBdQshIdg+ue67EYd/V/4Y60Ct/XYGYVF8XkRlhe/yNM9KinTE+jmBFadvjkTBPhHt
	 X8hLoE0nhPBig==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Pratap Nirujogi <pnirujog@amd.com>
Cc: mario.limonciello@amd.com, W_Armin@gmx.de, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
Date: Fri, 06 Mar 2026 13:37:16 +0100
Message-ID: <5975968.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
References:
 <20260306025144.604062-1-superm1@kernel.org>
 <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
 <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, March 6, 2026 1:17:19 PM CET Rafael J. Wysocki wrote:
> On Fri, Mar 6, 2026 at 11:50=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Mar 6, 2026 at 3:51=E2=80=AFAM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> > >
> > > After ACPI video was converted into a platform device in
> > > commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform =
one")
> > > other devices that are MFD children of LNXVIDEO are being probed.
> > > This isn't intended.
> > >
> > > During probe detect MFD cells and reject them.
> > >
> > > Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform =
one")
> > > Reported-by: Pratap Nirujogi <pnirujog@amd.com>
> > > Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c=
794c5952018@amd.com/
> >
> > The link is broken, so I can't see what is really happening, but my
> > guess is that MFD devices are created under the video bus device and
> > they get the same device ID (confusingly enough).
> >
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > >  drivers/acpi/acpi_video.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > > index 3fa28f1abca38..2cb526775ac47 100644
> > > --- a/drivers/acpi/acpi_video.c
> > > +++ b/drivers/acpi/acpi_video.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/types.h>
> > >  #include <linux/list.h>
> > > +#include <linux/mfd/core.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/input.h>
> > >  #include <linux/backlight.h>
> > > @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform=
_device *pdev)
> > >         int error;
> > >         acpi_status status;
> > >
> > > +       if (mfd_get_cell(pdev))
> > > +               return -ENODEV;
> >
> > If the above is the case, I'd prefer this check
> >
> >         if (!device->pnp.type.backlight)
> >
> > which should also work, but is more general.
>=20
> Well, this will not work if the ACPI companion is shared between
> multiple devices.
>=20
> However, adding an MFD check here is a "works for me" change rather.
>=20
> I think what needs to be done is to extend the duplication check (see
> my patch from yesterday at
> https://lore.kernel.org/linux-acpi/5663583.Sb9uPGUboI@rafael.j.wysocki/)
> to detect the cases when another platform device (not necessarily a
> child of the same parent) sharing the same ACPI companion is probed.

So, Pratap, can you please test the appended patch (untested so far)?

=2D--
 drivers/acpi/acpi_video.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

=2D-- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1978,16 +1978,38 @@ static int acpi_video_bus_put_devices(st
 	return 0;
 }
=20
+static bool acpi_video_bus_bound(struct acpi_device *adev)
+{
+	struct acpi_video_bus *video;
+
+	guard(mutex)(&video_list_lock);
+
+	list_for_each_entry(video, &video_bus_head, entry) {
+		if (video->device =3D=3D adev)
+			return true;
+	}
+
+	return false;
+}
+
 static int instance;
=20
 static int acpi_video_bus_probe(struct platform_device *pdev)
 {
 	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
+	static DEFINE_MUTEX(probe_lock);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
 	acpi_status status;
=20
+	/* Probe one video bus device at a time in case there are duplicates. */
+	guard(mutex)(&probe_lock);
+
+	/* Bind only one platform device for the given ACPI companion. */
+	if (acpi_video_bus_bound(device))
+		return -EALREADY;
+
 	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE,
 				acpi_dev_parent(device)->handle, 1,
 				acpi_video_bus_match, NULL,




