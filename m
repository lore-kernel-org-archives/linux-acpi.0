From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [RFC] [PATCH 1/2] introduce ALS sysfs class
Date: Wed, 23 Sep 2009 09:26:07 +0200
Message-ID: <71cd59b00909230026x759bec26v767e40bf2d6b2737@mail.gmail.com>
References: <1253590755.15763.21.camel@rzhang-dt> <4AB8C62F.5020605@cam.ac.uk>
	 <20090923071857.GC8565@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:17439 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbZIWH0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2009 03:26:04 -0400
In-Reply-To: <20090923071857.GC8565@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>

On Wed, Sep 23, 2009 at 9:18 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2009-09-22 13:42:23, Jonathan Cameron wrote:
>> Zhang Rui wrote:
>> > Hi, Jonathan,
>> >
>> > this is the refresh ALS sysfs class driver.
>> > I just introduced one sysfs attribute "illuminance", because
>> > I didn't catch the exact meaning of the others like "???infrared".
>> > So it would be great if you can generate an incremental patch
>> > to introduce the other optional attributes needed, and update
>> > the documentation as well. :)
>> Will do, though may just leave it out of first pass of drivers
>> (as it may be controversial and it would be nice to get something
>> in place before the arguments begin!)
>>
>> All looks nice and clean. The only real question is whether
>> we want to standardize naming of devices under sysfs (like hwmon doe=
s)
>> or allow the individual drivers to do the naming?
>
> Allow the drivers to do the naming. Having useless name like "als0",
> with als0/name telling me what the driver is is bad.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pavel
>

This is how rfkill works, is there a good reason for that ? Should we
change that ?

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
