Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871104;
	b=uGz1L6lJ29M9M9Jgyxiq2BgljW9hz/ufSuBHR84Y+HLYRGyVkbcLGM1Spy6p3AugoVKT
	 Z3SbotW4L/ZInWFXdJ0Kx4iitPFVnqp+sKX5Zvkxj3Iac2joC8i7g0gT5Tvk3pfX0MMlV
	 dZlA53s6QD1PtpwMLooX+FGdvoxgPHaBpsnqT6W+9TBkDj3VrwjqNG/l+U3wIGcD1a6x1
	 Ek8TX01ynIoty5OKpMn+FebbT26OfRlHPEADbWnrAPvFpIBF99G6veUzliyrfoNX/aiMa
	 It4WYEisZCo72vqLHEBByKbMJi1bpCNEvZpOe7BdoRPGTIgSs7VJKiqNxOWK3o1rHHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871104;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LmW2Avgge5dW3mynPaSLJTuEcXaTCUJsUMnfQ2sD4Fs=;
	b=ZXnvTYGgSPVEslSNDfuJ6N0CX7CmwmMLYsfMjx+Q5VWg3Ou9ez3X/R6Gx7vblHy1tljY
	 XDlxXemxyHMzRb7Y3r1vtjC7f8OTBopPspvAWOoDi4MmkR/y1+TA1s0TsBLeiql2NIe8M
	 BJTbKlDPDDU4Oi1nRBgkw8iF+Ki+nDKKbZQa3YYcHxh5MfgJ/PsUUdRnGDT0i57KmUFuI
	 rOfUX29GmoUNTDwU2obhWHgenL9ZarbHEVKNMZhZKX3I0XDy6pKZG9XMX0a2ILie8+zqK
	 Ksz6Ofl4uMwnO4fXBhyOu/2qPvZHoTNxm79QjsldvdgL3XG2+FB4jwDbflVCIFVvEgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cj3rJx1D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87388606A32D
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cj3rJx1D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653F91F00A02
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871104;
	bh=LmW2Avgge5dW3mynPaSLJTuEcXaTCUJsUMnfQ2sD4Fs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cj3rJx1DN4cvulEPJ1/tI+fZX1gkg/fkI3akwcM16MborKDolt3swzwaMRGf4VVDG
	 k8LTPWFxPQ0o/l6+OtgRGQu7wcehcEFAeXg6gHmbjuKnHK0biJp5C6XsRdUrkCeQNv
	 MisDKpL5rXztjKOnuk7fYSdpkVC5a0/rkwzkl9Ab3KnhUATbtg4mV8nHBK+Q2GqknG
	 WiNbjHtpIZFUO5rWcDv09AtwMbP/6Km+dOGv4k1FMOapT+47mSIWWc50lX+JSzQpKx
	 NMzzgqIwCbCiuoMzdzzFeoGrm4GmaRue6fxTVA7BukuWeNt5IQQAsPwrGycfxo1y5R
	 zsK98E3VGO/0Q==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c445c95d553so236633866b.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 01:31:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzsgIOmboaT3JrJGfT4bqlQNhiYPoctG/CSMq6ndGGsHfMiYGJyC2eixJsOSUwsvUSkVTPApVT6z/7V@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q6R7emxC/VLZeE4DoGiuC9jh3pZHlWFfiPO3sZlYdKAWrIuvK
	eM7oOYBuYw4VWdSnei/ifFPnyHvih5cudk9MIYph9+9GpH554BDmCipw2GkZ5Gf03HJX+9mGp55
	lUlBmd7+PONPHtJbjZy4rQ9mdQhAnNHM=
X-Received: by 2002:a17:906:7952:b0:c2e:40a0:7978 with SMTP id
 a640c23a62f3a-c4ca7a54f88mr1637592766b.9.1793871102751; Thu, 05 Nov 2026
 01:31:42 -0800 (PST)
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
 <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com> <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn>
In-Reply-To: <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 5 Nov 2026 17:31:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
X-Gm-Features: AclHuK-SAjBSNynGb1GuZvHWDP0DHlgPoiTrsrq0gnaLD9FLXKd3lXkK8ktcviM
Message-ID: <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Bibo Mao <maobibo@loongson.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:14=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/10/23 =E4=B8=8B=E5=8D=883:59, Huacai Chen wrote:
> > Bibo,
> >
> > Now I have applied this series but with some modifications, please
> > double check and test the code.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/log/?h=3Dloongarch-next
> In my v4 submit, it is:
> +               case ACPI_IOVT_DEVICE_ENTRY_START:
> +                       is_start =3D true;
> +                       start_devid =3D ep->device_id;
> +                       break;
> however in rc1, it is modified as:
>                  case ACPI_IOVT_DEVICE_ENTRY_START:
>                          is_start =3D true;
>                          entry->start_devid =3D ep->device_id;
>                          break;
> Here entry is not allocated and NULL pointer, it is allocated in
> ACPI_IOVT_DEVICE_ENTRY_END switch case.
>
> I really do not know what is aid to modify it and let others to test.
Sorry, it's my fault.

In theory I should point out the modification (eliminating the local
variable start_devid) and refresh a new version. But we have no time
to do this because when the first patch is merged into the ACPI repo
it is near the merge window.

If you agree, I will submit such modifications to fix it.

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 87cee4f0fc80..4cdac28a1fd0 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
acpi_iovt_iommu *iommu)
        for (i =3D 0; i < iommu->device_entry_num; i++) {
                switch (ep->type) {
                case ACPI_IOVT_DEVICE_ENTRY_START:
+                       entry =3D kzalloc_obj(struct iovt_device_entry,
GFP_ATOMIC);
+                       if (!entry)
+                               return -ENOMEM;
+
                        is_start =3D true;
                        entry->start_devid =3D ep->device_id;
                        break;
@@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
acpi_iovt_iommu *iommu)
                        if (!is_start)
                                break;

-                       entry =3D kzalloc_obj(struct iovt_device_entry,
GFP_ATOMIC);
-                       if (!entry)
-                               return -ENOMEM;
-
                        is_start =3D false;
                        entry->end_devid =3D ep->device_id;
                        list_add_tail(&entry->list, &np->ep_list);

Huacai

>
> >
> > Huacai
> >
> > On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> This change is already merged in acpica tree.
> >>
> >> slightly ping.
> >>
> >> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
> >>   > According to the IOVT specification, define macros for each bit of=
 the
> >>   > Flags field in the IOVT IOMMU structure.
> >>   >
> >>   > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
> >>   > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>   > ---
> >>   >  include/acpi/actbl2.h | 7 +++++++
> >>   >  1 file changed, 7 insertions(+)
> >>   >
> >>   > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> >>   > index baef525367b5..76e4a5bc79b4 100644
> >>   > --- a/include/acpi/actbl2.h
> >>   > +++ b/include/acpi/actbl2.h
> >>   > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
> >>   >       u32 device_entry_offset;
> >>   >  };
> >>   >
> >>   > +/* Masks for Flags field above */
> >>   > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
> >>   > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
> >>   > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
> >>   > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
> >>   > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
> >>   > +
> >>   >  struct acpi_iovt_device_entry {
> >>   >       u8 type;
> >>   >       u8 length;
> >>   > --
> >>   > 2.39.3
> >>   >
> >>
>
>
