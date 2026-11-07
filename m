Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054354;
	b=AoAaylXrV09h06E6/jcuCRD5R0lii0tt+RUkynNUMZfM8mwrQQrpbnpZbCRjqTVKMVjT
	 v+02BTuXmalnU78Nn4g2fOUJ4so3cHj0EiT4SH/CWeaHVQmU1pWkDxV6omUNTXHOwgmqs
	 cxDtjLlKObUTGgWbGS8RhYWMEQf07fYR4NMsArsS3cssy4br8Nhdp8BRgtGvl4ioOtoin
	 /QSIY0RjEyx8yEzE7v4yI8wcLFbRTfwy+u6fcp0qPa8az/l1xMhENlyms/+JlIpSM4IFg
	 nzHX4vQpLLPfHldmW1S8cVoEq1vfE2zqvHfqNX02Arc0aaIp9GMDv3JmIqjp8cDobvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054354;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nMZivJOM2oM45m9Nztv0AW9BCNHvPrOKaR0tdk/NVrk=;
	b=OO7+Xq4gBX9xiDqTCp0AcwSfjyjT7lcioHyjF7v+ClpAkK2gEMPir3LAl0d+3VfbC33c
	 n9MmqPD9ti5p2AkRWEJvjBilaDOnASH4K5ePlrKAFoUTgrzpQ92do5kvCLYJb4lXoVKKb
	 JaixGhb+CzKX48uY2moDQzinmlPsUiY49xTZlAlummJ4QgkE35EJc4g7h6hGzMeMgeWEy
	 P/AB1u05z1JM/Td5Chf1spbNse/mn/QQQlCrmMeTZdc8vsgLx7x99/IjK9GhvlDRYYFko
	 vki7h6R+ILXx7UjTLwRQ88Rkr5QMdpBVAQkGKhGdnEfpween2TSE3lwPX8rY1dF7POg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WumXMJ5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29848606A326
	for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WumXMJ5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E61F008A2
	for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2026 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054354;
	bh=nMZivJOM2oM45m9Nztv0AW9BCNHvPrOKaR0tdk/NVrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WumXMJ5qltMqk65sOnjxbsv6rOOuGJ9zPL2Io2hJ6robyxoxR7182pZGf7Wm4mxfl
	 PPGVtexG0IIu9PXo7i4UjqqxYrp8FeekNF2rnPHKxH1t07e/+Ufb+UU0W6Yg22BiNm
	 6Z4qABRqb7Lv9OInLANGS15JsluikM5tpvBDPy1ixkAhHO/fdy2zvWVHc4MG3VonDQ
	 Usk/YOSnaO4TgK2cKFoONRt+AVFUVRCmP9YDJPtMHHCLEn7O7hTt456AoJBnTQpMfa
	 SR9cBOmp+w4W/ha8mI41vM+/m3g0n0PqpMwHdwSSshtbPmdcJRpe90rntVsp+y9jm4
	 EVGQ9GrCPCUfg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so135499a12.2
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2026 04:25:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGOs/ovIaTuVhBYBucbG05I/l8H6dXsFtMIw0alaYcg5DEp/RpPYeCZzcEJzkQBUCcww+nSi1jO6bLM@vger.kernel.org
X-Gm-Message-State: APuU4Z9DZTnlyOzI4t+9cjBclZm2SFIHGaBc3jvGrU+8wYevCoXuXtej
	b6iUfDxlxjeRRIFVSlQxMmTkvgNl6ZQxImpKAGY4t0wWkQifDJO8dOXbQwL07aXqjRY8/nJu42w
	o7M89u+P8oFv60w5Bc0koc3Rujo6sE70=
X-Received: by 2002:a05:6402:2804:b0:6b6:eefc:ae7a with SMTP id
 4fb4d7f45d1cf-6b6eefcb1e3mr2504856a12.4.1794054352574; Sat, 07 Nov 2026
 04:25:52 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
 <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn> <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
 <66b9d482-d577-748c-729d-0fba70701d3d@loongson.cn> <CAAhV-H6PL6RLM3KA4BLQEt804FnsDE4CtKeB0KaW7Gj8rm2PMw@mail.gmail.com>
 <843a9418-2017-c2c6-45c5-38628e7e0bdb@loongson.cn> <CAAhV-H4O07hKyPJ8rTMo=vD=t+qFM7UAJOPDGZDVJ0Ti-gOdEQ@mail.gmail.com>
 <e04352c2-f4ce-d415-72d4-21e03b828843@loongson.cn>
