From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: new kmemleak w/ latest ACPI updates
Date: Tue, 13 Apr 2010 15:52:19 +0800
Message-ID: <1271145139.7633.4.camel@minggr.sh.intel.com>
References: <201004102102.57235.toralf.foerster@gmx.de>
	 <1271124196.3656.0.camel@minggr.sh.intel.com>
	 <201004130939.40175.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53177 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab0DMIMT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Apr 2010 04:12:19 -0400
In-Reply-To: <201004130939.40175.toralf.foerster@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-04-13 at 15:39 +0800, Toralf F=C3=B6rster wrote:
> Lin Ming wrote at 04:03:16
> > On Sun, 2010-04-11 at 03:02 +0800, Toralf F=C3=B6rster wrote:
> > > Hello,
> > >=20
> > > running git kernel v2.6.34-rc3-500-g0eddb51 I observe this new km=
emleak :
> > >=20
> >=20
> > Could you please send the acpidump output?
>=20
> Attached,

Thanks.
I'll try to reproduce this memory leak in the simulator(AcpiExec).

The only ACPICA commit between f5284e..0eddb51 is bf02bd2

Could you revert that commit and see if the leak is gone?

Lin Ming

>=20
> btw suspend2ram (system in docking station) and wakeup (out of the do=
cking=20
> station with external VGA monitor) doesn't work too since that commit=
 (but=20
> might be related to different root cause).
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
