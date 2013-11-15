From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: More initial black screen system for removal from DMI table
Date: Fri, 15 Nov 2013 09:31:56 +0800
Message-ID: <5285798C.70506@intel.com>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>			<52818C87.8080606@intel.com>		 <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>		 <5282DEEE.1040804@intel.com> <1384429833.4103.23.camel@oberon.sagui.org>	 <52856DFE.3000003@intel.com> <1384478234.9557.1.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48700 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928Ab3KOBbM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Nov 2013 20:31:12 -0500
In-Reply-To: <1384478234.9557.1.camel@oberon.sagui.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Cc: Alex Hung <alex.hung@canonical.com>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 11/15/2013 09:17 AM, Gustavo Maciel Dias Vieira wrote:
> Em Sex, 2013-11-15 =C3=A0s 08:42 +0800, Aaron Lu escreveu:
>>>> Can you please test this? I've prepared a branch for you:
>>>> https://github.com/aaronlu/linux acpi_video_dmi
>>>> It is based on Rafael's linux-next branch, with only one patch
>>>> on top: remove all the above systems from the DMI table.
>=20
> Tested and it works perfectly, no brightness regressions observed.

Thanks a lot for the test and info, I'll add your tested-by tag for tha=
t
patch if you don't mind.

-Aaron

>=20
>>>
>>> For completeness my instance of the bug was (wrongly) tracked here:
>>> https://bugs.freedesktop.org/show_bug.cgi?id=3D43577
>>
>> Thanks for the info. Unfortunately, there isn't acpidump either.
>> Please attach the dump there when you have time, thanks.
>=20
> Done
>=20
> Abra=C3=A7os,
> Gustavo
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
