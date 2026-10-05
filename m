Received: from mail-vs2-f34.google.com (mail-vs2-f34.google.com [74.125.227.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C43290B1
	for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186562; cv=pass; b=DDQeBxegwn0fj8vb0IHkhxLb5d+vHIPf5ebtqiwQZ/qlSH3DfCLskLrYYqMBA8HF+8LP7Bb7FMd4FVjF3T1xULkF8OUQhgdd8GTykHM7N8EMWEMuywXpMpeaw2MaAAfYYUVrerZbXXegGywd+uhd/qcppn9kH7SvM7iX6xXkixc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186562; c=relaxed/simple;
	bh=VxvVXdBb0Q9qM0U9L+sOJleMerm+22DQyt5XrTMDHw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPpJuxWoRaU6Wochxmf9Yeh30MRO8n7va4Z2gXMmZktx3IfSuhRuHEKOxy+xwFpXei/V2JfdYuEgXMT9IAXNg+qHwz42AVedtCRHi5eGqzJvHYJ8fpzpb6lK5neSIs6jp0q+NDWOQxGeKHkwxYvDybFX01RPo69Uv0K+l6gvKOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvDVNAMm; arc=pass smtp.client-ip=74.125.227.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvDVNAMm"
Received: by mail-vs2-f34.google.com with SMTP id 71dfb90a1353d-5e3938dda85so480006e0c.3
        for <linux-acpi@vger.kernel.org>; Mon, 05 Oct 2026 00:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791186560; cv=none;
        d=google.com; s=arc-20260327;
        b=eBXQqO/letsoIB1rC1OH4iI5YCYgqqccmNLodX6WgG7XLSeyGM6sNcHGHyXZSdVD2E
         7Lr7luqD/iUkbvSTt8RgYNWEnsNOZNrVuqbBjWLv0jzhLz66T4I7IVtjFDtlZmFtNJsL
         4Wzm0wjtVE8QUn/L/7N6mIGCHjJWRlI8HfU+KC2AzJf22GMRHialuwgni4DPERkaOXQL
         NSmVLtpnbRpke0f/pQPCKacw7P22V+rQam4aFVM2I5j0XAnG328txZ493VIb1yLluHd1
         vmQuWV3DFIdfqIzTHkRnceJg/eNOYQ4cA1dxEI4Z1aBXSuZBjmMSaquZfdj5EqqrZtE/
         wAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        fh=6nIcYaYhsBsqLCC2JyOcCyr3V+Uvp5Oj8OpmClcwcvE=;
        b=gAm/+z5IV95OMPUd24cxfA7zSjjbcOnh4VeZRHlQpk2Ag3bpdpIoWcG1r/CLqhZSgH
         ysHxeHOTbQO/JzDplA32Gd1cQrkZz7YlBomu6O2HWZKsLXyNMxXZcENzT+F1VkWgezni
         W8hTFFJm00ygX7EBG4izxh1eayVenoLuLMyX+CXgUGIkVqjXL0xmG3nwi/ZZyb/BgXEk
         hxPgBi6SzJ9taRtGJON50LRIwOZRzO1SoZ1gLLnfxLhRvw3VfRD1dWFoWbtB/bQIKoCg
         JkeJEESHglSsH+MWkSguCoae83f0/eymJJs+FkQX0f/vkuqGZg8SYZHR8LZ0PIoQE6Jv
         RTkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791186560; x=1791791360; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        b=MvDVNAMm5Apco/LvPRu7/v3PrX28fbFvPGHrYeh3nb4EEAWZSoC86rkKMlBN7cpi8j
         OMKIngMLReYrtGl6ni5G0c37L4QxvIYyILyg1wQc6h5qoEBbiHKuPx8ncQmOqjEoOH9D
         AwwgUko+Sn0lxZGsa73Yj1v1sWc1IMBB7G0n5vXlUsr6IdKxHjVvePgFC93+gdrIz4x/
         QB3i907RgwE8o2VYZHPGs7V71RK9yyprbbEwFPhbL1wch7RH2arqEnOUY1pJbrib7/5/
         mFeRYoNDefamPRdh4Mw8FxBmjM5DMjPAsp1x1JgsfFWPve06ZmK4AywF1vm4RXm5pGkn
         XzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791186560; x=1791791360;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        b=UhFo5u/Lznye4hy/iDhyihj9KQon2lHXViYW/3SkMKFqEFUZUrh1G6o6aBwuVbKL3U
         3e74ujk+SqeVEh8aP4QJoNQPYQyTRq9Veww3krNabMMAmX/mPhhvKIXXxiGhNZ84whXH
         HAAE/e6xmqXS3hU8213TC7ACnSLOAPQSH8S97Vq/60kSTV4p2K/mlFhmklYsz22EyTVD
         ZtMrI0SB4eHRo5b2I3cAI2mQq2SDfwZQ0jSpxUHUrTiKHThqeAz9htBjs/OECM++Xwkz
         98yOh9kh6nQ1kyVUIAldSNRY3Cjs1Zio35zmBnfaxDpqR2HxYd5o95CxywCC6VrNFah5
         gd3g==
X-Forwarded-Encrypted: i=1; AKwUvByS1vAXujrv/Zg9xByONAVkfKQ85sKE6IL10oy6xKr8hlEaHqrm6yGNyGYysJlyZqMt41lBDj3NZ1T1@vger.kernel.org
X-Gm-Message-State: AFq9FYL1/6GhCUTBS1FWszeJmkLiNr8iVXlGZLzbv/eDjgMz37EQnW1k
	gov/OF9whA+sPvVpEygPMMXBwkWgV1Qce6+QTldpO5MJ7zOUe4sX1UkbgA/KjtKNRAF7D+QVFjx
	X4lJSU2EsOBL22X6Bm+UqnoxjOTLkh+4=
X-Gm-Gg: AYBFou0/Nehf2a5adTmRFRMpE47L1oJgcvzxy3+fW1Znlz5LxJIB3O0j2jiPNhoTQhH
	ZT+xpAy0SvmS6angeC13yLW8OiiUS7cvRRPMu+1y3UQ5YgGwPBDbJtmOsUf4euOayUCHxN/knLu
	QQCL0T90oVPOhsVYL/gD4Fs2ZU4MrxoD3Ziq8uEQEm2SDaAuhmko2ezck2iNKSCwHQM1PuWwWBd
	JP7+hO1/cdtapWSBqiIaX4JnBS8dhOs5/9LRjmbjs+zNfFVjVqoexZgDS8Qj/AtYHqRweXgztWP
	zvEOST+0uYaAHvNy8O4rNR4fa0yw5K4qWatvCLrBfo10pZD+hiTWYuiEJIzkoyE1sIafU0tmwtR
	p1+znWC1kHpXq/kDu0SOR5VI0wj07Ym21y8MWGqMboVkTe5TjIJV1JnuP2+7JBHX+IqtN6z439z
	ele98KsbpHwK6GwUdcF5R6PrDsDJ5wPFe/wnf7l+YfrmUYERm3t5TK5XI=
X-Received: by 2002:a05:6122:8715:b0:5d2:f636:7577 with SMTP id
 71dfb90a1353d-5dab041c44fmr2930910e0c.9.1791186560164; Mon, 05 Oct 2026
 00:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-a7ab598efbc5@gmail.com>
In-Reply-To: <20260930-b4-elan2514-irq-route-v1-1-a7ab598efbc5@gmail.com>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Mon, 5 Oct 2026 12:49:08 +0500
X-Gm-Features: AclHuK8DOWIEo0q05q6gq0-QkBnvI9dA5B05mEZp1IjaXwekuF5jwY5vqNmLm1k
Message-ID: <CADeB2Yob9aevFYWM6QaFLybHs+5Wqq4UqmJNNQ3Zbtnz48VEGw@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: iamwaqargulzar@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional data since posting: the same firmware bug and fix were
confirmed by other owners using an equivalent ACPI table override:

- OmniBook X Flip 16, board 8DA1, BIOS F.10, ELAN 04F3:43EF
- OmniBook 7 Flip 16-au0773cl, board 8DA0, BIOS F.08, ELAN 04F3:43EF
- a third 8DA1 unit (BIOS F.10, 04F3:43F5) shows the same ~620 IRQ/s
  storm

Correction to the commit message: 8DA0 is the HP OmniBook 7 Flip 16,
a sibling model, not a second board ID of the OmniBook X Flip 16. The
DMI match is correct as is; I will fix the wording in v2 if one is
needed.

Details: https://bugzilla.kernel.org/show_bug.cgi?id=220854

Thanks,
Waqar
