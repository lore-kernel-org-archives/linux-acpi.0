Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795135830;
	b=fc+pXeE4uc3KOBAve3B0vDjoTYCgW54QzSAJ8BlNnt0/7cWSnKajeQu74fX5mIUQlUVP
	 tlz6oIPXZTxqKZKcq5r47JqRPTCGcYWSqY54DuyNkvQYFfqqggkRtJ0nc0+fyIuEHt/H0
	 UkOdSUpQQ2dsbz25SulpAMs0frKLkJTHf1pM6ZXv7LGFVbgOQyFmeQCS9o/gPBXo3tIO6
	 co7+BUdyWSXD8Sgc95Jd5qwRzACs5glFd7sds7cF8sPxb2E3jCUvAmPgiModjbFwNXzw0
	 3KAQYgMJcRmZJb6DAPpFeZOYlD78YMt6owGhyai6yKVqaaqMUm3Qjj+H4FvdS3XVhZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
	b=UICJU7j2EqLW08S9s716PV01Mw/B+8Y2oJi/yOjAOcqc38twMglvdBYQ6/GdqS2PhQQS
	 9shG9swprb3L2VrDkBVV3R9xVM+acRtj3GtsiMV0h4XoLnHoZGN3TZ8OVGjSkJeGQJH53
	 86139Ote+B1RCSxnoA7I9bdFJAwfWj890bG3o3Rzmxi/PEiys87EBzLdPCexVWAMgCGjV
	 oZ/GUKwszEtIhm5cdILSbNCLFPGA0kag67r6ncHB0654LOH0QdbBWChsay+su8N3PIiOK
	 0+zNvrcvcQJfpTvQV+bY6OlzEEbPWZLsSJPLgs9/5mpxuGdmrqRepbOEgciSALE3dSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AtGdGmCq;
	arc=fail smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA25606A325
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 00:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA25606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AtGdGmCq
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99075306daaso107255241.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 16:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795135829; cv=none;
        d=google.com; s=arc-20260327;
        b=K4YGkfF7Av3SBFiSl57yqKwSbW6UQw7I4fNYQX4TrbYIHWMcoyZlbZdGE0GLChJ4nn
         gL5+z+aQbQ0RZeqgAhm4NAg/N3BqtFAnGTTIsKtOsp7Ey0WGfLoVgPIHkOFBBRMaGSsu
         +Uc9XXvZyzrVw0wd4qKGS0HWzzHwVIxkToNU/NR9O8nVbohpXFaRJJo/1JbKA4bfnSr8
         Ch8Vv2uHOnBPJ1qPlwTSss3C/sr/4WWaA6z7n0angLv2LiSGqUhHUDIG9lqOXdPgpJHI
         Y6gv5EBmn555nvbCqLS4K5IU+KjXzlYOJCJZU4MgRgG5nFl52d27nmMGX/JfV4PsM8Fj
         6cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        fh=ontnQqBwjMEZ597Q0iaLAQTrtBwHNnR7TzaUTd+I5R4=;
        b=oE+0Gnys8keTXGozMhVBnTkX3WOIudlZAsI59ZX64UsKc7UBK+m3Sbj+XWXs/CaeWr
         YvYzM2waJxhDh+2zreVjsWGjRLB9LA1662ZRl4tP4D6e0ucM52BMhttnQdZ5FQNu1LhT
         bWPniV17uvhK6GDG/19fMGnF+sE0qmtuh0z6az8PoKxTUOgRqUE7OR7bWc7w8rlPQAp4
         SdY3FuNcvTHCy/9PnE+ifXhI5YYsibD+zmdXccuQmIjva0lV2nJfekoDUadqWin81QsY
         Or7cLIEXqKizdWVMLjF23RMHzMfJOId0dU2qxN3wDKlA9KaEu0up8/98H4OzNJsfmjh6
         J6pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795135829; x=1795740629; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        b=AtGdGmCqYWoBagnroC2kHC0RNlIUQFcdGwFSfIhmpAOpSH7S9OzAMR0o0dof16ztpp
         XdEGWoEjYwLoudW4mOupNda2yO2gEZ3dC1vzTXaIBC9Ve/A9Wqo4Gm211szeC/e4fJwz
         xa+H67uKRR+3CvqeVV7bX/ZMWcU2pei4vqImjg5FQJ0VmhYJo1ICNX/BU0AeVCPlYlJO
         hLTboBdfqd5nAnzWH/gwtY6OM/kQXnhwrttMbfXUlor4OKXg4BHgB+9TdJB47/JiiQFm
         LcugDJtKsfoJE6dieQvhm4pB6dPV0dc06673o4joi1IGbyHOycbQkiF4aEQO4hF9HFr9
         +/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795135829; x=1795740629;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        b=N+fstRBpMc6u5AipJqTcbplpPSTjyJitbcQOlW1H55fgfRIvl5xSdncBnl5ueMpw+K
         /eOajGh0g74EuKbf7XAY+0HKXNbEK8jP5Fg/t5HaI3sGTnDjLuevX7IG69yyoWQbfuR2
         LPysUeOlRQmVh5QBdt2uEOdCu8EWu/4wtw8UVHndHgcAAJnLcMKYIwprmCdJcbd7sgHx
         j79P72kTx6abaI9TgeKLYghkKXL21iX8MqgSEReXh1l4JdxyyTZtJnKsA3WVOEbdxE7I
         ZqDLoCpq7bI1aDYch70gyUqu4Zlqitv0mkcAxVdw9PH8gQGtFIiOqXA+Rf/JebTf8NhY
         RDPg==
