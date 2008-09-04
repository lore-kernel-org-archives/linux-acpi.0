From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Thu, 4 Sep 2008 13:07:19 +0100
Message-ID: <20080904120719.GA9216@srcf.ucam.org>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <200809041010.07058.rjw@sisk.pl> <1220519910.24775.260.camel@rzhang-dt> <200809041137.52379.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38315 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYIDMHe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 08:07:34 -0400
Content-Disposition: inline
In-Reply-To: <200809041137.52379.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org

On Thu, Sep 04, 2008 at 11:37:51AM +0200, Rafael J. Wysocki wrote:
> > so it seems that the BIOS sets =EF=BB=BFfacs->xfirmware_waking_vect=
or during
> > POST, but uses =EF=BB=BF=EF=BB=BFfacs->firmware_waking_vector to ge=
t back during resume.
>=20
> So the BIOS is buggy, so let's add a quirk for it.

Does the machine resume in Windows? If so, do we have any evidence that=
=20
Windows has a quirks list to handle this case? If not, then I suspect=20
that Windows sets both and this is what everyone has tested against.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
