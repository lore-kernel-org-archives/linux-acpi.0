From: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
Subject: Re: [RFC DSD 01/03] _DSD Property Registration Ruleset
Date: Wed, 29 Jun 2016 10:53:49 +0100
Message-ID: <D39957D0.86D92%charles.garcia-tobin@arm.com>
References: <63241a35-9b6b-f0ea-8de7-f278b7bdfe8a@redhat.com>
 <5702848a-c97a-503a-eacb-a755f1089262@redhat.com>
 <6720ED6D-9AE9-4D1A-AED1-0741B528F235@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:55709 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbcF2J44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2016 05:56:56 -0400
In-Reply-To: <6720ED6D-9AE9-4D1A-AED1-0741B528F235@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Hart, Darren" <darren.hart@intel.com>, "ahs3@redhat.com" <ahs3@redhat.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Al

Thanks for posting this! One other minor comment is that given section =
8
repeats and expands the content of "_DSD Property Database Ruleset"
section 4, maybe to make life easier, you should strike the latter and =
put
a reference in there to this section?

Cheers

Charles


On 29/06/2016 00:08, "Hart, Darren" <darren.hart@intel.com> wrote:

>Thanks Al,
>
>On 6/28/16, 1:07 PM, "Al Stone" <ahs3@redhat.com> wrote:
>
>=E2=80=A6
>
>>8. Immutability of Registered Property Set Definitions
>>------------------------------------------------------
>>All property set definitions, once registered and in the database [2]=
,
>>are immutable. It is not possible to remove existing content from the
>>database or to modify any of it in place.  It only is possible to add
>>new content.
>>
>>The only way in which one property set can be superseded by another o=
ne
>>is to register a new revision of the property set in question.
>>
>>Moreover, when creating a new revision of a property set, it is inval=
id
>>to redefine property keys (that is, associate them with different dat=
a
>>types or give them different meaning).  New revisions can only add
>>properties to the set or remove them from it.  If one of the properti=
es
>>in the current (most recent) revision of a property set is to be
>>deprecated in the next revision, the correct way to do that is to rem=
ove
>>it from the set entirely and define a new property with a new key as =
a
>>replacement for it.
>>
>>If there are multiple revisions of a property set registered, platfor=
m
>>firmware is required to provide properties from the most recent one.
>>However, for the sake of backwards compatibility with existing Operat=
ing
>>Systems, it may also provide properties that are not present in the m=
ost
>>recent revision of the set, but were present in the previous revision=
s
>>of it.
>>
>>Operating Systems are required to use properties from the most recent
>>revision of a property set they are aware of.  However, if those
>>properties are not provided by platform firmware, the OS may fall bac=
k
>>to using properties from the previous revisions of the property set t=
hat
>>are not present in the most recent one.
>
>The wording =E2=80=9C=E2=80=A6or remove them from it=E2=80=9D is probl=
ematic. In order to ensure
>backward compatibility, we need to ensure that new revisions do not
>remove required properties from previous revisions.
>
>The goal is for an older OS/driver that only knows about revision 1 to
>continue to function with revision 2 by using all the required fields,
>and ignoring the additional fields added by later revisions.
>
>I=E2=80=99d recommend we strike =E2=80=9C or remove them from it=E2=80=
=9D from section 8.
>
>--
>Darren Hart
>Intel Open Source Technology Center
>


IMPORTANT NOTICE: The contents of this email and any attachments are co=
nfidential and may also be privileged. If you are not the intended reci=
pient, please notify the sender immediately and do not disclose the con=
tents to any other person, use it for any purpose, or store or copy the=
 information in any medium. Thank you.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
