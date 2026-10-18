Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56023115BD
	for <linux-acpi@vger.kernel.org>; Sun, 18 Oct 2026 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792300588; cv=pass; b=IE3RBDK89BC0F+EfgVWWQt0Qpij7guV4YpVCTICl3klc9rI2S1s+0BNpBHZMGWwhIAHhMrI4ZSt8R8lEVfHeRkv1F0R2CKdKT4wjsIK2Ns3RGPGDLDSDtXaWkBimYp1Gt+eMK5tMPTsjP3vxOgD4clJJv4ar3xw9Y6hJTnmYAOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792300588; c=relaxed/simple;
	bh=IRYY2cNjYNEddcbBdJr/PrMbt22HK3UZswOdJ0bqTZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PnLHW79qab6tOoI03mWU2vKQELRyoqnyeEGnc4hmxgJNdzCK7OsDI7sYxpa2jpMwp/VgOr06mHoOLb/7t06vKCcl2ggvLrz5l7BWEqiARdF+mWxuNomxSgJmq93MVWbDF0YVFj3ddk/aGAgg8KcxUPZ28oVq82O/MSl+l7XKiCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OviyxiNp; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OviyxiNp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4322d310e7so31748066b.0
        for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 22:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792300585; cv=none;
        d=google.com; s=arc-20260327;
        b=JKM3O7YgCIHhQoQdD5wjmd/UNb82XEQLIIBICdQsaQOOn1+8UnJocZSGyW3k3tiqpe
         47geRLSDHsgk8SEMHNStoB30XE9Qv4vLaBaBDsu7qDWF7dysv2pGPPuRr7q36Q2ucNsV
         6WpeaI5rj/E7HsW31fzN8cLg+qDsiEXi7RhXRXO8NmqPGwY2sJC7g3tHaBWNOIHcVeoQ
         SrcZJHIgGupsBjxU10+8ySzAbEN4kGCHPwH7NIFmGUgkQ67LCKuyrV6UcdcIOS2QW8DX
         kERUIA1Bag/55wduVWdXcRit+uB8LcEx8X2DmP/0iBbnNpK+u+JfipnbGhdLJJgvqgK/
         YjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DCYFiAPwwTauM7HA0Q7c8hu4ZkFEv9hTMAQNGao0Z+U=;
        fh=i8+IsJtE6MgNa7VGbAgof+9TV1eQhRumhVPyHZcz+AI=;
        b=WT1c3PMOxRYbZJk2weW7SMcwr6HZ/wjtWqJcvNm+t9DqqGasgYRowKcDTS1S10Ttbf
         SSoMIlsk7WtmNFRZomVlzM9PeiMeIK4ak6pteOrwgmSrxQhzuya3OV3ig9/IoeBpjtfk
         Ke+CkF7LPy1WuoOSXpy9EHr1kszGpT8UbPkx2d0dHgFYfhPusLZxECqEP6uGJYkoqdjg
         TkFsAyCy0Ug7PXZ6UUpymjUowNuBd2zrGgvPs+9Jt20IGyGadvyqzh9DB2x6wTj34dFb
         d3L/EkMtAUIczLSOgii4uFP8GJp3rXzPNprufafo9gVmg5cqwWLoetfeqsS0bbORnYb2
         ae5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792300585; x=1792905385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCYFiAPwwTauM7HA0Q7c8hu4ZkFEv9hTMAQNGao0Z+U=;
        b=OviyxiNpONW233Vv5UaljVeUvqjFCl75wGFKYN51OrUftwg3oIlBtMmgOEQQKv+CtG
         C6Tceb3ziPFthbPZzaGTBdQlo3C2ElgAyEuR0XsO7ymjPmffJc+QVkCeS5t2SAI1lqMe
         Aal3R693JBc/BLCV9FupS9w39DOrtDcAnbIoCY6ZEE3aynoR5sgN9OIFPuhegqWr1mzc
         CSwj0TLCDKmingQ6XVuk0alPh2a5imD+A5zXMdUG3MwUjRLp2MEQR+NpGTIxLV1uOACq
         E+mXM1W1ZbbbYjahfESbfRoklBpuLYx879NJf5JmejCYgS3DeQ6r+tpYpZZnevdDVNyK
         M7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792300585; x=1792905385;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DCYFiAPwwTauM7HA0Q7c8hu4ZkFEv9hTMAQNGao0Z+U=;
        b=zTvUWH0VsSN78QjEKyRtFWB+OhhIggQpYc5jGUhZvkTH2T4DzGgOk5PaDweLHqW9cE
         TLYf3aUb2tg9YxirGaCQJNDRBe6a2R9oKCl6eS2Z2OtIAOR5yUdIxaGBra3eyMI38lVr
         jw6emNWREldQRrF2yV11TyQb2PlAEBZsq1L8EiFfTPn2HR9k1H50mXG2LFwUAuaDvpbZ
         IGik+Py4VzL7deOEAlwirdM+VSSCOvQlIPvLbKizWiIMxaEOm4sXhhKjS5isq8XyAtYZ
         0HFYKjJYlXG14WgSMygR8UDCm45UWyjWs4Mf3byCfMkNqVoMYGLZ2XZcOa8v7E6Nxkmk
         l5Bw==
