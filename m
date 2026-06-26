Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D317C220
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782504851; cv=none; b=Zap7QNGLicJHJPHsrpAfxNobbWS7XLfQoENQ2NLPZr0O0omnn40+mbctyfCpnKEAke89weYjzQQwLgvMOpDbn4hhO35Lts+IjZLJ18LeelFytHDKehbmjerMzGMJv+oP+pmY75cyA3Ri78WRdMJZeDOgxRtbX8I1XNGWGFPY7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782504851; c=relaxed/simple;
	bh=ub1rJsYjCUfWZbpz+fdEyhZesTUIsLwSS17waNUOJFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW+QfoG9v4KwmRFNoYV6+YgNFgGcmknt/kr4trw3BKm71CmRh/P+tIKZjDcu2fxStn3B24na7G9mMIq+0JhrItevhJNXOUZLUhYuuXcKNCOIPEiAJllV12sXtg15ljCAA8iXr6FEA8b960gP1vfIOvdyK93VDmVBzt3rA+SIxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NsCHqiiZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NsCHqiiZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6c57c5bcfso15268605ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782504849; x=1783109649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2F4Y1yCJTmWoAxT+0o/PcRIpQzTLR5O2f+f5Ok21rXY=;
        b=NsCHqiiZAnnLnYwNZ3iA/0OKDzQwBkuRqvPHHRowlyRuiECvqNm2/sPw2CRqWlLzud
         rUgHn1qYkkuieRGrMdsB0Ods/f8zNYxhjvoRDX+/HAQi+4qTcPuwqN5kgHz3GBKju0NO
         Kux2O6/FGJxUeMiV90ZmT1eMRc3+JAuL2u7Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782504849; x=1783109649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F4Y1yCJTmWoAxT+0o/PcRIpQzTLR5O2f+f5Ok21rXY=;
        b=MrxbWZF/hIeH/geIIJZUDbqX1ApkbpHCmzAZ/a5CEdYpEOoQrI6pBL18kxZW+5g3ll
         O7Fw7u4eFEpqJyc92e+T1d9xz9Uw7EMxSMMSujqxXfHE8IQLj96f4lAWF4eAFzI8Odx1
         bz/qtXEQlRNNN42FtcFBxNnCl5TIak7pGe3XU2CfhXZOFGzVZ++gvCKc2JXgU6RiAQYo
         /gqI/6itGkBY8WZ5G1IhDAZ3vrr3lSeKg9eer4eRohoZcPzg7HdV9+Cz8LlTs6h+4Mn7
         yXuEH/EwyEA+S2RtYxOyVJelt5ZADmBeYeBogpe3RE3ADmA0ZfDYAjPFTmZoQvVLnnbU
         SVFg==
X-Gm-Message-State: AOJu0YzPyLrE1/wiO1dxXKcumia92ETLHbx3tvzBMLz5HEbwNgeE8UQk
	KR6WdvqTbqWD7f0SM9IIJXhzQE/ZLQr7KDd8ArRp5xFR4UMyoX8VgRSNitTWCN+N4XQ3m/+GkdI
	ALvIX
X-Gm-Gg: AfdE7cn9u8moTLXYNYSeF5bP8dSOt1A1cp5ieZJdArze7sgy7jvYgzb1Ak6XGW7ipEh
	Y1tC5zovvOWct7PoU8oDEMd/txpJNeCaqNDgWd4Txck9DuNkkdp8VNiuM6X3oayMjVcrAsvqI4u
	G2v3UfxRTyAWKm9Q9SZbfwd/LNSdwOCFYyAo/gfcmJ3eJW52iHE135PdcrYnpWXO/a1BJzEQx7o
	hXGxHqV4LhBBQX75fxLOGSnonXq0TtXAwJiIAoTHA0yznwYqbkIEm2VAxIaRt2XZL8tAQCpR4PI
	UUdjGu8j9/CFKZ+fR8DilRRCj6VqhZ26f+UJopIgpeXHh5vK+LWbJDlvJLLSMe39sltf9YzWXZy
	TQ+oPWvxC2xLIcSnRM4/4hm63bBveRPQEk3uNczA2Y8PbxyQ13lwICZvwDZECFq5UvrMr25amz2
	YjDwU35vXKZDq+zPVWXclTXBJVbkI+4aujrLny+2SO2bAaqNXWve2Li2UhHObBW8sx8A==
X-Received: by 2002:a17:902:f642:b0:2c8:218d:4374 with SMTP id d9443c01a7336-2c8218d44dbmr30512715ad.26.1782504848706;
        Fri, 26 Jun 2026 13:14:08 -0700 (PDT)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c8248a0794sm13659195ad.26.2026.06.26.13.14.07
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 13:14:08 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f236418so676760b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 13:14:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:1bc6:b0:842:5c90:736b with SMTP id
 d2e1a72fcca58-845b3b8e325mr8466942b3a.29.1782504847416; Fri, 26 Jun 2026
 13:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jun 2026 13:13:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
X-Gm-Features: AVVi8CfFw2XgHmHaPns9ZxnG8dwQnTbmgexO32t8DbAm-v2T5HHx0LUFCS4Hwrg
Message-ID: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 10:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Unbreak ACPICA tools builds after switching over to using
>    strscpy_pad() that is kernel-specific (Rafael Wysocki)

Ugh, honestly, this is disgusting.

I've pulled this, but this file is not in some kind of "tools"
directory, so the fact that it then also gets compiled in user space
should be treated as a user space problem.

I had to really scratch my head how it's even build by user space at
all, and it's due to absolutely disgusting code in

    tools/power/acpi/tools/acpidump/Makefile

that uses a vpath thing to find that C file for that tool build.

That's just crazy.

But the fix is *still* not to add horrendous "let's use strncpy() when
not built for the kernel" in code that looks and acts like kernel
code. None of the other acpica code does that.

How about just adding a trivial strncpy_pad() to
<acpi/platform/acenv.h> or something. A place that already knows about
the whole "I'm building the app side" now.

Hmm?

             Linus
