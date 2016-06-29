From: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
Subject: Re: [RFC DSD 02/03] _DSD Property Database Ruleset
Date: Wed, 29 Jun 2016 18:29:49 +0100
Message-ID: <D399C40A.86FC6%charles.garcia-tobin@arm.com>
References: <63241a35-9b6b-f0ea-8de7-f278b7bdfe8a@redhat.com>
 <c87f465e-173f-bdc3-e3c3-847072546ad0@redhat.com>
 <D3993D80.86BE3%charles.garcia-tobin@arm.com>
 <5a210d88-d3b8-cdaf-f0cf-2609a1c34757@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:32658 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbcF2RcD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2016 13:32:03 -0400
In-Reply-To: <5a210d88-d3b8-cdaf-f0cf-2609a1c34757@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "ahs3@redhat.com" <ahs3@redhat.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Hart, Darren" <darren.hart@intel.com>



On 29/06/2016 17:29, "Al Stone" <ahs3@redhat.com> wrote:

>On 06/29/2016 03:19 AM, Charles Garcia-Tobin wrote:
>>
>> Hi Al
>>
>> Thanks a lot for putting this together. I only had one very minor
>>comment
>> below.
>>
>> On 28/06/2016 21:08, "Al Stone" <ahs3@redhat.com> wrote:
>>
>>> _DSD Property Database Ruleset
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> Dated: 2016-06-14
>>> Status:        DRAFT
>[snip...]
>
>>>
>>> Each property in a property set is represented by a file located in=
 the
>>> revision directory defining it.  The name of that file is the name =
of
>>> the property represented by it.  It contains a list of property
>>> attributes in a simple human-readable format, described in detail i=
n
>>> [3].
>
>Good idea.  How about changing the sentence above to "...described in
>detail, with examples, in [3]"?

Works for me.

Cheers

Charles

>
>>> Property subsets of a given property set are represented by
>>> subdirectories of the revision directory defining it.  Their names =
are
>>> the keys identifying those property subsets.  They each contain fil=
es
>>> representing properties in the given subset following the same
>>> formalisms as property attributes, or subdirectories representing
>>> further subsets.
>>
>> I think it=E2=80=99d be nice to either insert or make reference here=
 to the
>> example given in [3] section 2.1
>>
>> Cheers
>>
>> Charles
>
>--
>ciao,
>al
>-----------------------------------
>Al Stone
>Software Engineer
>Red Hat, Inc.
>ahs3@redhat.com
>-----------------------------------
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
