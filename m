Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179411;
	b=euJdxkzZlpn1FIcgH+S2qOFrX+uEQLrFtQC7NoG9miZ+8RzV19znZOK4YYN6Fi1YWBcx
	 2I2nWCTWiIZR45xB8janJQzHSCXrM6xomnnFKbjLQ4QCRioUjb1ucQ/vDLpCByc1tudiB
	 xxSzvPHRQ006kjaugFEh7nHAPPFvt4LzFMyUtKr8ADd/qkcVApoCKSBzaYOwRtMGbrTyH
	 8V8gqIfQt6YpGwa+UOd+5jhm67q78ASyGa456vWsCS/TOpDWcy2Q5+xUCQn/lLWUAN5+X
	 XFz95fMqaSBG+of/0HRiqpZ5EEJfU4igyzCvJrnV1TxqkEnndGASeqzNX5Q/aOl4GlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179411;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZOk5fwtUn/oS3m3/FE9OYu4B8xXtlvwf1PT58EnivgM=;
	b=IoUO6WnMtkZtJE5k/jSCaEte7uEPZd4AKQkN5V+hkAVoJgQxQvNcDJrN1y3cvmH7ZbT6
	 QaBo70o20V67rFNEm1r+lQkh+5vPvK9jiFx/QURVDoR93tehZWAs5ob9l2QHIKZbsz00v
	 yJK8AFJgoBbGxHhyUacTiUIQ6Bghw7I1lSDPvsDNbyZCx1eCpSpU0U/dXMkhMxmAgauzX
	 4Ixjh8tyV+rFgzIiBgX5Y1pJUxrbeDvfjhVIvCb9798/RHIHVpbhs6pO2YUWVALVSylvJ
	 AOhCPcNKdUJ09nvTr4MlYHqf0a/PGdXkHT9QKQ7TO7b7iTeqb22Zk00O7HC2cH1fdzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpBP1I3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C3606A333
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpBP1I3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDCC1F000D4
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795179410;
	bh=ZOk5fwtUn/oS3m3/FE9OYu4B8xXtlvwf1PT58EnivgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BpBP1I3MWY+BbOyOFT4eDGAC3SIni3xnzzaz4OEAV8cuFSx1qZLbsF0XMgSnUQPWK
	 Zrdl2tWff33wwSeK5zh/Opsr3RKoSMiuIIPFLSYlFlskcUJDxk1928d8NNtxIuIPbM
	 UiPPnqABSMPZy0CXccuVwYE+BPBd76MBt/eoe8zhWl5kHnYW2mgyxrSFFEPikpMFo5
	 dOhfNvWfxhr/Ox4OXtAGJ4g088nWi6thv+4lbVVtZXgfLRsJgyPx77ytIbu6TXuAVm
	 oiq2OiAcGPk+j3Eieaf2PzW6jxzfLKHu/XsgDR8sCokYgBcY5s59A3OWL1VEpuTAHP
	 ww3sD/9v0sKOg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c102ad8420so511641e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 04:56:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEiDm/zZUOHQB0uhg5MzdIIF4AR9HMLyrHVYMaCnn8p2AVCnlfBIjsOnezAAjsfcDrvzFiaWgZ0mvv+@vger.kernel.org
X-Gm-Message-State: APuU4Z9CDxbAqRligLPWhFK01EGh0KpdzagX7cauPZ6dA8yW5yQpGGtH
	a3VZO0Al/by8kadWRlaM5+pYAgMWDb0PLFnoP31m37H0CphffrVr+ZRCol41cuFjfphpuA6zuHY
	feE/fFyYNYWCFcJACfAD/DrUiWCV6nCI=
X-Received: by 2002:a05:6512:114d:b0:5bf:b93e:89f0 with SMTP id
 2adb3069b0e04-5c1bc85f0c4mr769210e87.62.1795179409049; Fri, 20 Nov 2026
 04:56:49 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105030450.1946871-1-yubowen8@huawei.com>
