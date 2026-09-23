Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503695293E2
	for <linux-acpi@vger.kernel.org>; Wed, 23 Sep 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175430; cv=none; b=lHiwcn3P+QmsbzxuUxIgPWpDQli8vTdE8AFlstOS0GFJ4lKQXhaKxWB40VHQ4wkW3bHdRohQVU+I0zkbwVyAgU8kGS+shqJGhCoPczX5PSTg6iO+lAj2LD8s9riBqxUStGS4nkvFOct29XxvY2oJ31lg139MLC2xaWUdu+mCDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175430; c=relaxed/simple;
	bh=os/qN9BUZ4QVqN4bK5cJrrbTTGEtih9hSlzZqIq8h90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYFnQniuyczgpVtCFMmQieQhJ9actDR57m52kVMXJ7Pxt0kKKw2UIuCn5Sw6Dz0EB/Sv8/W0gtg1RxJGHAdLbV4kqD7Kx4vAtXJ8NTTGGZEN780L8k2HJH9ZG2Gv5IeTOQEeX2L2BG4tYPw3f0aQJ7EeDA6stmrP5A/AdYQwXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1VGCx4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1VGCx4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099741F00893
	for <linux-acpi@vger.kernel.org>; Wed, 23 Sep 2026 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790175429;
	bh=k+k4gHg4jDXaVj8Qgc9B7QiB1Jx+hfHTeBdjxkQSEvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j1VGCx4KnFfFocpD8GiMIu2ji2Bx+cORoHOFyzy3JyUQM4TOSkSejTywe78koD1R8
	 Uc6UMfZq8+g3LAM0uUd4GUyYBzICpbUmOW4jFZGB0VVtS2Lb3ORPooXJwdR/WWmXCL
	 GLJtt3wPb6NZCMHSZxs0RrpQ5MMw9BQuAu19ykkdQD7wY4h2o3/nJUz5aKOMd4lttN
	 rCkjyj7R1mRp6Xe5E+3GCJz3CkFWE+JKHyXQB5wocozucKn97Pq7/q2Bih/1rqeWXK
	 1KKbGS3mIUSgwVGKs3T1k+22tg3vSwPYlbpLn97Ap4b7jUkJRJJe89pjzc/hSljbZi
	 PvuO3ewEIicKw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso15326971fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 23 Sep 2026 07:57:08 -0700 (PDT)
X-Gm-Message-State: AFuF++m0ymVOyfXrd8VFpec6akzDawi0XIlR62NBHCVLMbZsuwYqsBlW
	5fU4IJEIuSa5EuXsULggI2ePnNpncYBWm8hA8FWPbPuhig0ZCvHOLDrbzRyaqAUcHhFXqiygSpc
	rgXQmOU5fDhYBrFDbdjud3nx5EmGc/x8=
X-Received: by 2002:a2e:b8d6:0:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3a624dd9052mr14893691fa.24.1790175427369; Wed, 23 Sep 2026
 07:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921081411.4819-1-lalitshankarch@gmail.com>
 <CAJZ5v0gvYn3ga6vL3BYt+5GFRheg_sjF8AX_HBXfHaLv+tPGKA@mail.gmail.com> <50986455-fb18-4c92-9c3b-74d625f3f6fa@gmx.de>
In-Reply-To: <50986455-fb18-4c92-9c3b-74d625f3f6fa@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 16:55:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUovbnwqkobdnn2xtPvNHZkjJr_wsUNGyBX4X=2-U-_A@mail.gmail.com>
X-Gm-Features: AclHuK-5Qf023LX0aSxq1cXU_7s3AcrkOpncZluGdAhuJqgz8MSBZiyMjuFieYs
Message-ID: <CAJZ5v0jUovbnwqkobdnn2xtPvNHZkjJr_wsUNGyBX4X=2-U-_A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: use IS_ENABLED() to simplify built-in or module checks
To: Armin Wolf <W_Armin@gmx.de>, Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 9:40=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 22.09.26 um 18:43 schrieb Rafael J. Wysocki (Intel):
>
> > +Armin
> >
> > On Mon, Sep 21, 2026 at 10:14=E2=80=AFAM Lalit Shankar Chowdhury
> > <lalitshankarch@gmail.com> wrote:
> >> Replace the remaining built-in/module check for CONFIG_ACPI_WMI
> >> with IS_ENABLED() macro.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Applied as 7.4 material, thanks!

> >> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> >> ---
> >>   include/linux/acpi.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> index ddacac812094..b590f520dc57 100644
> >> --- a/include/linux/acpi.h
> >> +++ b/include/linux/acpi.h
> >> @@ -434,7 +434,7 @@ extern acpi_handle ec_get_handle(void);
> >>
> >>   extern bool acpi_is_pnp_device(struct acpi_device *);
> >>
> >> -#if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
> >> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> >>
> >>   typedef void (*wmi_notify_handler) (union acpi_object *data, void *c=
ontext);
> >>
> >> --
> >> 2.53.0
> >>
> >>