X-Forwarded-Encrypted: i=1; AL+hErEAkPFVvJeBuEju3G21kFlK5a4HWWdo+dIMEIXPFJLwpAA+71BuKG2m3yOfmZmvVU9cf5DtGJMm/rwa@vger.kernel.org
X-Gm-Message-State: APuU4Z83r9NsbVNvqDTbNj7oJBX5kIqp42VBc4cPmEr/G5yDUPPMh43F
	tittyjEBrar9Y5d2vebq+BmNt5HvhSK0n9ispnWxiR61nsN0MtD3Puhwch1hh5NdTmAOkQM1WQd
	l/vGJbGc0nimOoN9VcgIBrYG/CCyJB74=
X-Gm-Gg: AYBFou3ppsMW+AjR1jL9EjWLp77jwM/9HVEGFQZE9fFcaYVg9PJXEFOw6/hSAndVERH
	A/dP/sVB40uqqfl3NyaPHBbqIPsH/GFZQrU3ts4/TiHQuXoCIWHIfiyDG0ldrX4PMHkyAOShIIC
	YnzLMtvkhV3T9aelP+o4s+MVdWwpcHcipsZnRCqVT9bMkb2De5620vbEunphcqVNNg7wWsE+cy4
	t3QrKgCQAS7gGxDiSbAybDPSstjaJekaDYR6igkpTWLbhPKV9m+yLk/LsHwUFETMhAr2AlZDpEd
	/msC/Nx5X4/5GUTtlh8lu0H8gOva7zqRYzIztLNQhD6++colKZOW81nA4+2SctBCWsvg7ZPhDcm
	jurxx8I524Ylbl2QnnSVJd/mo6V382E3AWlSirPZauyySvqVBaStMTvS7EQ+QdrFoBMDBCoifLe
	LsxU3jf9ZWkdcgE+NwSiibdJ/f5JJmQKVjbsTB10/hLSz/41VrEn96BWWoj60yh1hvTBfktE0zM
	TxOteC46yzaiyeUm3cAqxz7VPd3/egXcLyeKjw5Dw==
X-Received: by 2002:a05:6102:441a:b0:7c3:f36:c7b with SMTP id
 ada2fe7eead31-7d739460f73mr627739137.14.1795135828903; Thu, 19 Nov 2026
 16:50:28 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com> <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
In-Reply-To: <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Fri, 20 Nov 2026 05:50:17 +0500
X-Gm-Features: Aa3M54rs1VLWPrHj2w7hmXHghKJVCZNUY4vPO1mwF8EQIcxkzA7-LKDhDSyrkzY
Message-ID: <CADeB2Yom5E_0MwW=9i6RATAEFBmO+Q+ygR9efN84S1mtKVcE6w@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Nov 2026 at 01:45, Jiri Kosina <jikos@kernel.org> wrote:
> Applied to hid.git#for-7.4/upstream-fixes, sorry for the delay.

Thanks, Jiri!

Waqar
