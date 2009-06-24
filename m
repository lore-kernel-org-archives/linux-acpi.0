From: Scott Howard <showard314@gmail.com>
Subject: Re: [PATCH] for Bad _BQC behavior on HP laptops
Date: Wed, 24 Jun 2009 10:17:01 -0400
Message-ID: <8555910906240717i503ed3b6rfebd41c339a3a7fa@mail.gmail.com>
References: <alpine.LFD.2.00.0906240046500.32742@localhost.localdomain>
	 <fwc3cqz2svjdtedexkUYAxe124vaj_firegpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:59611 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZFXORD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2009 10:17:03 -0400
Received: by ewy6 with SMTP id 6so1219475ewy.37
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2009 07:17:05 -0700 (PDT)
In-Reply-To: <fwc3cqz2svjdtedexkUYAxe124vaj_firegpg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: phcoder@gmail.com

Thanks all,
The original author is Vladimir Serbinenko, (phcoder) , and he is
cc:ed to this email.
~Scott Howard

On Wed, Jun 24, 2009 at 12:47 AM, Len Brown <lenb@kernel.org> wrote:
>
> nak,
> needs signed-off-by from original author,
> which appears to be here:
>
> =A0http://bugzilla.kernel.org/show_bug.cgi?id=3D13511#c3
>
> thanks,
> Len Brown, Intel Open Source Technology Center

from Zhang Rui <rui.zhang@intel.com>
to Scott Howard <showard314@gmail.com>
cc"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
date Wed, Jun 24, 2009 at 12:01 AM
subject Re: [PATCH] for Bad _BQC behavior on HP laptops
mailed-by intel.com
hide details 12:01 AM (9 hours ago)
Reply
Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
- Hide quoted text -
On Sat, 2009-06-13 at 20:30 +0800, Scott Howard wrote:
> Hello, this is the patch [1] as discussed on kernel bugzilla bug
> #13511 [2]. I'm including the original comments from the patch
> creator.
>
> [1] http://bugzilla.kernel.org/attachment.cgi?id=3D21889
> [2] http://bugzilla.kernel.org/show_bug.cgi?id=3D13511
>
>
>
> Hello. On the following model
> =A0 =A0 Manufacturer: Packard Bell BV
> =A0 =A0 Product Name: EasyNote_BG45-U-001CH
> BQC returns a value between 0 and 15 but the brightness levels are
> between 0 and 8. I could make a table of correspondance however I fin=
d
> it too inflexible. So I propose the following patch which disables BQ=
C
> if it behaves badly
>

On Wed, Jun 24, 2009 at 9:38 AM, Scott Howard <showard314@gmail.com> wr=
ote:
>
> Thanks all,
> The original author is Vladimir Serbinenko, (phcoder) , and he is cc:=
ed to this email.
> ~Scott Howard
>
> On Wed, Jun 24, 2009 at 12:47 AM, Len Brown <lenb@kernel.org> wrote:
>>
>> nak,
>> needs signed-off-by from original author,
>> which appears to be here:
>>
>> =A0http://bugzilla.kernel.org/show_bug.cgi?id=3D13511#c3
>>
>> thanks,
>> Len Brown, Intel Open Source Technology Center
>
> from
> Zhang Rui <rui.zhang@intel.com>
> toScott Howard <showard314@gmail.com>
> cc"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
> dateWed, Jun 24, 2009 at 12:01 AM
> subjectRe: [PATCH] for Bad _BQC behavior on HP laptops
> mailed-byintel.com
> hide details 12:01 AM (9 hours ago)
> Reply
> Acked-by: Zhang Rui <rui.zhang@intel.com>
>
> thanks,
> rui
> - Hide quoted text -
> On Sat, 2009-06-13 at 20:30 +0800, Scott Howard wrote:
> > Hello, this is the patch [1] as discussed on kernel bugzilla bug
> > #13511 [2]. I'm including the original comments from the patch
> > creator.
> >
> > [1] http://bugzilla.kernel.org/attachment.cgi?id=3D21889
> > [2] http://bugzilla.kernel.org/show_bug.cgi?id=3D13511
> >
> >
> >
> > Hello. On the following model
> > =A0 =A0 Manufacturer: Packard Bell BV
> > =A0 =A0 Product Name: EasyNote_BG45-U-001CH
> > BQC returns a value between 0 and 15 but the brightness levels are
> > between 0 and 8. I could make a table of correspondance however I f=
ind
> > it too inflexible. So I propose the following patch which disables =
BQC
> > if it behaves badly
> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
