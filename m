From: ykzhao <yakui.zhao@intel.com>
Subject: Re: 2.6.30 oops with acpi/button
Date: Fri, 10 Jul 2009 10:57:44 +0800
Message-ID: <1247194664.3568.13.camel@localhost.localdomain>
References: <alpine.LRH.2.00.0907090806560.5445@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16558 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbZGJC5H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Jul 2009 22:57:07 -0400
In-Reply-To: <alpine.LRH.2.00.0907090806560.5445@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Stephen J. Gowdy" <gowdy@cern.ch>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-07-09 at 16:29 +0800, Stephen J. Gowdy wrote:
> Hi Len & Bjorn,
>  	I've not had time to go back to it but with 2.6.30 I get an oops=20
> when I close the lid on my HP Compaq 6910p laptop. I see you removed =
some=20
> null pointer checks.. perhaps tha tis why? Here is the oops extracted=
 from=20
> my log file. If you want me to test a patch let me know. I'm about to=
 try=20
> 2.6.30.1 but I don't see anything in the ChangeLog that is likely to =
make=20
> a difference.
>  	I've gone back to 2.6.29.4 where it is fine. I tried unloading the=20
> "button" module first but in that case my laptop locked up without an=
=20
> oops. No flashing num/caps lock or anything, just froze when I close =
the=20
> lid. The version of button.c from 2.6.29.4  doesn't compile in the 2.=
6.30=20
> tree;
>=20
> drivers/acpi/button.c: In function =E2=80=98acpi_button_add_fs=E2=80=99=
:
> drivers/acpi/button.c:203: error: =E2=80=98struct proc_dir_entry=E2=80=
=99 has no member=20
> named =E2=80=98owner=E2=80=99
> drivers/acpi/button.c:208: error: =E2=80=98struct proc_dir_entry=E2=80=
=99 has no member=20
> named =E2=80=98owner=E2=80=99
> drivers/acpi/button.c: In function =E2=80=98acpi_button_init=E2=80=99=
:
> drivers/acpi/button.c:525: error: =E2=80=98struct proc_dir_entry=E2=80=
=99 has no member=20
> named =E2=80=98owner=E2=80=99
The proc_dir_entry::owner member is removed after the following commit
is shipped:
    commit 99b76233803beab302123d243eea9e41149804f3
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed Mar 25 22:48:06 2009 +0300

    proc 2/2: remove struct proc_dir_entry::owner

It seems that the owner member is already removed in the button driver.
Why does the above issue still exist?

Will you please try the latest kernel and see whether the issue still
exists?

=46or the LID oops issue on the HP6910P, will you please enable
"CONFIG_DRM_I915_KMS" in kernel configuration and see whether the issue
still exists? This had better be done in the latest kernel(for example:
2.6.31-rc1/2)

thanks.
   Yakui

>=20
>  	Any ideas?
>=20
>=20
>  						regards,
>=20
>  						Stephen.
>=20
> --=20
>   /------------------------------------+-------------------------\
> |Stephen J. Gowdy                     | CERN       Office: 8-1-11|
> |http://cern.ch/gowdy/                | CH-1211 Geneva 23        |
> |                                     | Switzerland              |
> |EMail: gowdy@cern.ch                 | Tel: +41 76 487 2215     |
>   \------------------------------------+-------------------------/

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