X-Gm-Message-State: AFq9FYKY3mIr5L/6AH+VF3xc2VoHF3f7xUwRr3J4/l2aP2IC5XBO67jd
	j15XsYF3hS3OL+wE0sJMU/20GTor+Qfz86oYt03dX7VU0zLVszNunBQwrSby1y9KvgiqoA8UTub
	4CVv3G5pQQz317VJsoqJyceSiaBqiXcN09cPZFgk=
X-Gm-Gg: AYBFou0cHSOLtseSvcap6hWxkptRKofoVRDymWuVC0KlyeuuB6tDQ5jcfvPCmsEU23s
	GG30t8v15IdqHVnv89ye+4i2JTo/HdOU+Oofq/oRAyr1pVbKEXlcXrn6F+BuXJBpLHPsecxxQQD
	9CXLErO8td7c6pTfK4g61CK4IoK679TJ7YjS0kqptu/Het+b1WKqHPFr5jn4zdKcDLIw9YmqsYs
	Ek7FRx6Mp1pn/4xj2ZevqpXesTBFt+Wg5KIVFKTq1oB5JVywhjjB4zFKn1ujDM+POBnarEpd4Vd
	VE+NQJhAuzOuHe7jUkNKgXgfN74Xzkrqu3rpnyEwp+WxbPVFWQKcfnc=
X-Received: by 2002:a17:907:934a:b0:c2e:63ba:1f90 with SMTP id
 a640c23a62f3a-c41a04ee61fmr297205266b.48.1792300584864; Sat, 17 Oct 2026
 22:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Domenico Suppa <domenicosuppa@gmail.com>
Date: Sun, 18 Oct 2026 07:12:44 +0200
X-Gm-Features: AclHuK_L6vnmnWfqMD5kx9D6Ozk83KMB_il4u_tY7bVCnjcZYUqq4jr5E6w__38
Message-ID: <CADP5X9+xCTkxXZO1dcTodrwsfW=piV41c5f_zaOq6KsrxD0Hhw@mail.gmail.com>
Subject: [REGRESSION] ACPI: Power button (PWRB) broken on multiple machines
 after 6.18.57
To: linux-acpi@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

This issue is not limited to my machine (ASRock H310CM-HDV). Multiple
users have reported that the power button stops working after upgrading
to 6.18.57.

I found an upstream patch that exactly addresses this:
"[PATCH v1 2/2] ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons"
by Rafael J. Wysocki, which states:

  After starting to use platform devices for representing buttons
  enumerated via ACPI, acpi_mark_gpe_for_wake() is insufficient...
  This causes acpi_enable_gpe() to fail and system suspend transitions
  to be aborted.

  Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one")

My machine is also affected: PWRB (PNP0C0C), evtest shows no KEY_POWER
event, and /sys/firmware/acpi/interrupts/ff_pwr_btn returns
"0 STS invalid unmasked".

The DSDT for my board (ASRock H310CM-HDV) shows the PNP0C0C device
without any _PRW method:

  Name (_HID, EisaId ("PNP0C0C"))
  Name (PBST, One)
  Method (_STA, 0, NotSerialized) { Return (0x0F) }

This suggests the button may rely on a different mechanism (possibly
fixed event) rather than a GPE declared via _PRW. The ff_pwr_btn counter
shows "STS invalid", indicating the fixed event handler is not registered

Best regards,

Domenico Suppa
