Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824498;
	b=i2m4MeSdt2+awZ8eT/5XEOA9En7rAqy3Sz0gzdwNuL5CxmdpUVpr1IsUH2C+zSW4z1z8
	 sVWdi/C5w/4n0sxcw2/jeeMGmMRYcQA7mnckj0B8fjzhfmZQOf67y/hmqhu4gc8ioWF6K
	 dPYPiehUZOad5omauQE4jLWJu2nT+0lc9xdmx//7foT8t3qsJPqB/idunw0kpdXxRrfcD
	 kVX+p8sK9I2qbtzZQ5Mfjiaj8p4B1KHXS+c5ItB4T3x5B2f52gP2FviiPVtDDYlpylQum
	 aLxH4G1uDPHrtoevP3p1wg8fnR1175s2Ltk7NQK4khEuvBwgpndzDS5SqZEQd0wzwyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824498;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=++/cJApKmq5juZfLAiuel6bFIXV++xX+hmMi/hm4D1E=;
	b=S05I+U6qOBDJ2sP+k0AqTrkvMyowDPJcx09EIfTJu/g2cjsz4GBGEKrWTT+lWxowsFz4
	 1ze5iFrSaExqpjLFN+zrY2TYrM60s/G5kzP6nKk2XsNvcqb5GE/YDM1Y6TWQtp5WZYrrx
	 QuW22pCxbZTwqpsJgeiElLveyXRO393GOdJc/e5+tWu0zKPXhvukNgH4/4FmR+181dati
	 AUnGzo+3OXvD4gXZ95HOQ26g2ALQn98LcKOK9d1v52pSXHCJZngR9k0IN2IEtgXJvGCtC
	 cwiDEvMidEDzEwXUAwxIkofreGuMqRgHhw4QlLK1zI7pLwONpJ0RXGuYp3bYPf45bFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deyfE46G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C176074FA1
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deyfE46G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205981F00A1C
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 20:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824498;
	bh=++/cJApKmq5juZfLAiuel6bFIXV++xX+hmMi/hm4D1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=deyfE46GbYl+VT6m52waq3YHoTWlKQXXozviR2x4cYR3h6B7BJBVyRfUHpvbNcAZ8
	 PfjDbxB8DvrAFvHLmc3JU2LJJNgVzJ7pjKpqAwrRt60qnJJZmqTIWCn6mhhpzgmkjq
	 l9fd/fpE8zIoUlHcMJI0lBJihRUooD9vqj4zkkfwbBWek1pKMlNMerezzyfVpke3BS
	 27n1lvWZieUYzrIVt3FgNznUyzUCD7AQLRfJGSv4mausQpgV1EVqJkMHuGDLMkVH4w
	 uhQlhKFe8Euf6J3MBTLYKe00PGqAGxf31zqDiEgAzhiUX18cSC9kPFFB/hyhRJOwv5
	 jX5JjbnnDXZVQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ace2e3a2acso2335411fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 12:34:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxluRRtdGCv45zKk1PqGIgHmCXDmUGFOU6QnPdyFXCtqgZuJlaKLSBGLGvb8j0qG9PLFkzE84CnAcgm@vger.kernel.org
X-Gm-Message-State: APuU4Z9l7XsJnubqyBXcrl5KioHHSVFTIFsVMLpEP6Im0poXShFU5qho
	gjE3TJXKUcfP7nT6lGfDg38w7rYGnwe3BpX4w+pK/rWyTZ9ffRAlu4Y5BjRGB2SfEjkKa5Q5X7t
	e3iFdLQ8mKqNVB4EY0u63FcysLBjV5Fk=
X-Received: by 2002:a05:6512:6683:10b0:5bf:e8fd:5e64 with SMTP id
 2adb3069b0e04-5bfe8fd5ea2mr2459163e87.19.1793824496534; Wed, 04 Nov 2026
 12:34:56 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023074502.103681-1-shreeramrahul94@gmail.com>
In-Reply-To: <20261023074502.103681-1-shreeramrahul94@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 21:34:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jaSKPYkzALU5xfJqxBhcPfU0v-60cL=1XwQ=_1r9X-ow@mail.gmail.com>
X-Gm-Features: AclHuK8mvXXK5ImZfKcs1Ri_7afOGeBgt1iV1tIBZmHdivjPFnmZY_zP8SxXao0
Message-ID: <CAJZ5v0jaSKPYkzALU5xfJqxBhcPfU0v-60cL=1XwQ=_1r9X-ow@mail.gmail.com>
Subject: Re: [PATCH] ACPI: ACPICA: Fall back to inline recursion if update
 state allocation fails
To: Rahul Rao <shreeramrahul94@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:46=E2=80=AFAM Rahul Rao <shreeramrahul94@gmail.co=
m> wrote:
>
> When acpi_ut_update_object_reference() traverses nested package elements
> or field elements to increment/decrement reference counts, it allocates a
> temporary union acpi_generic_state via
> acpi_ut_create_update_state_and_push()
> to avoid deep C stack recursion.
>
> If memory allocation fails (for instance, under slab fault injection),
> the function aborts mid-traversal. This leaves sub-object reference count=
s
> out of sync with parent containers. Callers cannot readily roll back the
> partial updates, leading to reference count underflows and slab
> use-after-free bugs (such as in acpi_ns_check_package()).
>
> Fix this by introducing acpi_ut_push_or_update_object(). When allocating
> a deferred update state fails, fall back to inline recursive traversal up
> to a safe bounded recursion limit (ACPI_UT_MAX_UPDATE_DEPTH =3D 16). This
> ensures reference counts remain consistent even during severe memory
> pressure.
>
> Reported-by: syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De1268acad3c273b12120
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Rahul Rao <shreeramrahul94@gmail.com>

