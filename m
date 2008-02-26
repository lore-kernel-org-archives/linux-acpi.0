From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real" device nodes
Date: Mon, 25 Feb 2008 22:45:43 -0800
Message-ID: <200802252245.43282.david-b@pacbell.net>
References: <200802222154.25204.david-b@pacbell.net> <1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:44368 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751755AbYBZGpp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 01:45:45 -0500
In-Reply-To: <1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Monday 25 February 2008, Zhang, Rui wrote:
> > + =A0 =A0 =A0 if (!ACPI_FAILURE(status)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sysfs_create_link(&dev->kobj,=
 &acpi_dev->dev.kobj,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "firm=
ware_node");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sysfs_create_link(&acpi_dev->=
dev.kobj, &dev->kobj,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "phys=
ical_node");
> > + =A0 =A0 =A0 }
>
> ret is not needed here...

But what compiler warnings do you see when you omit it?  :)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
