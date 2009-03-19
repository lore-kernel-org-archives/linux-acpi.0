From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Thu, 19 Mar 2009 10:42:02 +0800
Message-ID: <1237430522.3640.94.camel@localhost.localdomain>
References: <1237365385.3640.43.camel@localhost.localdomain>
	 <20090318134153.GA28461@srcf.ucam.org>
	 <1237425368.3640.61.camel@localhost.localdomain>
	 <20090319012141.GA7658@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40497 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602AbZCSClB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 22:41:01 -0400
In-Reply-To: <20090319012141.GA7658@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-03-19 at 09:21 +0800, Matthew Garrett wrote:
> On Thu, Mar 19, 2009 at 09:16:07AM +0800, yakui_zhao wrote:
> > On Wed, 2009-03-18 at 21:41 +0800, Matthew Garrett wrote:
> > > Do we have any idea what's going on here, yet?
> > >  Several of the machines=20
> > > on this blacklist are modern, so it's not a workaround for ancien=
t=20
> > > hardware.
> > Now we have no idea how the behaviour is changed with the boot opti=
on.
> > In fact the boot option is useful for all the boxes that can't be
> > resumed unless it is added.=20
> >=20
> > Although the machine is modern, the ACPI 1.0 is followed on this bo=
x.
> > Without the boot option of "acpi_sleep=3Dold_ordering", it can't be
> > resumed from S3 correctly. But after adding the boot option, the bo=
x can
> > be resumed.=20
>=20
> Yes. So how do we tell which ordering a machine needs without having =
a=20
> blacklist? Windows doesn't.=20

If there exists the different behaviour w/o the boot option, maybe it
should be added to the blacklist.=20

=EF=BB=BFMaybe there is no such blacklist on windows.

I verify this problem on windows by using KVM and find that the _PTS
object is called after device suspend in course of hibernate.(No S3 is
supported on KVM). In theory the _PTS is also called after device
suspend in course of suspend.
But it is strange that suspend/resume can work well on windows XP.=20
Maybe more registers are saved/restored in course of suspend. But we
can't know what should be saved/restored.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