Please submit this change to the upstream ACPICA project on GitHub as
a pull request.  If applied, Linux will receive it from there as per

Documentation/driver-api/acpi/linuxized-acpica.rst

> ---
>  drivers/acpi/acpica/utdelete.c | 78 +++++++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelet=
e.c
> index e8180099d01f..87ae66c7eee8 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -20,6 +20,14 @@ static void acpi_ut_delete_internal_obj(union acpi_ope=
rand_object *object);
>  static void
>  acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action);
>
> +static acpi_status
> +acpi_ut_update_object_reference_depth(union acpi_operand_object *object,
> +                                     u16 action, u32 depth);
> +
> +/* Max inline nesting used when a deferred update state cannot be alloca=
ted */
> +
> +#define ACPI_UT_MAX_UPDATE_DEPTH       16
> +
>  /***********************************************************************=
********
>   *
>   * FUNCTION:    acpi_ut_delete_internal_obj
> @@ -457,6 +465,28 @@ acpi_ut_update_ref_count(union acpi_operand_object *=
object, u32 action)
>         }
>  }
>
> +/*
> + * Queue an object for a later reference count update. If the update sta=
te
> + * cannot be allocated, update the object right away instead of failing:=
 an
> + * update abandoned half way leaves the counts of the sub-objects out of
> + * step with the count of their parent, and callers (most of which canno=
t
> + * handle an error) would later drop references that were never added.
> + */
> +static acpi_status
> +acpi_ut_push_or_update_object(union acpi_operand_object *object, u16 act=
ion,
> +                             union acpi_generic_state **state_list, u32 =
depth)
> +{
> +       acpi_status status;
> +
> +       status =3D acpi_ut_create_update_state_and_push(object, action,
> +                                                     state_list);
> +       if (ACPI_SUCCESS(status) || depth >=3D ACPI_UT_MAX_UPDATE_DEPTH)
> +               return status;
> +
> +       return acpi_ut_update_object_reference_depth(object, action,
> +                                                     depth + 1);
> +}
> +
>  /***********************************************************************=
********
>   *
>   * FUNCTION:    acpi_ut_update_object_reference
> @@ -480,6 +510,13 @@ acpi_ut_update_ref_count(union acpi_operand_object *=
object, u32 action)
>
>  acpi_status
>  acpi_ut_update_object_reference(union acpi_operand_object *object, u16 a=
ction)
> +{
> +       return acpi_ut_update_object_reference_depth(object, action, 0);
> +}
> +
> +static acpi_status
> +acpi_ut_update_object_reference_depth(union acpi_operand_object *object,
> +                                     u16 action, u32 depth)
>  {
>         acpi_status status =3D AE_OK;
>         union acpi_generic_state *state_list =3D NULL;
> @@ -560,8 +597,9 @@ acpi_ut_update_object_reference(union acpi_operand_ob=
ject *object, u16 action)
>                                          * for later processing (this eli=
minates recursion.)
>                                          */
>                                         status =3D
> -                                           acpi_ut_create_update_state_a=
nd_push
> -                                           (next_object, action, &state_=
list);
> +                                           acpi_ut_push_or_update_object
> +                                           (next_object, action, &state_=
list,
> +                                            depth);
>                                         if (ACPI_FAILURE(status)) {
>                                                 goto error_exit;
>                                         }
> @@ -579,31 +617,23 @@ acpi_ut_update_object_reference(union acpi_operand_=
object *object, u16 action)
>
>                 case ACPI_TYPE_LOCAL_BANK_FIELD:
>
> -                       next_object =3D object->bank_field.bank_obj;
> -                       status =3D
> -                           acpi_ut_create_update_state_and_push(object->
> -                                                                bank_fie=
ld.
> -                                                                region_o=
bj,
> -                                                                action,
> -                                                                &state_l=
ist);
> -                       if (ACPI_FAILURE(status)) {
> -                               goto error_exit;
> -                       }
> -                       break;
> +               next_object =3D object->bank_field.bank_obj;
> +               status =3D acpi_ut_push_or_update_object(
> +                               object->bank_field.region_obj, action,
> +                               &state_list, depth);
> +               if (ACPI_FAILURE(status))
> +                       goto error_exit;
> +               break;
>
>                 case ACPI_TYPE_LOCAL_INDEX_FIELD:
>
> -                       next_object =3D object->index_field.index_obj;
> -                       status =3D
> -                           acpi_ut_create_update_state_and_push(object->
> -                                                                index_fi=
eld.
> -                                                                data_obj=
,
> -                                                                action,
> -                                                                &state_l=
ist);
> -                       if (ACPI_FAILURE(status)) {
> -                               goto error_exit;
> -                       }
> -                       break;
> +               next_object =3D object->index_field.index_obj;
> +               status =3D acpi_ut_push_or_update_object(
> +                               object->index_field.data_obj, action,
> +                               &state_list, depth);
> +               if (ACPI_FAILURE(status))
> +                       goto error_exit;
> +               break;
>
>                 case ACPI_TYPE_LOCAL_REFERENCE:
>                         /*
> --
> 2.43.0
>
