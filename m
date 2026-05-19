Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842A27B32C
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153380; cv=pass; b=nci+vLK+EkWSsKnT86dmLzN30J8nv2pcMpjlH8O7szztRNiXtetODFP4PR4wOKMZvMtXT5eC8NzPxlWEqusZ/RCbzsjKDjGkZKyePELyG6mASrxm637JnBkgp27X3GzZkoi/zk2P3gl1s77ZPk+AXS7OybpNzpvlgRjXRfpTZSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153380; c=relaxed/simple;
	bh=OcdkspzN2k6uZSWX7hHNuUolL9rQdeRACcLR8seJ3HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6aBq6ZVVrbOTt78J/rPWIbKhRtoPLabTI5jyr/1bQGvc8Fbhl4HLMNLFPw+OZ0ZsDAPDDZCEeTFNmkVxPEaINqwpvM0GtEXjyXV3qxiPucn/2EETsRyNzkcCij23EwnwMrM5ljqIsG4/eaH+gDGRy7mZTeCEkEnY5G7C/Dg7yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dlsrecqd; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlsrecqd"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1336742714fso44c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 18:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779153379; cv=none;
        d=google.com; s=arc-20240605;
        b=TY7Zql7thgxTaOhiOX9go2YIO4wzc6kHX9EcyWaU4V6/OKBGSFS7podfkWoDmDSoEP
         2DDESmb/YnhlMkGja+3cSN54LoSY+w4MVPuVBJTZvaGFMYmYRUE2Rs++KieXSd73+w+f
         srRSrWnGMxy/CJIT10IPaYNOuAPCR7KuaJUL12STXdl/tAg1ugXQLcTwc5V5J8pzMxF0
         knkR0uRGe1kcIwt7TJ2I2x86hJyGvpzlRkg3vRcjiHnczAyxHb1mtAi7Dnv3nZxuzLS3
         BCfVbPkbIIztFEZlyE8ztqBjfm46uGOTF2uRK1TK98Yj4VNNbWMbop/nBg1HVcmeKrR7
         Sqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6lAMmAv21bOhMBM666DjHC0UfdgXq8bdb8/pvlxld4k=;
        fh=vx4fWmusKrOyHoBUPPvU/QjvNScVl5TQzydP39/vftg=;
        b=jVXus1czaQ1tRY1Nm/SiQDu5KdQ7S1aqQ+hoKpYwDc9mnuMmeLnOkBXq8AJvgNpANK
         RKpWuPB2grHg9vdtUvDdUoA8tC6T1V1urDJ+deHfVd6D9YyQElyKwJLPWFNgjPvXXBJ9
         W2YglOqo2PLfgYoaMfYBaaDNQ88GI+clf4Cq0K2BNqvjjhOSOUzNFjW2oBPyB2NJ3Ac2
         u4yBR18Da2OqZ5ENaTrYgvU/M1iE4FYM5zNxgVA7i0jIhuHYT+hjo7Eh+f4WnK5ESn3i
         potHR7jcnNJ+7Lf1ziVMbnr1P8Or6iIsa9UjtampITBLeXZSeI9QbRLJC88KeBQjb3aP
         JlsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779153379; x=1779758179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6lAMmAv21bOhMBM666DjHC0UfdgXq8bdb8/pvlxld4k=;
        b=DlsrecqdILuq7mshyWdWNORcqoFP3CuQO2GP5iwS9CK5UwhaOEV5S1WytXdpz/ApeO
         Fep8D1YHksI0nEecrFRXwnbvyEtQpl3bXiF8qBTAGhbcE3LHv6BKTmkKV9lIjFKRJqek
         MgggF15EePFoIL638E5xhcEoqt5vIdNdjHln7ihdig+q/H1GFG7s8prrPGWXpBcScmMU
         jA9V7hgtEMaiA/jsme9QDABf5p5DqR4p8Qh5HsUHGYshXtpfWnkMEUQNsp4Hh+eKWWUj
         lt2KWvUF2elYC5oTLD0tzg0VqAQzBLmElROWfe6HRBVEotUgwlrd5p5xnGxyY1hi+Yl4
         Gk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153379; x=1779758179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lAMmAv21bOhMBM666DjHC0UfdgXq8bdb8/pvlxld4k=;
        b=P6rnThtRftu2xI4Xq5nmYxd8EaGv54PJYZdh7ziErsLSWREtBD0AZPvu+x1v95ULLR
         Qn4dCFTnQtK8JryWIVlV+WMjfiO7saC8Uw3xmwbw8mr6EkANz7UEti4jyqqjtC6Ef5Kb
         Dcz6oBzZ+0iN5VhyebtebOvkDiZso6VcwJ2TbLm3GrcEIi3G7WDS2ZtqF+jmSeqro12T
         TT1pyxfiXTszwPOLZ5VuIIlXszn3JRK1yAbjBSSdNhxIjwXFXDM3FwJqD7f5A3kRcCLv
         2OYo49sdBfbnpW6mpWd9OlZHNHEfSZ4nP8/8gimpWWPAeiJ7V85qUqoIX8G3uEY4/uI2
         rk/g==
