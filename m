Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBE1AF0BB
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768672; cv=pass; b=PVLuH1AkfvxhXxuwcmIzPP231CKXuWc0nT04u+9tGQRYACi0YYQxfb0/WKJFnYWxCQ5f9b3zuHZ0HC8nASEV44Gv+3fDP1T+jZa1HMA+XSWesCpYRSyOCAZxeQOKeLSqiN7N/nF5dIE4AG5hxtxuQCM9DCOnmu3tlNgzba3LvjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768672; c=relaxed/simple;
	bh=yxS3uhBDvfDEPOTnAxS76usAFm0hrKWhB58ChKobAUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sATMqeuH+OFIePvWs9J4zJt3E/9p92XJ8C992DwNhCo//uFB93/COl+XuP7BeprqszORhnKdMziyYQG02TmUmIxp6fhoghophJLjp+Mxi+R4zEGFPXWXXxP93g+RsundyLR96e+gIiM13HUQ1ixOjAezqM3YrE1sYPdhhjTnLhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IovhHvuH; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IovhHvuH"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-49dee4c5427so639205fac.2
        for <linux-acpi@vger.kernel.org>; Sun, 11 Oct 2026 18:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791768670; cv=none;
        d=google.com; s=arc-20260327;
        b=PXr1ERyzseUoAMeP9bqx97C+ai68JmMO20KswPd7Ud+lRRfh9IUeaX/hQxjZa09wEy
         BCYzn3U2TrKg7GhrzIKdT7R6sDaG95LA4QzRahL3AuXmjIrmKI0LeI3KhNcE+gwUska4
         EG20VUSlZokV9gNopHRiiIXD1aNOvnJrZOHIluuoky4PfyHOEetfCKNGff2aEm/BW60P
         zypD5Sae5VEeb9nQ2PYzL8kE2UGto6bwBShn66lnGiwrxvd8My5gUstFLPJVCXpn76l6
         p4IKtRmhW1KBSMjKDpZw/RZV/4X6NEvtsZSvzMBD8AJOc7KU23TjAY0g+WfRe1J0I89J
         M5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YNtwNnqhEyRRpVNg8EzN+lDMoQ6yIJewZ5GDTLfOXY=;
        fh=oLYhdD0hE+FOtPoG8XZrSq+qxFIkL/BzQWTAyOJt5bU=;
        b=PhSMu+hv0NFnme93oY5ssKM61Z/59/l+uhOzGWlW9r3ix4PAETe40BDAHMG1KLlMTN
         fCXZcpbO2uqwFKNyiSyuLaiWlAzFFTRq5JsAHOVtL9VgRK8M5IS3enrjz7uLmxGYarwm
         Yci/om/zE01PHe9jAOsgh/AwxzaLlRcyadVtOgrPcX2RHzthrKLhJgbwlbbbKXdQIV5H
         DmMCdnr5cCxkpVpRI/EmMXNqh79+xqjf4s7UDYDRd1/zsB+JKofwAyydu2dZ7/cRsZU8
         hFsBgBZZZAaDcNN6GXsbDt+VzdGaSPMZVl9lAbFGhsUfCg6HCxksTWsl3rkxTaaq4tUU
         PuFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791768670; x=1792373470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YNtwNnqhEyRRpVNg8EzN+lDMoQ6yIJewZ5GDTLfOXY=;
        b=IovhHvuHDPrFc24HxlYyZOelam/C7lTGqjHacte8+xRMqRlrJTu9AbJwZZRvWrbbFp
         VFLH96WTeyDhAjZZXW0yImXztnDKWJMcygBUoZmDHajhwHGU0zrivcBwGRChWx+bScrH
         fpukR9VuSwmWLg9rMU9JKLu9zIzHTc2qmLsZfCyLB77Clr77bbKHvkwAtzWDnSwOZ2g+
         3oW9Wlnw286rs+Ct8MrGLVluDPfnMLfwUXrZ8UVU0gWsmaGl92C/85iJrEzFD7LI82iL
         daGg8PQssEzg3iVtyS+eAXOAf6rva1oMBhxvp8VDtk+z9BVjxZ/O79oGOY2MejP3n8at
         b68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768670; x=1792373470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YNtwNnqhEyRRpVNg8EzN+lDMoQ6yIJewZ5GDTLfOXY=;
        b=YKrszsPLiDx7m9/8OwW5YUzH886MNBYHltpfcoC36yVV7kaRUJli3+KMSXMrnASV9R
         SRnvK1+BODyhzaxkQfAK5yaoP8W4hPP20aoMALR/Ola/F7HSsg/VOx4m0JHr7YkS+BHJ
         zF29Q57MAntykDY7pKUuv6vinR18/GNiBsVpUMe/jI0qayIYBCcwsNf2QqUh6BEekEBB
         uTyU9hM1hm3IxoRmyited8csEmj1KbrGyyniMjeOKI4WGIP+UuY4TMClwoaqCxjtkKm8
         pA91fpbIhQ8JSZSXShOROg+d6CAsm+Mt3l2VLBj73ibQcLt1xSZS0UNPjDbXTe9ipmjJ
         YFCg==
