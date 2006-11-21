From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: problems about ACPI sysfs convert work
Date: Tue, 21 Nov 2006 16:34:38 +0000
Message-ID: <20061121163438.GA16748@srcf.ucam.org>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com> <1164021493.3721.229.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:38104 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1031073AbWKUQen (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 11:34:43 -0500
Content-Disposition: inline
In-Reply-To: <1164021493.3721.229.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

(I seem to be missing the original mail here...)

On Mon, Nov 20, 2006 at 12:18:13PM +0100, Thomas Renninger wrote:
> > Hello, lists
> > I=E2=80=99m doing the ACPI sysfs convert work now. And I have some =
problems when duplicating some procfs interfaces to sysfs.
> > Under driver model (this will be available soon), files under /proc=
/acpi/xxx(driver)/yyy(device)/ will be duplicated under /sys/device/ as=
 they are properties of individual devices.
> > But I still have some trouble on dealing with the files under /prco=
/acpi, including =E2=80=9Calarm=E2=80=9D, =E2=80=9Csleep=E2=80=9D, =E2=80=
=9Cwakeup=E2=80=9D, =E2=80=9Cdebug_layer=E2=80=9D, =E2=80=9Cdebug_level=
=E2=80=9D, =E2=80=9Cdsdt=E2=80=9D, =E2=80=9Cfadt=E2=80=9D, =E2=80=9Ceve=
nt=E2=80=9D and =E2=80=9Cinfo=E2=80=9D.
> > Following is a proposal as well as some problem and I=E2=80=99m not=
 quite sure about the places all these attributes should be located at.=
 I wish to get some advice from you, and any comment is welcome=E2=98=BA=
=2E
> >=20
> > 1. Where should =E2=80=9Calarm=E2=80=9D be located? Another problem=
 is whether we should put a duration into this file instead of a future=
 time.
> Don't know, never used...

This should presumably just be handled by the clock driver rather than=20
the ACPI subsystem. There's only a tiny amount of acpi-related code in=20
the driver, and that's information that we could just export to the=20
clock instead.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