X-Forwarded-Encrypted: i=1; AFNElJ+ME3XdreZyetoVSniSmZyBv5sbfWrbMz0hn/F41DGpr/nNKW1SEfWvnB32XLLCX+z5OdyKVr4mdBu2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20Pn0yWo3FJ48kYShf21cVHNrVQRaMZ/vIT592f6qv5WAByxv
	hqWCFZvQdBfZ6Gdu0nrIzsigdg2qatDUXPV7ii6ju1a1uP3S6qUiIpC10A0C1f2MvGcSrbRVkuV
	H27Aq66xD0cZAgRhJCOazEMwHDixdzbdUDzobwVi9
X-Gm-Gg: Acq92OGNaDGVeMLYBEc7LDif7xG5Dvk5w+3mw+SudjjsHiP3UU9X7wx2yWD55FMz8AQ
	QVwEA4YEHWve8gQa9jTlKlwtTz/qfndwxjdYh7Y6ea1KhmExMNHUcCPkOsfOnEr/Z0bvN0BOkkj
	DgASeCe+hAMmss6YXH/AUksO6c3QDX3PAq2H5VGc4Ns/8B0YBX6VcDmLvWx0C6p9AexpYXgzqSl
	FxSbodB5aD3GSO6rtKqbOsq2kWVxHCam6auKN+Brdx/X2Fw9wBE88Al1i5zVLYOKTLDIbKXEBd5
	h1NjAok9mjxlF1+IRUnS6wLvoMsYAeQKlDDbPmlwqtSTwI9z5l6XJpMxZHCO42VoY+PLb75z8hy
	9qw==
X-Received: by 2002:a05:7022:6993:b0:130:5c2c:d255 with SMTP id
 a92af1059eb24-135586ca4d1mr208228c88.21.1779153377743; Mon, 18 May 2026
 18:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com> <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
In-Reply-To: <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
From: Peter Shier <pshier@google.com>
Date: Mon, 18 May 2026 18:16:05 -0700
X-Gm-Features: AVHnY4L3cMXr2oalyiGPR6hyMcWMvD9y1aqHbl4j1uzzIozENX94PTfsdzjghnQ
Message-ID: <CACwOFJSz63A9d=EZrapJs=zKeSzWVogtz8F=9SDwVfb5i7vviw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in fwnode_get_next_child_node()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue Feb 10, 2026 at 2:58 PM CET, Andy Shevchenko wrote:
> When device_get_child_node_count() got split to the fwnode and device
> respective APIs, the fwnode didn't inherit the ability to traverse over
> the secondary fwnode. Hence any user, that switches from device to fwnode
> API misses this feature. In particular, this was revealed by the commit
> 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> that effectively broke the GPIO enumeration on Intel Galileo boards.
> Fix this by moving the secondary lookup from device to fwnode API.

I am not familiar with this code at all but from a sashiko AI review I
found the following comments.
Does this need to be addressed?

> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 837d77e3af2b..4217d00c76fd 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -759,7 +759,18 @@
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>     struct fwnode_handle *child)
>  {
> - return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> + struct fwnode_handle *next;
> +
> + if (IS_ERR_OR_NULL(fwnode))
> + return NULL;
> +
> + /* Try to find a child in primary fwnode */
> + next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);

If the primary fwnode is a Devicetree node (OF) and it returns NULL because
`child` was its last child, `of_fwnode_get_next_child_node()` will have
already called `of_node_put()` on `child`. Will passing this already-freed
`child` pointer to the secondary fwnode below cause a double-put when
`software_node_get_next_child()` also calls `fwnode_handle_put(child)`?

If `child` is a node from the secondary fwnode, passing it to the primary
OF fwnode's `get_next_child_node` operation will result in `to_of_node(child)`
evaluating to NULL. This causes `of_get_next_available_child()` to treat it
as the start of the iteration and return the first primary child. Does this
create an infinite loop where the iteration loops back to the primary children
after reaching a secondary child?

Furthermore, when the primary OF fwnode's `get_next_child_node` treats the
secondary `child` as NULL, it does not drop the reference to `child`. Does
this leak the secondary fwnode child references during the infinite loop?

> + if (next)
> + return next;
> +
> + /* When no more children in primary, continue with secondary */
> + return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
>  }
