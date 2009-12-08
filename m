From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCHv2 0/2] Introducing the Ambient Light Sensor (ALS) class
Date: Tue, 8 Dec 2009 16:00:05 +0200
Message-ID: <20091208140005.GA3125@everest.lan>
References: <1259581514-15356-1-git-send-email-amit.kucheria@verdurent.com>
 <37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
 <20091207160432.3108e17b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41312 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202AbZLHOAH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 09:00:07 -0500
Content-Disposition: inline
In-Reply-To: <20091207160432.3108e17b@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, jic23@cam.ac.uk, alan@linux.intel.com, linux-acpi@vger.kernel.org, gregkh@suse.de, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>

On Mon, Dec 7, 2009 at 5:04 PM, Jean Delvare <khali@linux-fr.org> wrote=
:
> On Mon, 7 Dec 2009 16:50:23 +0200, Amit Kucheria wrote:
>> On Mon, Nov 30, 2009 at 1:45 PM, Amit Kucheria
>> <amit.kucheria@verdurent.com> wrote:
>> > Introduce a new class of devices to handle ambient light sensors. =
Currently
>> > only one sysfs inteface, 'illuminance' is introduced. More will be=
 added as
>> > drivers are ported to use this new class.
>> >
>> > Amit Kucheria (1):
>> > =C2=A0als: add unique device-ids to the als device class
>> >
>> > Zhang Rui (1):
>> > =C2=A0introduce ALS sysfs class
>> >
>> > =C2=A0Documentation/ABI/testing/sysfs-class-als | =C2=A0 =C2=A09 +=
+
>> > =C2=A0MAINTAINERS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
6 ++
>> > =C2=A0drivers/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>> > =C2=A0drivers/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> > =C2=A0drivers/als/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 +++
>> > =C2=A0drivers/als/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +
>> > =C2=A0drivers/als/als_sys.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0116 +++++++++++++++++++++++++++=
++
>> > =C2=A0include/linux/als_sys.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 35 +++++++++
>> > =C2=A08 files changed, 184 insertions(+), 0 deletions(-)
>> > =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-class-als
>> > =C2=A0create mode 100644 drivers/als/Kconfig
>> > =C2=A0create mode 100644 drivers/als/Makefile
>> > =C2=A0create mode 100644 drivers/als/als_sys.c
>> > =C2=A0create mode 100644 include/linux/als_sys.h
>> >
>>
>> (Bump)
>>
>> Is there any blocker to adding this for 2.6.33?
>
> As far as I am concerned, it's ready to go. And I would love to see i=
t
> in 2.6.33.
>
>> Which maintainer will pick up the ALS framework?
>
> As Rui volunteered to be the maintainer of this new subsystem, it wou=
ld
> seem fair that he takes care of the initial push as well.

Rui,

Not sure about the LKML netiquette here, but I could track this patchse=
t to
get it merged. Let me know.

Regards,
Amit
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
