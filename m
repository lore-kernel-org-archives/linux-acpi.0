From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Thu, 19 Mar 2009 02:43:34 +0000
Message-ID: <20090319024334.GA8638@srcf.ucam.org>
References: <1237365385.3640.43.camel@localhost.localdomain> <20090318134153.GA28461@srcf.ucam.org> <1237425368.3640.61.camel@localhost.localdomain> <20090319012141.GA7658@srcf.ucam.org> <1237430522.3640.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60357 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbZCSCnk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2009 22:43:40 -0400
Content-Disposition: inline
In-Reply-To: <1237430522.3640.94.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Mar 19, 2009 at 10:42:02AM +0800, yakui_zhao wrote:
> On Thu, 2009-03-19 at 09:21 +0800, Matthew Garrett wrote:
> > Yes. So how do we tell which ordering a machine needs without havin=
g a=20
> > blacklist? Windows doesn't.=20
>=20
> If there exists the different behaviour w/o the boot option, maybe it
> should be added to the blacklist.=20
>
> =EF=BB=BFMaybe there is no such blacklist on windows.

Quite. There shouldn't be on Linux.
=20
> I verify this problem on windows by using KVM and find that the _PTS
> object is called after device suspend in course of hibernate.(No S3 i=
s
> supported on KVM). In theory the _PTS is also called after device
> suspend in course of suspend.

What would it take to fake S3 on KVM enough that we could instrument=20
Windows' behaviour?

> But it is strange that suspend/resume can work well on windows XP.=20
> Maybe more registers are saved/restored in course of suspend. But we
> can't know what should be saved/restored.

Nor can we continue adding machines to a blacklist.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
