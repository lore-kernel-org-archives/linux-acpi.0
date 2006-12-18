From: Stefan Seyfried <seife@suse.de>
Subject: Re: suspend to RAM on lifebook 7110
Date: Mon, 18 Dec 2006 12:29:16 +0100
Message-ID: <20061218112916.GB6636@suse.de>
References: <20061208123358.GA3724@invalid.invalid> <20061208211308.GA5157@erebor.ics.muni.cz> <20061218065136.GG26170@suse.de> <20061218111142.GA27070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:53072 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbWLRL36 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Dec 2006 06:29:58 -0500
Content-Disposition: inline
In-Reply-To: <20061218111142.GA27070@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Miroslav Ruda <ruda@ics.muni.cz>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>

Hi Matthew,

thanks for explaining this, i am obviously not too deep into that
PCI bus stuff :-)

On Mon, Dec 18, 2006 at 11:11:42AM +0000, Matthew Garrett wrote:
> On Mon, Dec 18, 2006 at 07:51:36AM +0100, Stefan Seyfried wrote:
>=20
> > I thought that this should somehow go away by the PCI bus suspend/r=
esume
> > methods that somewhen back got merged by Greg K-H.
>=20
> The kernel will only save and restore the standardised PCI configurat=
ion=20
> registers - anything else needs to be handled by the specific device=20
> driver. Unfortunately, in the graphics hardware case, the closest thi=
ng=20
> to that is the framebuffer driver. Which we don't tend to use.

So the question is: should we either
 - implement a minimal "graphics card PCI suspend resume" "driver" in t=
he
   kernel that will do this even if no framebuffer is used, or
 - implement this as a workaround in userspace?

I mean - it is not rocket science to do it in s2ram, but it just seems
more correct (to me) to do it in the kernel, where the correct locking
and ordering is more or less guaranteed.

--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
