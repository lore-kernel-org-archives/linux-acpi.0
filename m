From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Thu, 19 Mar 2009 02:56:24 +0000
Message-ID: <20090319025624.GA9222@srcf.ucam.org>
References: <1237365385.3640.43.camel@localhost.localdomain> <20090318134153.GA28461@srcf.ucam.org> <1237425368.3640.61.camel@localhost.localdomain> <20090319012141.GA7658@srcf.ucam.org> <1237430522.3640.94.camel@localhost.localdomain> <20090319024334.GA8638@srcf.ucam.org> <1237431003.3640.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49430 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbZCSC43 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2009 22:56:29 -0400
Content-Disposition: inline
In-Reply-To: <1237431003.3640.98.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Mar 19, 2009 at 10:50:03AM +0800, yakui_zhao wrote:
> On Thu, 2009-03-19 at 10:43 +0800, Matthew Garrett wrote:
> > On Thu, Mar 19, 2009 at 10:42:02AM +0800, yakui_zhao wrote:
> > > =EF=BB=BFMaybe there is no such blacklist on windows.
> >=20
> > Quite. There shouldn't be on Linux.
> If there is no such blacklist, the suspend/resume can't wok well on s=
ome
> boxes. IMO this can be workaround for some boxes that can't be resume=
d.

Workarounds should be temporary. Blacklists scale badly. In the long ru=
n=20
we need to determine why this doesn't work.

> > > I verify this problem on windows by using KVM and find that the _=
PTS
> > > object is called after device suspend in course of hibernate.(No =
S3 is
> > > supported on KVM). In theory the _PTS is also called after device
> > > suspend in course of suspend.
> >=20
> > What would it take to fake S3 on KVM enough that we could instrumen=
t=20
> > Windows' behaviour?
> The graphics simulated in KVM is too old.

Is this simply a matter of the driver setting a flag to indicate that i=
t=20
supports S3?

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
