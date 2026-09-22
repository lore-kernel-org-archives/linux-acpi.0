Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28754A7E2
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095523; cv=none; b=O1MGw3Z1mUIIxhTQEbcErORN8p9sgp3xTCB7yhj2DJ5DpzdhhQPQP36FaiUL1fEXGE41wXAMTUisdw47wlRKV+0zWF7xEY56k1sJelwpzxIpdpSMg6vSIZG8CCHL5Nl0oW1xUj0mo9uVMB4eM8nwyr6zZjL2de6ofWo6GmdUryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095523; c=relaxed/simple;
	bh=RzI6yzTsnEHpxIDWpsvcv2uFMVLyTIaSMtvm9ALO2fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjCWqdt17nGW1VV7F/Sy7s0lS0iDuyVk/flqZNFyBn7qDaDjyjkeoEGp8ogqSUzj7aofy0RDam53ft4q5VMCyoNLjEyl5ZawE8OkYJeTULWQnvOBSKIM7Zs1gvgyEd97n9LbD60b7oJ08CalP9pAcofMTGZlTowZUEzT5ZK2b2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glXkrg8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glXkrg8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE76C1F00898
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095521;
	bh=dEsr56tvPAVDMVD15pnDXbwnnFW26agwYnX2yLxPkC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=glXkrg8NfvbJicYXULpDseuGPMnZ9r00fbXO8qK0REodSO1Ebk4G/k7PP4JHeY+e6
	 iWvjAi50TE1iQoiUHb7MbbBq5e+dx0mbjQM/cErOQ+cgvdkVgolTbY9sfTrZ8zUdUX
	 jlC1UG0SiOYWvISlX3e+XWK8idu5ua6qHf4LGRKZ4TSEwzbXSY/dnJJPsvfO1RRMVF
	 K8vNYCYduTTDcNHAL5lKdCw2qmvV9wG1BxD+5B2ihBxEPNEalLUnO1ZTVZvbYpucJ0
	 rq22NN175NrlW5xgeqZDj+9OPhLDzq0ygs6fJzZmg2btNdPm6Uoaeg+SnRVN7+kLOK
	 hZhGR2CfMoGGQ==
Received: by mail-lr2-f19.google.com with SMTP id 38308e7fff4ca-3a30521edd8so15735401fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 09:45:21 -0700 (PDT)
X-Gm-Message-State: AFuF++nbOqpUoXLcZgQVL6i1r3UD7FW5qInR7RRf4Yfk5lxpBw6uNzlL
	SA8JDI0Fvq4fpGl709Vr2Uk8sgzhy4RJ5nZKKvSmGEx2IGCtX218jcuhd8OSbhO91Uf+eZPCd7I
	9Tf6wDvobgIzcGW4MLEmewlB8tmDBYtg=
X-Received: by 2002:a2e:b8c9:0:b0:3a4:99bb:2821 with SMTP id
 38308e7fff4ca-3a62fe820f1mr98161fa.9.1790095519990; Tue, 22 Sep 2026 09:45:19
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921081411.4819-1-lalitshankarch@gmail.com>
In-Reply-To: <20260921081411.4819-1-lalitshankarch@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 18:43:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gvYn3ga6vL3BYt+5GFRheg_sjF8AX_HBXfHaLv+tPGKA@mail.gmail.com>
X-Gm-Features: AcwNN1WUj2M2ZbgpqTFo1XnRCnYfhT4RuuW4Q5QrJOiF_GO2_qes85b2YHJn-Vk
Message-ID: <CAJZ5v0gvYn3ga6vL3BYt+5GFRheg_sjF8AX_HBXfHaLv+tPGKA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: use IS_ENABLED() to simplify built-in or module checks
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Armin

On Mon, Sep 21, 2026 at 10:14=E2=80=AFAM Lalit Shankar Chowdhury
<lalitshankarch@gmail.com> wrote:
>
> Replace the remaining built-in/module check for CONFIG_ACPI_WMI
> with IS_ENABLED() macro.
>
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> ---
>  include/linux/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ddacac812094..b590f520dc57 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -434,7 +434,7 @@ extern acpi_handle ec_get_handle(void);
>
>  extern bool acpi_is_pnp_device(struct acpi_device *);
>
> -#if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
> +#if IS_ENABLED(CONFIG_ACPI_WMI)
>
>  typedef void (*wmi_notify_handler) (union acpi_object *data, void *conte=
xt);
>
> --
> 2.53.0
>
>
