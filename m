Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828E332610
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503922; cv=pass; b=LwDQroWgTAb2PR8cPpg2M6V2UYy8qPA0/fAnJlcgsJRffGfA1dqN3mjjDlxUGGpYiLtpdgf6R87kcYooDwl8Ac4Ktn3lroNjqwnpVwGcJQuwE3gJoyeCdPff1Y3a5QJInZd/fLkJaeY+ccJTjkvECYP33dOVbv55A1NNi99L0I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503922; c=relaxed/simple;
	bh=uqMLT0sthcKy6wznYkh7Sc1SM3oGMGeO98F9LvQVTXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOvThVpup2mwtEuVoQxA3JSlSMk3ygV3FOe8omfFfxYfv764XaAhy0YHMA5bHqSl0L0UUHCTlNTC9hdLp1dixpHpJZisBgHTYPahvrZQndCFi8skQGrWZhG9AapxrpneQhXn7QODgV9tJFejlDFMKVvHLWYtgj/Z5WT1rdVUsH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA3kyBNH; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA3kyBNH"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66ba9898ae8so7826470a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2026 12:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775503919; cv=none;
        d=google.com; s=arc-20240605;
        b=TMrSafFhFxphxnVSDtQ4Q2CyY+HDq8TJ80v6YQ4/ITlPQ+P2/RrodscwIF1XqgBXFP
         fIP9FX/Khy/cuQbz4RAQ7NrdX+oGuEDSl7XTP8N3sWGutXBFr9E6bTnb7HsX6zri0gbp
         ujMHVy4kIU+N+9rdFhhhfCRqRGx3WLhsO3h8oHdKzBWVG82ubvjJ9Ga9HBMzioe6Xq0Q
         JrX1sEVk3wiF0jX8SPJzE8BQcr386MhZwEFwuip/aCv/DkBicpeUNxUhYTJDJkuWSdEX
         RBzyBd2nY5wIzCTDHoE3CkzNdVPUwhQc8R5ZH8LwU/2jIKbSyB1W4pOVHtIo5HEPUgHV
         4IpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uqMLT0sthcKy6wznYkh7Sc1SM3oGMGeO98F9LvQVTXw=;
        fh=4oDLsJsrx0p2jI5Cu/WGwJMOjXeC0J6WYZiOD8JODgM=;
        b=HeQ/VL01UjY39sVUcFstiACPBiJfpx28lr7EBiiOfPbRLTGLn9hNSuwVJZ4uq1Q1+f
         XCGAS4h8zlYjCR8qkVEN6jX4WZuX9U521E3d9ZRCiXNDqBphq03bcJL085n94Nf5grUm
         9x5wgRXj7R0bHxFqXSemQA7lB29MofGjyX+oWSbtJs17sbzGdyRg/zgziFsgLkTEOyxh
         iJrDznEibY5VmN/leS35a0j8mUhkwT3J6onF6BPeRWsBBh3Sa/3ArzNqIRyHHhJ0y4Dw
         PrA/XQvLtFq70KwenkKMvIVtwDRNYEY8l6BPBdXYmvy/XxYYb9ftW4lPfqeaEtzSW1B4
         K7kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775503919; x=1776108719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqMLT0sthcKy6wznYkh7Sc1SM3oGMGeO98F9LvQVTXw=;
        b=dA3kyBNHclM4Ez/APobjWKyaK3W5bJL4bLOsg4CRJ76I7AcKq38GlG29bWbM/U5+PH
         APWM+YSeNP6h0WNdexoK9v5az1CaQ482iGJy4iHliQQAqHo//7VefoFUyB1Bqce124N/
         Na14l5xU7kBReh1xhamoAkNqBq4H6sg9QhNrSb+84Q6FbE/lhgAD60Jt2JVr4g5jDtNU
         bx6hL8fJmfRYOi3kSIWOL9d8MgO4IuDftSvF4gUCXobV8XnWZVpwLFmltr4WpF4C1qzd
         ei5oXE8Cq5GKQSK08C5sz54J6fEZlD5Z3VM/zp+93WbQp0RkcMItGmPUkWnK29NZ2dhP
         xUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775503919; x=1776108719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqMLT0sthcKy6wznYkh7Sc1SM3oGMGeO98F9LvQVTXw=;
        b=bk7iZWdXczf3Kr1UCpQsaVAmThqjFcqRCwkp4U/83nwH0hn03+hOz+cp6IGlG0jlaS
         bZwJseC6IfcRkleRT85NPyaahZ8CBPQ9r/mzzbJ28U176Eq+KTIBhye4gtk6ya4TjpAs
         dLaxbKxTByAS9Wi0E+f9t1u3l/yhpKP8SHK4TNisx1wRcRzB9pGO230Lc10b8ESMUBL1
         1iWYx7jnZOePEj52wjvpJo8WvUgg33Wcb+r27exHrhK7LapYqFMsO1szSIjBkZRIJlEs
         xTK/Vz3MlhgpkU9WRNMhqzIrY5KWtWrGtc4jPN1nIVr3WP15Af3sCn/AscUDvUl8rHO8
         csCw==