In-Reply-To: <e04352c2-f4ce-d415-72d4-21e03b828843@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 7 Nov 2026 20:25:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7phy=T1MMNpSnZdjjiQXH41S7jnFcgfZd_4b5aqffB6g@mail.gmail.com>
X-Gm-Features: AclHuK_Qu3xOXcYgx1roXJhondQU01JPqY5k6JB0ia-i-ADZ4-jS10PfrK6FB8w
Message-ID: <CAAhV-H7phy=T1MMNpSnZdjjiQXH41S7jnFcgfZd_4b5aqffB6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Bibo Mao <maobibo@loongson.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:43=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/11/6 =E4=B8=8B=E5=8D=8810:58, Huacai Chen wrote:
> > On Thu, Nov 5, 2026 at 7:22=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/11/5 =E4=B8=8B=E5=8D=886:31, Huacai Chen wrote:
> >>> On Thu, Nov 5, 2026 at 5:49=E2=80=AFPM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/11/5 =E4=B8=8B=E5=8D=885:31, Huacai Chen wrote:
> >>>>> On Thu, Nov 5, 2026 at 5:14=E2=80=AFPM Bibo Mao <maobibo@loongson.c=
n> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2026/10/23 =E4=B8=8B=E5=8D=883:59, Huacai Chen wrote:
> >>>>>>> Bibo,
> >>>>>>>
> >>>>>>> Now I have applied this series but with some modifications, pleas=
e
> >>>>>>> double check and test the code.
> >>>>>>>
> >>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-=
loongson.git/log/?h=3Dloongarch-next
> >>>>>> In my v4 submit, it is:
> >>>>>> +               case ACPI_IOVT_DEVICE_ENTRY_START:
> >>>>>> +                       is_start =3D true;
> >>>>>> +                       start_devid =3D ep->device_id;
> >>>>>> +                       break;
> >>>>>> however in rc1, it is modified as:
> >>>>>>                     case ACPI_IOVT_DEVICE_ENTRY_START:
> >>>>>>                             is_start =3D true;
> >>>>>>                             entry->start_devid =3D ep->device_id;
> >>>>>>                             break;
> >>>>>> Here entry is not allocated and NULL pointer, it is allocated in
> >>>>>> ACPI_IOVT_DEVICE_ENTRY_END switch case.
> >>>>>>
> >>>>>> I really do not know what is aid to modify it and let others to te=
st.
> >>>>> Sorry, it's my fault.
> >>>>>
> >>>>> In theory I should point out the modification (eliminating the loca=
l
> >>>>> variable start_devid) and refresh a new version. But we have no tim=
e
> >>>>> to do this because when the first patch is merged into the ACPI rep=
o
> >>>>> it is near the merge window.
> >>>> Maybe our work style is different, I do not care much for the coding=
 style.
