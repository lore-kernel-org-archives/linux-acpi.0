Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324660;
	b=FX4eR7sa9rpHFZEvqEdwZ8IkqDsCpvCCqoDLzahfTI4w+B6yuQrc9WGu4xseRxj8n++h
	 lDxbmfqpcjxSxk/PiOIKHfaRaKc4LvMyTniAtrPAKov/GXHIkYtVpn7NbjhDI7J4h7/lo
	 xrwVNIMRb6u62f2NZwhV/wj84PuD9MsZ17zrJA2CKHhlwEA2yP+y46nyzUZOFEgei5W9a
	 Rpw7x3L9HdorcWBiXkULTxfK74ud+qp3ghnZx7v9LRS3PcPXxpY5VTrnBm9SHY8E/OSBa
	 CcLgPBelC+gF9TfB/i5E+Q1FafmFoHB70SUdl5KF/kG4ZhDSf2DUsT6RSDxn/SLc5Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZvazJCzZP2XVKss3OVQ/bZyxevLo2+jDWRDKDN/d2kc=;
	b=YAu6WG5Cz+s9+jzrISXRl1J63jxNu8ryhZ8mEWyjEyfMZQLswMTpigk4KIT4CyBtUKsn
	 X3tCUC8nqG8XOEu6kzzwSMoxgDtmKxPYHQbubJKFJD6K1dNfVorqV0+22GUbT2ncB8woc
	 sNxbKMhcGbvsRO/Xu7W0g30uKrmkCcmLt6jXp6W4dvHt8jTjNBbR25OA5/72jrDjNTQSh
	 gkuDx68pjMMWnmLhQRgQf0BR0wLAQcpgHyz/x7OVtGlKe6w3ddCdKK7h3kxCenJlFjaLK
	 DxakPBy1JfYn9j+pPUBocEck7gzpa3wshUOgQC9c4UoB1kJDDZ7ahtQ0m1VeQqBs+Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvQALK4k;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0D606A31A
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 01:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD0D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvQALK4k
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso441946eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 18:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324659; x=1793929459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvazJCzZP2XVKss3OVQ/bZyxevLo2+jDWRDKDN/d2kc=;
        b=zvQALK4kGqckp9LDqAUjf94qezbC0llhqT6Y31QehbsjW3F/wY2M8hjOuO4vaowq9G
         dgROSzGA6R0dyO7Ie/JoZSYstGAU6PFlQlJOpmiy038pK3dEj2r3P0EK3fYiS1e72rBM
         sE6cXDeUa3+m4w/kLauqmiom6FEIl4wciyxBHQsrKVCLGO+RcEiLrnTrEyA+hbOs8xdH
         C+rc303e7nIMJtIf3QTNY9Qk26iWM6xMDBMDS8z2Rx82Q65a7+qc3TUXvPjqsBOhqgR4
         lRV0qCOWdXlKYAe7B1dfhOOz0xNbGofGV13Lckk2DofP8M3MszYkyj1+RZ5TLj6K80E9
         JACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324659; x=1793929459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvazJCzZP2XVKss3OVQ/bZyxevLo2+jDWRDKDN/d2kc=;
        b=mmyaxb6fuWwtuXlI4bQ3RlrMO5BnCB/e3ZWuTWw96JyLleNUcH/vWZBUsbyMUFWsXi
         y+G5y+RjtYjc6j/ieVjMj/GZ1pySbLzwTpVvMPw+0dnss2DieUAGrkVFtHQCYM+NB2/G
         Ib/ev105iHEjUoiUsjNyA2uCr1xyu1AkrFhTvZRnXVyKl2R50c71kEXLmbEWhDIyD5C7
         21RfH5Wng1SVuyD1rsYYd+SUKgQLv5r/zKYwq6nHcGDQEQrxn/PmuqvuqPsKWC+JZSfC
         AFTKFuVkwFu66J9+QrzBvwwdSQAN5rBbXpKd0qFIT04jhHz3PkIWuhcCPE+y/SLHaFMf
         ZmyA==
X-Forwarded-Encrypted: i=1; AKwUvBxl7qH552X2nQwY7LOSuRKD+eyaF5oNr2pzDlOEj0WWN2rMt3HPP0Ytqcyy9mZO0SpghktNv41HPz8Z@vger.kernel.org
X-Gm-Message-State: AFq9FYIsI6CckFQc5CioopRUJzphSY/PxuXKz3Z95IiHSgcWj6OyzxK0
	Fuz2XtZmJjL/qKtcgjXQiKce/iomQSnIDx7yl8pEIzKuv4E265dXfcA=
X-Gm-Gg: AYBFou3MBdWurRC7Z6LicMX4XvavBv3T5x+otRzYym30TMxBNK875cwQqIeHmT2uUra
	8qdko2tWpk5ieaeeY7SmDKvskatDsx/LC2vGc2nNcC3BvNqCZuEJfZjq1wakzkeeRMB24Pa5H6z
	QNxDL2w1hZQ3Ve0S7oVaPh+96iaqU/JQC3jJxn9ZHZFGusRV0Wwx3mfnhX4a2VxL8gsmMSv+jw6
	FJcgEy2Z0MebvYMWfPSnuCfex7dIQUGYwVAg/w9eh4pZgsCDOF33zhEu2Uvyen7MPO/9J4eefeR
	469CGvdcTOrf0YNUcmRZd2UWIk2AF5uOoqlGHPnUp+HmKAnvD3HCPngYOoO/aZFWRlNKUMoNu0Q
	/xFZ3VEXYw+1s8I5YuECOl6PPRy8lR9W+dyegnDFInMQtc+zJEDterT4m8BRRR0eTLcQCh2cwjn
	KCShCToL8gCIBkc5VglkUGu6+nmtnFBnkxb8Ur70x0dmL548+0sjsPWHWDCeqd8BcEkd/SHqBP/
	YU8LMtMnWdW2JJSsIGBin+alfs2bk0B1uSkOlJbH7hjkQUwcIK54YH3eYQRc2T5HVALf5hJRaTh
	qyeu1nSbOwOku2WSk8NrCA7bC9ijbIciAf+Xc1+b05jnhTQFl4IxiEKJ+0kIro4ldFc=
X-Received: by 2002:a05:7300:471a:b0:36a:2382:7dab with SMTP id 5a478bee46e88-36a4232cda7mr1445004eec.6.1793324659103;
        Thu, 29 Oct 2026 18:44:19 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.112.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm2381425eec.27.2026.10.29.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:44:18 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: rafael@kernel.org
Cc: atharvatiwarilinuxdev@gmail.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Thu, 29 Oct 2026 21:44:12 -0400
Message-ID: <20261030014412.1652-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0jv9VQhZKbQcWYHEU0sQUPn5sLsRmqHzEtZ4T6GY0t3ZA@mail.gmail.com>
References: <CAJZ5v0jv9VQhZKbQcWYHEU0sQUPn5sLsRmqHzEtZ4T6GY0t3ZA@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You haven't provided a motivation for the change and I know nothing
> about Apple platforms, sorry.

APSS provides more P-states than _PSS on apple macs, for example on MacBookPro11,3

_PSS provides 17 P-states ranging from 800Mhz to 2301 Mhz, while
APSS provides 28 P-states ranging from 800Mhz to 3500 Mhz

Same with ACST, on Xserve3,1 _CST provides 2 C-states (C1, C6)
while ACST provides 3 C-states (C1, C2, C6).

This is also used in older macs only (before 2015).

And also macOS uses these.