X-Forwarded-Encrypted: i=1; AJvYcCXLBHS+axw4TimKDeKNiHU8IF0hUaXauDNrJsFB3Y0Lh2l5VXBvhCVk0XY1LgprU9HvGumaVq3sgiet@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/T5FqiQCqNQI6vYeJm07i7H3+mR2+nOTWELHIatwa4qKUQZmy
	bM4SU4I2J8AOtE/twQ6Gdd0Qc9N0pc2bcKcL7WabAEr8obPzfAi7QwPG7xj4KESJ7ooIIlXkLBr
	++OvQTUYKMCvI27f/osANwNp2U+MsQpA=
X-Gm-Gg: AeBDieurlWyKyMsmlxFSyBInWJLbL2yoqTHovzKow4NCK1LSPBI0z4TTQqryLo6xP6S
	mV5NfqryBv8Pvl60FtwMHPrtu+u2cWU8MExG80zmpss+DdHoKZ1u7+4iYqNZp4C+IRzA2+WPkHD
	UZsE1MCs7Dgs97WicnP+HtZNTVbUW7487HiL24btqwi/WeOu2o5tsMJTuG8yg1dOafSniKsg3aF
	+xonKhdj+EZs5QINP0Ucbo3FIS9IbDYuK+duqx3i7san1yi1CUAdYX7CVekuVvDzwAAJ0f9UwXB
	6ih5rcPjsE2tFA1RNjVi1dusJoemTpE48t/UjE41oG7JLyliv2Hp46YflhcgQxxcyVp2AiIuQAw
	mFeA/Ri4=
X-Received: by 2002:a17:907:9407:b0:b90:b959:4c72 with SMTP id
 a640c23a62f3a-b9c65596656mr612539466b.6.1775503918392; Mon, 06 Apr 2026
 12:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-swnode-unreg-retcode-v3-0-7886092b28b4@oss.qualcomm.com> <20260403-swnode-unreg-retcode-v3-1-7886092b28b4@oss.qualcomm.com>
In-Reply-To: <20260403-swnode-unreg-retcode-v3-1-7886092b28b4@oss.qualcomm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 Apr 2026 22:31:22 +0300
X-Gm-Features: AQROBzDF6KYTnuyhLB-pMUEmLRfSC888lHdfiDN5w1084rUmzr9JPBFEahloXWo
Message-ID: <CAHp75Vd7cs8tF1vRVFNmXsO0X-cgTJ_Ua22+KigdsN8Kpf-Tyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] software node: return -ENOTCONN when referenced
 swnode is not registered yet
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 4:52=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> It's possible that at the time of resolving a reference to a remote
> software node, the node we know exists is not yet registered as a full
> firmware node. We currently return -ENOENT in this case but the same
> error code is also returned in some other cases, like the reference
> property with given name not existing in the property list of the local
> software node.
>
> It makes sense to let users know that we're dealing with an unregistered
> software node so that they can defer probe - the situation is somewhat
> similar to there existing a firmware node to which no device is bound
> yet - which is valid grounds for probe deferral. To that end: use
> -ENOTCONN to indicate the software node is "not connected".

Despite being mostly for networking purposes this error code also be
de facto used in other contexts similar to what we have.
Acked-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