> >>>>>
> >>>>> If you agree, I will submit such modifications to fix it.
> >>>> fix is welcome.
> >>>>>
> >>>>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch=
/iovt.c
> >>>>> index 87cee4f0fc80..4cdac28a1fd0 100644
> >>>>> --- a/drivers/acpi/loongarch/iovt.c
> >>>>> +++ b/drivers/acpi/loongarch/iovt.c
> >>>>> @@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
> >>>>> acpi_iovt_iommu *iommu)
> >>>>>            for (i =3D 0; i < iommu->device_entry_num; i++) {
> >>>>>                    switch (ep->type) {
> >>>>>                    case ACPI_IOVT_DEVICE_ENTRY_START:
> >>>>> +                       entry =3D kzalloc_obj(struct iovt_device_en=
try,
> >>>>> GFP_ATOMIC);
> >>>> There will be memory leak problem if there are START/START/END in th=
e table.
> >>> That means a broken table? I think we don't need to consider broken
> >>> tables, because there may be kinds of broken pattern rather than just
> >>> a START/START/END.
> >> yes, START/END/START, START/START/END, START/SINGLE/END. what is the
> >> relationship between "don't need to consider" and kinds of broken patt=
ern?
> >>
> >> what is the policy from your side with such BIOS table? let memory lea=
k
> >> and continue?
> > The driver can only work with a good table or no table, but not with a
> > broken table.
> With a broken table, software can discard the whole table, or discard
> the single table entry.
Discard a single entry is dangerous because the pairing may be wrong,
so if we should handle a broken table, we should discard the whole
table.

Discarding the whole table need a rework, the is_start variable is not
enough. You can consider the below solution:

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 87cee4f0fc80..8381de278e3a 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -73,10 +73,44 @@ static int __init iovt_get_pci_iommu_fwnode(struct
iovt_fwnode *np, u16 segment,
        return 0;
 }

+static int __init iovt_validate_entries(struct acpi_iovt_iommu *iommu)
+{
+       int i, done =3D 1;
+       struct acpi_iovt_device_entry *ep;
+
+       ep =3D ACPI_ADD_PTR(struct acpi_iovt_device_entry, iommu,
iommu->device_entry_offset);
+       for (i =3D 0; i < iommu->device_entry_num; i++) {
+               switch (ep->type) {
+               case ACPI_IOVT_DEVICE_ENTRY_START:
+                       if (!done)
+                               return -EINVAL;
+
+                       done =3D 0;
+                       break;
+               case ACPI_IOVT_DEVICE_ENTRY_END:
+                       if (done)
+                               return -EINVAL;
+
+                       done =3D 1;
+                       break;
+               case ACPI_IOVT_DEVICE_ENTRY_SINGLE:
+                       if (!done)
+                               return -EINVAL;
+
+                       done =3D 1;
+                       break;
+               default:
+                       return -EINVAL;
+               }
+               ep =3D ACPI_ADD_PTR(struct acpi_iovt_device_entry, ep,
ep->length);
+       }
+
+       return done ? 0 : -EINVAL;
+}
+
 static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
 {
        int i, ret;
-       bool is_start =3D false;
        struct iovt_fwnode *np;
        struct iovt_device_entry *entry;
        struct acpi_iovt_device_entry *ep;
@@ -110,23 +144,22 @@ static int __init iovt_add_iommu(struct
acpi_iovt_iommu *iommu)
        if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
                goto skip;

+       if (iovt_validate_entries(iommu) < 0)
+               return -EINVAL;
+
        INIT_LIST_HEAD(&np->ep_list);
        ep =3D ACPI_ADD_PTR(struct acpi_iovt_device_entry, iommu,
iommu->device_entry_offset);
        for (i =3D 0; i < iommu->device_entry_num; i++) {
                switch (ep->type) {
                case ACPI_IOVT_DEVICE_ENTRY_START:
-                       is_start =3D true;
-                       entry->start_devid =3D ep->device_id;
-                       break;
-               case ACPI_IOVT_DEVICE_ENTRY_END:
-                       if (!is_start)
-                               break;
-
                        entry =3D kzalloc_obj(struct iovt_device_entry,
GFP_ATOMIC);
                        if (!entry)
                                return -ENOMEM;

-                       is_start =3D false;
+                       entry->start_devid =3D ep->device_id;
+                       break;
+               case ACPI_IOVT_DEVICE_ENTRY_END:
+                       /* START & END are paired */
                        entry->end_devid =3D ep->device_id;
                        list_add_tail(&entry->list, &np->ep_list);
                        break;
@@ -135,13 +168,12 @@ static int __init iovt_add_iommu(struct
acpi_iovt_iommu *iommu)
                        if (!entry)
                                return -ENOMEM;

-                       is_start =3D false;
                        entry->start_devid =3D ep->device_id;
                        entry->end_devid =3D ep->device_id;
                        list_add_tail(&entry->list, &np->ep_list);
                        break;
                default:
-                       break;
+                       return -EINVAL;
                }
                ep =3D ACPI_ADD_PTR(struct acpi_iovt_device_entry, ep,
ep->length);
        }

> >
> > Take START1/START2/END as an example of broken table: in your original
> > code, the END entry will be pairing with START2. But for a broken
> > table who can ensure they are the correct pair? If the real correct
> > pair is START1 and END, then (entry->start_devid, entry->end_devid)
> there is only one policy, software does not know START1/END is right or
> START2/END is right.
> > will be a wrong device range. Such mistakes are much worse than a
> > memery leak.
> >
> > If you want to say "I don't care about correct pairing, memory leak is
> > bad in any case.", OK, we can do it like this:
> >
> > diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iov=
t.c
> > index 87cee4f0fc80..ebd11e22c9be 100644
> > --- a/drivers/acpi/loongarch/iovt.c
> > +++ b/drivers/acpi/loongarch/iovt.c
> > @@ -115,6 +115,13 @@ static int __init iovt_add_iommu(struct
> > acpi_iovt_iommu *iommu)
> >          for (i =3D 0; i < iommu->device_entry_num; i++) {
> >                  switch (ep->type) {
> >                  case ACPI_IOVT_DEVICE_ENTRY_START:
> > +                       if (is_start)
> > +                               break;
> there is still memory leak with START/SINGLE/END pairs, is_start set
> with false with ACPI_IOVT_DEVICE_ENTRY_SINGLE case.
>
> Regards
> Bibo Mao
> > +
> > +                       entry =3D kzalloc_obj(struct iovt_device_entry,
> > GFP_ATOMIC);
> > +                       if (!entry)
> > +                               return -ENOMEM;
> > +
> >                          is_start =3D true;
> >                          entry->start_devid =3D ep->device_id;
> >                          break;
> > @@ -122,10 +129,6 @@ static int __init iovt_add_iommu(struct
> > acpi_iovt_iommu *iommu)
> >                          if (!is_start)
> >                                  break;
> >
> > -                       entry =3D kzalloc_obj(struct iovt_device_entry,
> > GFP_ATOMIC);
> > -                       if (!entry)
> > -                               return -ENOMEM;
> > -
> >                          is_start =3D false;
> >                          entry->end_devid =3D ep->device_id;
> >                          list_add_tail(&entry->list, &np->ep_list);
> >
> > Huacai
> >
> >>
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>> +                       if (!entry)
> >>>>> +                               return -ENOMEM;
> >>>>> +
> >>>>>                            is_start =3D true;
> >>>>>                            entry->start_devid =3D ep->device_id;
> >>>>>                            break;
> >>>>> @@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
> >>>>> acpi_iovt_iommu *iommu)
> >>>>>                            if (!is_start)
> >>>>>                                    break;
> >>>>>
> >>>>> -                       entry =3D kzalloc_obj(struct iovt_device_en=
try,
> >>>>> GFP_ATOMIC);
> >>>>> -                       if (!entry)
> >>>>> -                               return -ENOMEM;
> >>>>> -
> >>>>>                            is_start =3D false;
> >>>>>                            entry->end_devid =3D ep->device_id;
> >>>>>                            list_add_tail(&entry->list, &np->ep_list=
);
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>> On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongso=
n.cn> wrote:
> >>>>>>>>
> >>>>>>>> This change is already merged in acpica tree.
> >>>>>>>>
> >>>>>>>> slightly ping.
> >>>>>>>>
> >>>>>>>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
> >>>>>>>>      > According to the IOVT specification, define macros for ea=
ch bit of the
> >>>>>>>>      > Flags field in the IOVT IOMMU structure.
> >>>>>>>>      >
> >>>>>>>>      > Link: https://github.com/open-acpica/acpica/commit/352f75=
0e4cc0
> >>>>>>>>      > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>>      > ---
> >>>>>>>>      >  include/acpi/actbl2.h | 7 +++++++
> >>>>>>>>      >  1 file changed, 7 insertions(+)
> >>>>>>>>      >
> >>>>>>>>      > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.=
h
> >>>>>>>>      > index baef525367b5..76e4a5bc79b4 100644
> >>>>>>>>      > --- a/include/acpi/actbl2.h
> >>>>>>>>      > +++ b/include/acpi/actbl2.h
> >>>>>>>>      > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
> >>>>>>>>      >       u32 device_entry_offset;
> >>>>>>>>      >  };
> >>>>>>>>      >
> >>>>>>>>      > +/* Masks for Flags field above */
> >>>>>>>>      > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
> >>>>>>>>      > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
> >>>>>>>>      > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
> >>>>>>>>      > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<=
<3)
> >>>>>>>>      > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<=
<4)
> >>>>>>>>      > +
> >>>>>>>>      >  struct acpi_iovt_device_entry {
> >>>>>>>>      >       u8 type;
> >>>>>>>>      >       u8 length;
> >>>>>>>>      > --
> >>>>>>>>      > 2.39.3
> >>>>>>>>      >
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>
> >>
>
