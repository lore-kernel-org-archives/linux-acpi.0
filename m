From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/8] introduce the device async action mechanism
Date: Mon, 20 Jul 2009 11:09:36 +0800
Message-ID: <1248059376.26272.311.camel@rzhang-dt>
References: <1247643516.26272.77.camel@rzhang-dt>
	 <20090715060006.71c2e2b6@infradead.org>
	 <1247709910.26272.159.camel@rzhang-dt> <200907170312.00006.rjw@sisk.pl>
	 <1247798643.26272.275.camel@rzhang-dt>  <20090719221658.GL26511@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62359 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbZGTDIp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Jul 2009 23:08:45 -0400
In-Reply-To: <20090719221658.GL26511@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Mon, 2009-07-20 at 06:16 +0800, Pavel Machek wrote:
> Hi!
>=20
> >=20
> > that's not enough.
> > ???For examples,
> > ACPI battery and EC are independent devices, but EC must be resumed
> > before battery because battery driver may access some EC address sp=
ace
> > during resume time.
>=20
> Yes, but those dependencies should be pulled from driver tree, not
> adding separate dependencies infrastructure.
>=20
Sorry, =EF=BB=BFthe problem I described above is wrong.
We just disable the EC interrupt mode in S3, but it still works.
Battery can access EC address space before EC resumed, in low speed.

=EF=BB=BF
>=20
> > > In particular, we have to make sure that parent devices will not =
be suspended
> > > until all of their children have been suspended and children devi=
ces will not
> > > be resumed before the parents.
> >=20
this is right.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
