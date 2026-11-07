Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062997;
	b=ThdmRMl/B1POMuBixH15iJaYfyPWLZWktRQQE5lYYHlxuh2C3Rshe2nX766aAP+61+xe
	 5cxd5sdxlnBzeZIuymSX1nr9bBWBphXyOh28or+iKKNZaWmpxQPY2FsJl7ggvOkHfpwtg
	 wqNGCO7+GkpD5OqKcClvtfYHgKRyex10aomv1Y8zgYHpUbAKMF2aI9pp+OeNa0uGVsY8O
	 ETh8Z1Mmh2w3D6wfVc3a0SQd0woBBa+5NegL1BbiqwuNIozkqvw8AM8MV5M2gcgOKQ1mQ
	 kGKQrIS0+oO74KSIfs+qfPjCpR+Mdk3WtBsKFkBrG2XUvio+hDVWWUOV4aKP0QnynvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062997;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=O9Q9fynI8sCRQ1e7Ksl1HSfFJKEGvWX3W0E+oThOlJc=;
	b=Cq45DtZwBMi/oBk3lBu3KHnSiwbWSdPVrnzbpR0u2D/21AvtzNfe3TUDJbStsVtZtuCn
	 kYeG+Zpv8XylIV5Biw6sUAUNcLSBCTn1Kcr5z2tzOETvGY14BR+GJny2/eQNl6v+rDjt0
	 IpA2+axwHDgcDAffPvv69q186grkCBAz23o3Pk0fJ80nfyeK7LLP8EbezHw1/Bs64QvLA
	 t/WAypovzIsaiFMUrzMA1LlpaSFWWxBMfuYoryqdKQqoIPzVb45E2/nQHij5zyGpIkx9O
	 sNCrgh/WZBlMkrfcDj9AVE+lcDyCHls/uQk0ETuN+MVp+VWxOCKPLAbEhGZZb1EXi/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62C606A330;
	Sat,  7 Nov 2026 14:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B62C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jMJqJ0kgBz4xq1J;
	Sat, 07 Nov 2026 22:49:48 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A7EnjLb045908;
	Sat, 7 Nov 2026 22:49:46 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 22:49:47 +0800 (CST)
X-Zmail-TransId: 2afb6aef3a8bc87-166a4
X-Mailer: Zmail v1.0
Message-ID: <20261107224947551ViilPBGbG9VMhr7hHFr12@zte.com.cn>
In-Reply-To: <CAHp75Vcv03fUWx1ebtZtGsURL6s7DvnKPq4K_Zr=DT6OTjc=PQ@mail.gmail.com>
References: 20261107210058841pJqeakmrIVxw9Uu1aqCHK@zte.com.cn,CAHp75Vcv03fUWx1ebtZtGsURL6s7DvnKPq4K_Zr=DT6OTjc=PQ@mail.gmail.com
Date: Sat, 7 Nov 2026 22:49:47 +0800 (CST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <andy.shevchenko@gmail.com>
Cc: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <andy@kernel.org>, <westeri@kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <rui.zhang@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQUNQSTogbHBhdDogQXZvaWQgZGl2aXNpb24gYnkgemVybyBvbiBkZWdlbmVyYXRlIExQQVQgdGFibGVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A7EnjLb045908
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 22:49:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEF3A8C.000/4jMJqJ0kgBz4xq1J

On Sat, Nov 7, 2026 at 3:55 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> I'm not objecting to the code, but this is not a fix, it's hardening
> for sure, otherwise your expectation is that we have such a table IRL.
> If so, this commit message should have a pointer.

You're right, and I should have been clearer.  I searched lore and the
web and found no in-the-wild report of a degenerate LPAT table, so I
cannot point to a real-world case.  This is defensive hardening against
malformed firmware input, not a fix for a known bug.

I'll reframe v2 accordingly: the commit message will state explicitly
that this is a defensive guard with no known real-world trigger, and I'll
drop Cc: stable since there is no concrete bug to backport.  I'd keep
Fixes: c55d62820efe because it is the commit that introduced the
division and it keeps the change bisectable, unless you'd rather I drop
that as well.

Thanks,
Shao
