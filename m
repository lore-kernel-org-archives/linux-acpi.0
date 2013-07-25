From: James Hogan <james@albanarts.com>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Thu, 25 Jul 2013 20:14:08 +0100
Message-ID: <CAAG0J98i-XaO_3sPWsnyEGDX77T=WiNf1K=YMhe5DvkwKotorw@mail.gmail.com>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
	<CA+55aFyrMRDD8qe9DYXixaSLJXEURMYYku1azABA72m71_X+cA@mail.gmail.com>
	<9012759.Alzqtdvh5b@vostro.rjw.lan>
	<2218913.HKGjJcYT1G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57077 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab3GYTOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2013 15:14:08 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so2363162obc.23
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jul 2013 12:14:08 -0700 (PDT)
In-Reply-To: <2218913.HKGjJcYT1G@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kamal Mostafa <kamal@canonical.com>, Aaron Lu <aaron.lu@intel.com>, Kalle Valo <kvalo@adurom.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Newbury <steve@snewbury.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?ISO-8859-1?Q?J=F6rg_Otte?= <jrg.otte@gmail.com>, Martin Steigerwald <Martin@lichtvoll.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>

On 25 July 2013 14:00, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, July 22, 2013 09:54:21 PM Rafael J. Wysocki wrote:
>> On Monday, July 22, 2013 11:11:54 AM Linus Torvalds wrote:
>> > On Mon, Jul 22, 2013 at 6:02 AM, Rafael J. Wysocki <rjw@sisk.pl> w=
rote:
>> > >
>> > > Linus, do you want me to send a pull request reverting 8c5bd7a a=
nd efaa14c?
>> >
>> > Yes, but let's wait a while. Not because I think we'll fix the pro=
blem
>> > (hey, miracles might happen), but because I think it would be usef=
ul
>> > to couple the reverts with information about the particular machin=
es
>> > that broke (and the people who reported it). So that when we
>> > inevitably try again, we can perhaps get some testing effort with
>> > those machines/people.
>> >
>> > It doesn't seem to be a show-stopped for a large number of people,=
 so
>> > there's no huge hurry. I'd suggest doing the revert just in time f=
or
>> > rc3, but waiting until then to gather info about people who see
>> > breakage.
>> >
>> > Sound like a plan?
>>
>> Yes, it does.
>
> OK, time to revert I guess.
>
> James, Kamal, Steven, J=F6rg, Martin, Kalle, please check if the appp=
ended patch
> fixes the backlight for you.

Works for me

Cheers
James
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
