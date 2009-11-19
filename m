From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Openipmi-developer] IPMI device discovery [was Re: [PATCH ]
	IPMI: Locate the IPMI system interface in ACPI namespace]
Date: Thu, 19 Nov 2009 19:01:48 +0800
Message-ID: <1258628508.2933.28.camel@localhost.localdomain>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>
	 <200911180945.45570.bjorn.helgaas@hp.com> <4B045BD9.8070906@hp.com>
	 <200911181419.27238.bjorn.helgaas@hp.com>  <4B046CE2.90200@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57343 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbZKTCUm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Nov 2009 21:20:42 -0500
In-Reply-To: <4B046CE2.90200@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rocky Craig <rocky.craig@hp.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2009-11-19 at 05:53 +0800, Rocky Craig wrote:
> Bjorn Helgaas emitted:
>=20
> > I disagree that this requirement was lost....
>=20
> Sorry, my words did not convey my intended meaning, which was that
> "conformance" or "coherence" was lost, with SPMI also being listed
> in ACPI general namespace.
>=20
> You actually stated this with greater clarity:
>=20
> > There may be firmware that has an SPMI but neglects to put the devi=
ce
> > in the namespace.

>=20
> That may be the case on some legacy servers.
Yes. In the IPMI 1.5 spec there is no definition of IPMI detection abou=
t
SPMI.
The SPMI is added in IPMI 2.0 spec, which is used to detect the IPMI
system interface. Maybe this mechanism is already used on some legacy
servers.=20

=EF=BB=BFMaybe there exist both SPMI and IPMI system interface defined =
in ACPI
namespace. But they are the different BMC controllers.=20
In such case we had better not remove the detection of IPMI detection b=
y
using SPMI.=20
We can check whether they are the identical device in course of
registering IPMI system interface.

Thanks.


>=20
> Rocky

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
