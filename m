From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Handling dock events in userspace
Date: Fri, 7 Nov 2008 10:49:03 +0800
Message-ID: <20081107024903.GA18221@sli10-desk.sh.intel.com>
References: <1a6fd8660811060252k772d6ecdy83029ff687b998a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6641 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbYKGCtH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2008 21:49:07 -0500
Content-Disposition: inline
In-Reply-To: <1a6fd8660811060252k772d6ecdy83029ff687b998a8@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?B=E5rd?= Kalbakk <kalbakk@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 06, 2008 at 06:52:21PM +0800, B=E5rd Kalbakk wrote:
> Hi
> I need to handle dock events from dock.ko in order to enable video
> output on my Thinkpad Port Replicator. From the kernel I see that thi=
s
> event occurring:
>=20
> [  680.551956] ACPI: \_SB_.GDCK - undocking
> [  704.534054] ACPI: \_SB_.GDCK - docking
>=20
>=20
> The question is, how can I handle this event in userspace? I've tried
> listening to acpi events with acpi_listen, and uevents with udevd, bu=
t
> I get nothing.
>=20
> I just glanced at the source and saw some uevent references, but
> obviously this doesn't  automatically mean that it ends up in udevd.
> Is there any way to accomplish this with the current driver?
dock/undock will sent out uevent to udevd, please check your udev confi=
g.

Thanks,
Shaohua
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
