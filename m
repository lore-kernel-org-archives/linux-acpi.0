From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Thu, 19 Mar 2009 10:50:03 +0800
Message-ID: <1237431003.3640.98.camel@localhost.localdomain>
References: <1237365385.3640.43.camel@localhost.localdomain>
	 <20090318134153.GA28461@srcf.ucam.org>
	 <1237425368.3640.61.camel@localhost.localdomain>
	 <20090319012141.GA7658@srcf.ucam.org>
	 <1237430522.3640.94.camel@localhost.localdomain>
	 <20090319024334.GA8638@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43045 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbZCSCtE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 22:49:04 -0400
In-Reply-To: <20090319024334.GA8638@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-03-19 at 10:43 +0800, Matthew Garrett wrote:
> On Thu, Mar 19, 2009 at 10:42:02AM +0800, yakui_zhao wrote:
> > On Thu, 2009-03-19 at 09:21 +0800, Matthew Garrett wrote:
> > > Yes. So how do we tell which ordering a machine needs without hav=
ing a=20
> > > blacklist? Windows doesn't.=20
> >=20
> > If there exists the different behaviour w/o the boot option, maybe =
it
> > should be added to the blacklist.=20
> >
> > =EF=BB=BFMaybe there is no such blacklist on windows.
>=20
> Quite. There shouldn't be on Linux.
If there is no such blacklist, the suspend/resume can't wok well on som=
e
boxes. IMO this can be workaround for some boxes that can't be resumed.
> =20
> > I verify this problem on windows by using KVM and find that the _PT=
S
> > object is called after device suspend in course of hibernate.(No S3=
 is
> > supported on KVM). In theory the _PTS is also called after device
> > suspend in course of suspend.
>=20
> What would it take to fake S3 on KVM enough that we could instrument=20
> Windows' behaviour?
The graphics simulated in KVM is too old.
>=20
> > But it is strange that suspend/resume can work well on windows XP.=20
> > Maybe more registers are saved/restored in course of suspend. But w=
e
> > can't know what should be saved/restored.
>=20
> Nor can we continue adding machines to a blacklist.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
