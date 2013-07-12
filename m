From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Fri, 12 Jul 2013 16:45:15 +0800
Message-ID: <1373618715.7539.106.camel@linux-s257.site>
References: <1373544870-15135-1-git-send-email-oliver@neukum.org>
	 <1373575822.7539.74.camel@linux-s257.site>
	 <6802146.fKe43BS873@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:49784 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab3GLIqY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2013 04:46:24 -0400
In-Reply-To: <6802146.fKe43BS873@skinner.arch.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: oliver@neukum.org, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

=E6=96=BC =E4=BA=94=EF=BC=8C2013-07-12 =E6=96=BC 09:37 +0200=EF=BC=8CTh=
omas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> On Friday, July 12, 2013 04:50:22 AM joeyli wrote:
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2013-07-11 =E6=96=BC 14:14 +0200=EF=BC=8C=
oliver@neukum.org =E6=8F=90=E5=88=B0=EF=BC=9A
> ...
> > On the other hand, I saw another BIOS changed hardware_signature be=
cause
> > the VGA detect output resolution changed when S4 resume. It's a pro=
blem
> > for sometimes BIOS widely used hardware_signature on non-critical
> > hardware change.
>=20
> I wonder how Windows is handling that.
> The spec is rather clear and OS should abort the resuming:
> ------
> 5.2.10 Firmware ACPI Control Structure (FACS)
> ...
> If the values are not the same, OSPM assumes
> that the saved non-volatile image is from a different hardware
> configuration and cannot be restored.

Thanks for your kick.

Per information from OEM, Windows 8 didn't really block S4 resume when
hardware_signature not match, I think as Oliver's patch.

> ------
> I would say either:
>    - someone checks Windows behavior and if they do it wrong
>      and still resume, resuming unconditionally is an option.
>      But they might fix this at some point of time and force vendors
>      to do things right, then we would still try to resume even we
>      must not.
>=20
>   - a boot parameter for the poor souls with such BIOS defects
>     so that they can still resume
>=20
>=20
> My 2 cents,
>=20
>            Thomas
> --

I agreed your point, we should find a machine make sure the
hardware_signature changed by BIOS then install Windows 8 to verify the
behavior.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
