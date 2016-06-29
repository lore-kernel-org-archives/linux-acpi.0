From: Al Stone <ahs3@redhat.com>
Subject: Re: [RFC DSD 01/03] _DSD Property Registration Ruleset
Date: Wed, 29 Jun 2016 10:21:17 -0600
Message-ID: <5f1a88e2-923d-14d8-b3b4-0b87244a59b7@redhat.com>
References: <63241a35-9b6b-f0ea-8de7-f278b7bdfe8a@redhat.com>
 <5702848a-c97a-503a-eacb-a755f1089262@redhat.com>
 <6720ED6D-9AE9-4D1A-AED1-0741B528F235@intel.com>
 <D39957D0.86D92%charles.garcia-tobin@arm.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37868 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbcF2Q2R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 12:28:17 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so45306849ith.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2016 09:27:20 -0700 (PDT)
In-Reply-To: <D39957D0.86D92%charles.garcia-tobin@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, "Hart, Darren" <darren.hart@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 06/29/2016 03:53 AM, Charles Garcia-Tobin wrote:
> Hi Al
>=20
> Thanks for posting this! One other minor comment is that given sectio=
n 8
> repeats and expands the content of "_DSD Property Database Ruleset"
> section 4, maybe to make life easier, you should strike the latter an=
d put
> a reference in there to this section?

Ah.  Good point.  No sense in duplicating code, so to speak.

> Cheers
>=20
> Charles
>=20
>=20
> On 29/06/2016 00:08, "Hart, Darren" <darren.hart@intel.com> wrote:
>=20
>> Thanks Al,
>>
>> On 6/28/16, 1:07 PM, "Al Stone" <ahs3@redhat.com> wrote:
>>
>> =E2=80=A6
>>
>>> 8. Immutability of Registered Property Set Definitions
>>> ------------------------------------------------------
>>> All property set definitions, once registered and in the database [=
2],
>>> are immutable. It is not possible to remove existing content from t=
he
>>> database or to modify any of it in place.  It only is possible to a=
dd
>>> new content.
>>>
[snip...]

--=20
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
