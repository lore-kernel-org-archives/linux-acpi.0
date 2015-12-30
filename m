From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/3] device property: add spaces to PROPERTY_ENTRY_STRING
 macro
Date: Wed, 30 Dec 2015 03:29:56 +0200
Message-ID: <CAHp75VfqpTKhe2pduZ0ySnkMfCUrgt7XVXNGuVbejC70Vf14ww@mail.gmail.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<4285778.gtB2L18Hsx@vostro.rjw.lan>
	<1451301853.30729.326.camel@linux.intel.com>
	<1627434.AfSeGfofYv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33017 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbL3B35 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2015 20:29:57 -0500
In-Reply-To: <1627434.AfSeGfofYv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Dec 30, 2015 at 3:49 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, December 28, 2015 01:24:13 PM Andy Shevchenko wrote:
>> On Mon, 2015-12-28 at 02:12 +0100, Rafael J. Wysocki wrote:
>> > On Wednesday, December 23, 2015 03:34:42 PM Andy Shevchenko wrote:
>> > > Just a style fix, no functional changes.
>> > >
>> > > To be folded to Andrew's patch.
>> >
>> > What patch?
>>
>> In linux-next from Andrew:
>>
>> e39ece7 include-linux-propertyh-fix-build-issues-with-gcc-444-fix
>> 40bb8a1 include/linux/property.h: fix build issues with gcc-4.4.4
>
> Any pointers to the original patch submission(s)?

Yes, I found one [1] and added to v3 of this patch [2]

[1] http://comments.gmane.org/gmane.linux.kernel.commits.mm/97592
[2] http://www.spinics.net/lists/kernel/msg2151801.html

>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
