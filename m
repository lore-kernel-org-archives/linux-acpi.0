From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] ACPI, APEI: Add RAM mapping support to ACPI
Date: Sun, 29 Jan 2012 13:41:53 -0700
Message-ID: <CAErSpo5hrWz81SSS7Tg0HmTZ2seg76pa8kAe4iauAoqL6YAoOw@mail.gmail.com>
References: <20120121021318.14723.45698.stgit@amt.stowe> <20120121021330.14723.72537.stgit@amt.stowe>
 <CAErSpo5KDxkcMn3OrvujeSHhzF7PjG0hsYqMXe1HmpPJaLHvDg@mail.gmail.com> <1327798687.7922.44.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61774 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2A2UmO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jan 2012 15:42:14 -0500
Received: by werb13 with SMTP id b13so2901268wer.19
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jan 2012 12:42:13 -0800 (PST)
In-Reply-To: <1327798687.7922.44.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, trenn@suse.de, linux-kernel@vger.kernel.org

On Sat, Jan 28, 2012 at 5:58 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> Hi, Bjorn,
>
> Sorry for late. =A0Just return from Chinese new year holiday.
>
> On Sat, 2012-01-21 at 08:04 -0700, Bjorn Helgaas wrote:
> [snip]
>> > +
>> > +static void __iomem *acpi_map(acpi_physical_address pg_off, unsig=
ned long pg_sz)
>> > +{
>> > + =A0 =A0 =A0 unsigned long pfn;
>> > +
>> > + =A0 =A0 =A0 pfn =3D pg_off >> PAGE_SHIFT;
>> > + =A0 =A0 =A0 if (should_use_kmap(pfn)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pg_sz > PAGE_SIZE)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (void __iomem __force *)kmap(=
pfn_to_page(pfn));
>> > + =A0 =A0 =A0 } else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acpi_os_ioremap(pg_off, pg_sz=
);
>>
>> This implies that ioremap() works differently on ia64 than on x86.
>> Apparently one can ioremap() RAM on x86, but not on ia64. =A0Why is =
this
>> different? =A0Shouldn't we instead fix ioremap() on ia64 so it works=
 the
>> same as on x86?
>
> If my understanding were correct, ioremap can not work for RAM on x86=
=2E
> So we need to use kmap for RAM. =A0And on IA64, ioremap works for RAM=
 and
> will take care of cache attributes while kmap will not. =A0So ioremap=
 is
> used on IA64, while kmap is used on x86.

My point is that the *user* of ioremap() shouldn't need to care what
architecture we're on.  For example, maybe the ioremap()
implementation could be changed so that it uses kmap() internally when
necessary.

>> I looked at the ia64 ioremap(), and I can't see the reason it fails
>> for RAM. =A0Huang, do you remember the details from 76da3fb3575?

This question is still open.  Do you remember anything about it?

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
