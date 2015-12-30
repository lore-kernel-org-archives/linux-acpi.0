From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/3] device property: add spaces to PROPERTY_ENTRY_STRING
 macro
Date: Wed, 30 Dec 2015 03:43:53 +0200
Message-ID: <CAHp75VdxkEe1x2DO4EN=v3-VJDHcp2NSNLGUZx5PGuz2=np5ew@mail.gmail.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1627434.AfSeGfofYv@vostro.rjw.lan>
	<20151229172453.b8bf71ef.akpm@linux-foundation.org>
	<1850926.j60LlceTNY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1850926.j60LlceTNY@vostro.rjw.lan>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 30, 2015 at 4:06 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, December 29, 2015 05:24:53 PM Andrew Morton wrote:
>> On Wed, 30 Dec 2015 02:49:26 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>
>> > On Monday, December 28, 2015 01:24:13 PM Andy Shevchenko wrote:
>> > > On Mon, 2015-12-28 at 02:12 +0100, Rafael J. Wysocki wrote:
>> > > > On Wednesday, December 23, 2015 03:34:42 PM Andy Shevchenko wrote:
>> > > > > Just a style fix, no functional changes.
>> > > > >
>> > > > > To be folded to Andrew's patch.
>> > > >
>> > > > What patch?
>> > >
>> > > In linux-next from Andrew:
>> > >
>> > > e39ece7 include-linux-propertyh-fix-build-issues-with-gcc-444-fix
>> > > 40bb8a1 include/linux/property.h: fix build issues with gcc-4.4.4
>> >
>> > Any pointers to the original patch submission(s)?
>>
>> I think it was discussed in some followup to something else, I forget.
>>
>> This:
>>
>> From: Andrew Morton <akpm@linux-foundation.org>
>> Subject: include/linux/property.h: fix build issues with gcc-4.4.4
>
> OK, thanks!
>
> I'll apply it to my tree if you don't mind with the Andy's [1/3] on top
> so we have all of that in one place.

Be aware that there are actually _two_ patches from Andrew and _one_
from me to be all folded together.
I think there is no need to have 3 of them.

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
