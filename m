Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1344BC91
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210805; cv=none; b=IbjzuohbxN3rc3tJ53BU7m09oaN/teuz4Br9WGURgSOKFl2JV0BQfhi/juLDYKjIcbRbPfT+Hb5Iu3r8YEuu33RXAdKxB+oDObakZf20J3CqQpTqXTqm1x03CLFUNc0A+GhaQGInmsmIuAQpXwzaZesAWdax7ob3RQcrXQZ85Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210805; c=relaxed/simple;
	bh=YFuPeSEEBrVkaWG7tSYdPjzIfSIm1Eu3aDyLqGrdlWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQX5la2RKy21ghPSzFzMEJTF4w1Ei5tUTkNmHqE+7LRzjEdbEVWpRIyBBqPARidQpQqCUjZl/68J0a6xLSABf528w4eJPutrzGz48qduNpt0mFxyAJorinGplFhlE8xkt/o2i21w1Y04OfG+AFmqLWQkm1xFahyDHd/RCEw0fkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk68/R3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk68/R3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF821F00A3A
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 20:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781210804;
	bh=OVOE7DKCwW9lkFpq8ueW/ZpfmuhPkK/RoSWTqeITtRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dk68/R3TvIziQUxz9Z6uulskQPMkTWWYzm4uF7o5ukg7TGxz49AysuPczyPW98NJh
	 62Jh6ElzoF86cNBU89YI1oHgBGnIWJY0Mfcvo4AKkE5v8GWClbwuT5zXKAHCTxWfIm
	 h7fE2PBSr4/9pcnkuJvOLRG8MxwE/j3tS0drB9b7ARRctTqbTBw43jl6Rt68didX2J
	 tbuKas5vSxKOLFrkZ5O9vRQFVFaoRKmoCATN9SonUdzysmA5JVVIsUFBvRPEeGbpCn
	 1aQBSLd5JDbv/yIx1bRZJGBoWBqGNyS33X9rMX8+ZPD7CmGD3bDzCYbqq4ysjgDiDP
	 wasV5ZGHSQzXQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3967717c951so3142221fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 13:46:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/W8Q12gwRF9N/dBV9cv6k3ueyfVLHTnJ0fzsN1lxMQhveLFJWtPS7u3X9C56xhx4DNQGmu4I/w1nIp@vger.kernel.org
X-Gm-Message-State: AOJu0YwcPwuLxZru0tagrroTlcPcNp954++6YmdYu4OywDbFZf+Jh293
	ypKxpsUGlWTdRR/6VZ/s/N+ehSl5DdF6AfLSubWMWbWYsTxxODizyWfBlAoSaC4Cltqd5Z9j4/Z
	IWyJFDXli7FNKS3mmZAkd5QTY3kSrtbA=
X-Received: by 2002:ac2:592c:0:b0:5a8:e61c:371c with SMTP id
 2adb3069b0e04-5ad2db6b6e1mr2971e87.26.1781210802614; Thu, 11 Jun 2026
 13:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com> <20260611203537.1786399-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260611203537.1786399-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Jun 2026 22:46:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPkVr9=6HZ2gbCTtcQjmrH+3yZaiXi5jfkfD8aLzOPug@mail.gmail.com>
X-Gm-Features: AVVi8CfmL4FI1zlHdKhqyUGGjU2AE0CPwtZAqeSkLvcqtmvJDc4VErFuqQfqaAc
Message-ID: <CAJZ5v0jPkVr9=6HZ2gbCTtcQjmrH+3yZaiXi5jfkfD8aLzOPug@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] device property: Refactor to use RAII approach
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In a couple of functions code can be made cleaner with help of
> __free() macro. Refactor these to use RAII approach.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f7b30d9c8716..808e8a90c125 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -7,10 +7,10 @@
>   *          Mika Westerberg <mika.westerberg@linux.intel.com>
>   */
>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> -#include <linux/kconfig.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/phy.h>
> @@ -517,7 +517,6 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string);
>  int fwnode_property_match_string(const struct fwnode_handle *fwnode,
>         const char *propname, const char *string)
>  {
> -       const char **values;
>         int nval, ret;
>
>         nval =3D fwnode_property_string_array_count(fwnode, propname);
> @@ -527,20 +526,18 @@ int fwnode_property_match_string(const struct fwnod=
e_handle *fwnode,
>         if (nval =3D=3D 0)
>                 return -ENODATA;
>
> -       values =3D kcalloc(nval, sizeof(*values), GFP_KERNEL);
> +       const char **values __free(kfree) =3D kcalloc(nval, sizeof(*value=
s), GFP_KERNEL);
>         if (!values)
>                 return -ENOMEM;
>
>         ret =3D fwnode_property_read_string_array(fwnode, propname, value=
s, nval);
>         if (ret < 0)
> -               goto out_free;
> +               return ret;
>
>         ret =3D match_string(values, nval, string);
>         if (ret < 0)
> -               ret =3D -ENODATA;
> +               return -ENODATA;
>
> -out_free:
> -       kfree(values);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_match_string);
> @@ -1128,8 +1125,9 @@ struct fwnode_handle *
>  fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>                                struct fwnode_handle *prev)
>  {
> -       struct fwnode_handle *ep, *port_parent =3D NULL;
>         const struct fwnode_handle *parent;
> +       struct fwnode_handle *port_parent __free(fwnode_handle) =3D NULL;

The thing on the right-hand side of the assignment should be a
constructor, shouldn't it?

> +       struct fwnode_handle *ep;
>
>         /*
>          * If this function is in a loop and the previous iteration retur=
ned
> @@ -1147,13 +1145,9 @@ fwnode_graph_get_next_endpoint(const struct fwnode=
_handle *fwnode,
>
>         ep =3D fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>         if (ep)
> -               goto out_put_port_parent;
> +               return ep;
>
> -       ep =3D fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> -
> -out_put_port_parent:
> -       fwnode_handle_put(port_parent);
> -       return ep;
> +       return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>
> --
> 2.50.1
>
