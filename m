From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Sun, 23 Jan 2011 08:14:57 +0800
Message-ID: <AANLkTikstr=vY=1S7A4Pudg3u=k4eJ7HRz6tWwAq4N-v@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
	<201101221025.49327.rjw@sisk.pl>
	<AANLkTi=MDyaPj9D+28NWRRK13qhJfKw098xPPhwrGZoa@mail.gmail.com>
	<201101222012.14028.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41816 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab1AWAO6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jan 2011 19:14:58 -0500
In-Reply-To: <201101222012.14028.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Sun, Jan 23, 2011 at 3:12 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, January 22, 2011, Jeff Chua wrote:
>> 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Saturday, January 22, 2011, Jeff Chua wrote:
>>
>> > means that my patch [11/11] _and_ the replacement are totally wron=
g, because you have
>> > _multiple_ NVS regions. =A0That really helped, thanks a lot.
>>
>> Would it be different if I offline all CPUs before suspending to ram=
?
>> It seems to help with suspending to disk.
>
> No, that doesn't matter. =A0NVS regions are just sitting there regard=
less of
> what happens at run time.

Strange. If I didn't offline, it hanged during suspend even without
thinkpad_acpi. I could see that the suspend code does the offline
automatically, but executing the offline before calling suspend makes
it no hanging.

Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