X-Forwarded-Encrypted: i=1; AKwUvBxaKYNuqNAljIvXq4ZG2qGqGkIkraiMCVGdeTJOTaJKPIwu1DbDRWq9e0TS5CZLFKMFz/yq4cGHrv+B@vger.kernel.org
X-Gm-Message-State: AFq9FYJshcc93XzcThinN58vHZmSnsz8NQsxwclAtJ6dVIj1wYLWtEOI
	nUI0XmmdvTTgv2nNxGeaqgW6WbHIOUZC0j+OyBrOfVSiBNBdHUdjZ+VqDAS04tA5kvq8StH0l2C
	/LRFy5IIcqRH84BcsVW0drH1M1D3xCWQ=
X-Gm-Gg: AYBFou0++9/QHqbvxdV7TUb29g1Q/DM7a92wp61N2lzxzIz9M3sKCi2tAySj0It/xo/
	4Ku6ZWJdSqEnp4j/vo6hZmO5erbHcAZ5IzXvtKq5qUNaODP7rmgsFbSllXK2RXM3vzY2MmjbyNa
	LleO8CMs/DFZWfLt1W/awOz2hgUJ58IYQiTP1Lzs0z34WBOWbk188dt8w7H9gwKOt5defSbGbw2
	Q/zHFW4kdIN82bMN99ku+zDuPcYuANLczcrNkSn51/AcccOhgCz1suEPvvLcYT3VU+l5use7S9v
	c02zxwPRTGCCeTzMhmq9kigRKfV0MS37gcoI+PiKp9TtclUO6dNc/Zw=
X-Received: by 2002:a05:6871:88b:b0:48f:e0f6:bd68 with SMTP id
 586e51a60fabf-4a2a8b421abmr6481919fac.57.1791768669944; Sun, 11 Oct 2026
 18:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903111328.805352-1-christian.loehle@arm.com>
In-Reply-To: <20260903111328.805352-1-christian.loehle@arm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 11 Oct 2026 20:30:58 -0500
X-Gm-Features: AclHuK-niUwLhpYe_kVt5YW52V3PgUDZ5R8udpP7iFVNpudx-8Rk0OjArTDOtgk
Message-ID: <CABb+yY3h90WhxRyQnK21NhUNYcD9DVaivpxQGv54S3CHUw9jWg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mailbox: pcc: Fix shared-memory teardown race
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, breno Leitao <leitao@debian.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:13=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Breno=E2=80=99s fix frees the PCC channel before unmapping shared memory,=
 ensuring
> the IRQ is disabled first. The second patch serializes channel release an=
d
> request so a new mapping cannot be unmapped by the old release.
>
> (I'm happy to have my patch folded into Breno's if that's preferred.)
>
> Breno Leitao (1):
>   mailbox: pcc: Free the channel before unmapping the shared memory
>
> Christian Loehle (1):
>   mailbox: pcc: Serialize channel updates with shared memory teardown
>
>  drivers/mailbox/pcc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>
Applied to mailbox/for-next

Thanks
Jassi
