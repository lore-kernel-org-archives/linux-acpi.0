From: Al Stone <ahs3@redhat.com>
Subject: Re: [RFC DSD 02/03] _DSD Property Database Ruleset
Date: Wed, 29 Jun 2016 10:29:38 -0600
Message-ID: <5a210d88-d3b8-cdaf-f0cf-2609a1c34757@redhat.com>
References: <63241a35-9b6b-f0ea-8de7-f278b7bdfe8a@redhat.com>
 <c87f465e-173f-bdc3-e3c3-847072546ad0@redhat.com>
 <D3993D80.86BE3%charles.garcia-tobin@arm.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35351 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcF2Q3l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 12:29:41 -0400
Received: by mail-io0-f170.google.com with SMTP id f30so50680349ioj.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2016 09:29:40 -0700 (PDT)
In-Reply-To: <D3993D80.86BE3%charles.garcia-tobin@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Hart, Darren" <darren.hart@intel.com>

On 06/29/2016 03:19 AM, Charles Garcia-Tobin wrote:
>=20
> Hi Al
>=20
> Thanks a lot for putting this together. I only had one very minor com=
ment
> below.
>=20
> On 28/06/2016 21:08, "Al Stone" <ahs3@redhat.com> wrote:
>=20
>> _DSD Property Database Ruleset
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> Dated: 2016-06-14
>> Status:        DRAFT
[snip...]

>>
>> Each property in a property set is represented by a file located in =
the
>> revision directory defining it.  The name of that file is the name o=
f
>> the property represented by it.  It contains a list of property
>> attributes in a simple human-readable format, described in detail in
>> [3].

Good idea.  How about changing the sentence above to "...described in
detail, with examples, in [3]"?

>> Property subsets of a given property set are represented by
>> subdirectories of the revision directory defining it.  Their names a=
re
>> the keys identifying those property subsets.  They each contain file=
s
>> representing properties in the given subset following the same
>> formalisms as property attributes, or subdirectories representing
>> further subsets.
>=20
> I think it=E2=80=99d be nice to either insert or make reference here =
to the
> example given in [3] section 2.1
>=20
> Cheers
>=20
> Charles

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
