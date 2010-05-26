From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPICA: Handle large field apertures.
Date: Wed, 26 May 2010 15:31:39 +0800
Message-ID: <1274859099.3429.25.camel@minggr.sh.intel.com>
References: <4911F71203A09E4D9981D27F9D830858709F2D04@orsmsx503.amr.corp.intel.com>
	 <20100525105910.2629.76253.stgit@thinkpad>
	 <1274841567.28455.16.camel@minggr.sh.intel.com>
	 <1274842158.28455.18.camel@minggr.sh.intel.com>  <4BFCCE01.1070100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54202 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0EZHc3 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 26 May 2010 03:32:29 -0400
In-Reply-To: <4BFCCE01.1070100@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Wed, 2010-05-26 at 15:30 +0800, Alexey Starikovskiy wrote:
> Hi Ming,
>=20
> 26.05.2010 06:49, Lin Ming =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Better to test AccessByteWidth as below,
> Why not just 'if (AccessByteWidth > 255)' ?

OK, that's more clear.

> >=20
> > +                if (!(AccessByteWidth & ~0xFF)) {
> >=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
