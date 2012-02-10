From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Fix logic for removing mappings in 'acpi_unmap'
Date: Thu, 9 Feb 2012 18:19:03 -0800
Message-ID: <CAErSpo6L54td2SVm7LR_aSfseiRL4kOnf0ObnuO0QquYzAj+iQ@mail.gmail.com>
References: <20120209163641.26858.59399.stgit@amt.stowe> <CAErSpo47+kHmS6477Bne84rPiy+sHGjgtK3mpk6VJc+hM4hhbg@mail.gmail.com>
 <1328832518.2404.86.camel@zim.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34375 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab2BJCTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2012 21:19:25 -0500
Received: by wgbdt10 with SMTP id dt10so2305529wgb.1
        for <linux-acpi@vger.kernel.org>; Thu, 09 Feb 2012 18:19:24 -0800 (PST)
In-Reply-To: <1328832518.2404.86.camel@zim.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <mstowe@redhat.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com, tony.luck@intel.com, trenn@suse.de, linux-kernel@vger.kernel.org, mingo@elte.hu

On Thu, Feb 9, 2012 at 4:08 PM, Myron Stowe <mstowe@redhat.com> wrote:
> On Thu, 2012-02-09 at 08:42 -0800, Bjorn Helgaas wrote:
>> On Thu, Feb 9, 2012 at 8:36 AM, Myron Stowe <myron.stowe@redhat.com>=
 wrote:
>> > From: Myron Stowe <mstowe@redhat.com>
>> >
>> > Make sure the removal of mappings uses the same logic that put the
>> > mappings in place.
>> >
>> > Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
>> > ---
>> >
>> > =A0drivers/acpi/osl.c | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> > index 412a1e0..5aef087 100644
>> > --- a/drivers/acpi/osl.c
>> > +++ b/drivers/acpi/osl.c
>> > @@ -347,7 +347,7 @@ static void acpi_unmap(acpi_physical_address p=
g_off, void __iomem *vaddr)
>> > =A0 =A0 =A0 =A0unsigned long pfn;
>> >
>> > =A0 =A0 =A0 =A0pfn =3D pg_off >> PAGE_SHIFT;
>> > - =A0 =A0 =A0 if (page_is_ram(pfn))
>> > + =A0 =A0 =A0 if (should_use_kmap(pfn))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kunmap(pfn_to_page(pfn));
>> > =A0 =A0 =A0 =A0else
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(vaddr);
>> >
>>
>> Whatever happened to the question of why we have arch-specific
>> ioremap() behavior? =A0It's good to make map/unmap symmetric, but it=
'd
>> be better to get rid of the ioremap/kmap hack.
>
> +cc ingo
>
> We never received any explanation for why ioremap() failed for Ying w=
ith
> RAM on x86. =A0Last I saw Ying asked Ingo for some input here but the=
re
> was never any reply -
> http://marc.info/?l=3Dlinux-acpi&m=3D132788392604738&w=3D2
>
> I like your idea of possibly changing ioremap's implementation so tha=
t
> it would handle requests related to RAM - by using kmap() internally
> when necessary - so that a *user* wouldn't need to care what
> architecture we're on. =A0I, however, feel like I don't have enough
> experience with the memory management subsystem to know if such a tac=
tic
> would fly or not so was uncomfortable proceeding along those lines. =A0=
As
> a result, I just wanted to get this in for the meantime.

I dunno if you're comfortable with it, but you can always propose a
patch doing it how you think it should be done.  People are more apt
to respond to a concrete patch than to an abstract question about why
things are the way they are.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