In-Reply-To: <20261105030450.1946871-1-yubowen8@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:56:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJh+DiWhFOUTGqK20FEP-n1uW7n0RbJqyEZqyH-wBUjg@mail.gmail.com>
X-Gm-Features: Aa3M54orcHltBuGKG-bBoskX8e4t_dh2CSRLYLe7zy3OmzWqStDFrl-d6jg5ELk
Message-ID: <CAJZ5v0hJh+DiWhFOUTGqK20FEP-n1uW7n0RbJqyEZqyH-wBUjg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform: Assign names to MEM resources from _DSD "reg-names"
To: Bowen Yu <yubowen8@huawei.com>
Cc: linuxarm@huawei.com, rafael@kernel.org, linux-acpi@vger.kernel.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, 
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com, 
	ouyiyong1@huawei.com, dengtao44@huawei.com, tangbin55@huawei.com, 
	mojunjun4@huawei.com, wuzhanlong@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:05=E2=80=AFAM Bowen Yu <yubowen8@huawei.com> wrote=
:
>
> ACPI _CRS resources carry no names, so platform_get_resource_byname()
> always fails for ACPI-created platform devices -- it skips any resource
> whose name is NULL. This prevents drivers shared between Device Tree
> and ACPI (via PRP0001) from using byname resource lookup.
>
> Add a new helper, acpi_platform_set_resource_names(), that reads the
> "reg-names" string array from _DSD and assigns names to MEM resources
> in the order they appear in _CRS. This mirrors the Device Tree
> "reg-names" property semantics. This property is optional, if absent
> the behavior will be unchanged.
>
> Tested on arm64 by injecting an SSDT through the initrd table upgrade
> mechanism that describes a PRP0001 test device with three MMIO
> resources and a matching "reg-names" package: a test driver using
> platform_get_resource_byname() resolved all three regions, and
> /proc/iomem shows the assigned names:
>
>   f0000000-f0000fff : reg0
>   f0001000-f0001fff : reg1
>   f0002000-f0002fff : reg2
>
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>

This is essentially an ACPI specification extension that would be
Linux-specific and introduced without asking the ACPI Specification
Working Group for feedback.  Let alone documenting it properly.

I'm not going to apply this, sorry.

> ---
>  drivers/acpi/acpi_platform.c | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 80ea7121744d..61f04eacc2f0 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -108,6 +108,39 @@ static unsigned int acpi_platform_adjust_resources(s=
truct acpi_device *adev,
>         return count;
>  }
>
> +static void acpi_platform_set_resource_names(struct acpi_device *adev,
> +                                            struct resource *resources,
> +                                            int count)
> +{
> +       const char **names;
> +       int mem_count =3D 0, mem_idx =3D 0;
> +       int i, num;
> +
> +       /* reg-names is optional; skip entirely if not present in _DSD */
> +       if (!fwnode_property_present(acpi_fwnode_handle(adev), "reg-names=
"))
> +               return;
> +
> +       for (i =3D 0; i < count; i++)
> +               if (resource_type(&resources[i]) =3D=3D IORESOURCE_MEM)
> +                       mem_count++;
> +       if (mem_count =3D=3D 0)
> +               return;
> +
> +       names =3D kcalloc(mem_count, sizeof(*names), GFP_KERNEL);
> +       if (!names)
> +               return;
> +
> +       num =3D fwnode_property_read_string_array(acpi_fwnode_handle(adev=
),
> +                                               "reg-names", names, mem_c=
ount);
> +       if (num =3D=3D mem_count) {
> +               for (i =3D 0; i < count; i++) {
> +                       if (resource_type(&resources[i]) =3D=3D IORESOURC=
E_MEM)
> +                               resources[i].name =3D names[mem_idx++];
> +               }
> +       }
> +       kfree(names);
> +}
> +
>  static void acpi_platform_fill_resource(struct device *parent,
>                                         const struct resource *src,
>                                         struct resource *dest)
> @@ -194,6 +227,10 @@ struct platform_device *acpi_create_platform_device(=
struct acpi_device *adev,
>                                 acpi_platform_fill_resource(parent, rentr=
y->res,
>                                                             &resources[co=
unt++]);
>                         }
> +
> +                       acpi_platform_set_resource_names(adev, resources,
> +                                                        count);
> +
>                         acpi_dev_free_resource_list(&resource_list);
>                 }
>         }
> --
> 2.33.0
>
>
