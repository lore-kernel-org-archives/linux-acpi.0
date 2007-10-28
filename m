From: Thomas Renninger <trenn@suse.de>
Subject: Re: acpi problems on a medion 8800 desktop pc
Date: Sun, 28 Oct 2007 02:58:36 +0200
Message-ID: <1193533116.3974.11.camel@fanta4.site>
References: <200710272055.27056.bart.van.rillaer@gmail.com>
	 <472398C4.1030308@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49655 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbXJ1A6i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Oct 2007 20:58:38 -0400
In-Reply-To: <472398C4.1030308@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Bart <bart.van.rillaer@gmail.com>, linux-acpi@vger.kernel.org

On Sun, 2007-10-28 at 00:00 +0400, Alexey Starikovskiy wrote:
> Bart wrote:
> > Hi,
> >=20
> > Currently I'm having two acpi problems on linux.
> >=20
> > 1. My temperature is reported as -47=C2=B0C (THRM/temperature).
> > 2. And sometimes the pc is automatically shutdown due to a critical=
=20
> > temperature event (not often).
> First, check if you use lm_sensors.
> They work with the same hardware as ACPI, and might cause wrong readi=
ngs.

Yep, it's probably that.
Temperature is read through these ports:
    OperationRegion (SEN1, SystemIO, 0x0295, 0x02)
    Field (SEN1, ByteAcc, NoLock, Preserve)
    {
        SEI0,   8,
        SED0,   8
    }

There was another bug report where these were also accessed via sensor
modules...
This should be caught by the acpi vs native interference checker in
future.
Bart: Those patches will pop up in next -mm release, it would be great
if you can give them a try. You should see a message in your syslog the=
n
that a module failed to load...

Thanks,

    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
