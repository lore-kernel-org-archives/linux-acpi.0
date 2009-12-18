From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Fri, 18 Dec 2009 10:21:12 +0800
Message-ID: <20091218022112.GA30333@sli10-desk.sh.intel.com>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
 <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33283 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbZLRCVP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Dec 2009 21:21:15 -0500
Content-Disposition: inline
In-Reply-To: <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, "Barnes, Jesse" <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Fri, Dec 18, 2009 at 09:28:50AM +0800, Yinghai Lu wrote:
> On Wed, Dec 16, 2009 at 12:06 PM, Len Brown <lenb@kernel.org> wrote:
> > Hi Linus,
> >
> > please pull from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.g=
it release
> >
> ;..
> >
> > Shaohua Li (3):
> > =A0 =A0 =A0ACPI: Add a generic API for _OSC -v2
> > =A0 =A0 =A0ACPI: cleanup pci_root _OSC code.
> > =A0 =A0 =A0ACPI: Add platform-wide _OSC support.
>=20
> it seems these three patches broke the _OSC on my intel new systems.
>=20
> revert them fix the problem with AER and pciehp and etc
can you give more details? I just cleaned up the _OSC code for AER and =
pciehp,
no function changes.

Thanks,
Shaohua
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
