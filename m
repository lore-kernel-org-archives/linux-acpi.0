From: Scott Ashcroft <scott.ashcroft@talk21.com>
Subject: Re: [PATCH v1 0/4] ACPI / LPSS: fix system hangup on BYT
Date: Fri, 7 Nov 2014 08:46:14 +0000
Message-ID: <1415349974.41658.YahooMailNeo@web87404.mail.ir2.yahoo.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com> <2488602.4jdJudSMmE@vostro.rjw.lan>
Reply-To: Scott Ashcroft <scott.ashcroft@talk21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm31-vm1.bullet.mail.ne1.yahoo.com ([98.138.229.41]:53290 "EHLO
	nm31-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbaKGItG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2014 03:49:06 -0500
In-Reply-To: <2488602.4jdJudSMmE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>



> I'm essentially fine with this series, but I'm not sure what the stat=
us of
> the Scott's testing is.=A0 Can you please tell me and Scott what in p=
articular
> you wanted him to test?


Initial testing has not gone well.
The laptop does power down but it appears not to dismount the file syst=
ems cleanly.
Running 'init 0' looks like it is doing a shutdown but the last thing i=
t logs=20
is something to do with ntp rather than the normal flushing disks etc.
It looks like things are powered down too soon.

I'll try and get some logs, tonight
Are there any debug options I should turn on?

Cheers,
Scott
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
