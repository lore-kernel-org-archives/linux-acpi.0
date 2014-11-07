From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] ACPI / LPSS: fix system hangup on BYT
Date: Fri, 07 Nov 2014 15:54:59 +0200
Message-ID: <1415368499.472.27.camel@linux.intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <2488602.4jdJudSMmE@vostro.rjw.lan>
	 <1415349974.41658.YahooMailNeo@web87404.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38887 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbaKGNzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2014 08:55:23 -0500
In-Reply-To: <1415349974.41658.YahooMailNeo@web87404.mail.ir2.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Ashcroft <scott.ashcroft@talk21.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>

On Fri, 2014-11-07 at 08:46 +0000, Scott Ashcroft wrote:
>=20
> > I'm essentially fine with this series, but I'm not sure what the st=
atus of
> > the Scott's testing is.  Can you please tell me and Scott what in p=
articular
> > you wanted him to test?
>=20
>=20
> Initial testing has not gone well.
> The laptop does power down but it appears not to dismount the file sy=
stems cleanly.
> Running 'init 0' looks like it is doing a shutdown but the last thing=
 it logs=20
> is something to do with ntp rather than the normal flushing disks etc=
=2E
> It looks like things are powered down too soon.

I hope this is not related to mine patch series.
If you have time you may try to use last v3.18-rcX and apply patches on
top of that and re-test.

>=20
> I'll try and get some logs, tonight
> Are there any debug options I should turn on?

Hm=E2=80=A6 Now I have nothing come to my mind. Maybe Rafael could sugg=
est
something.


--=20
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
