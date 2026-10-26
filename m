Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016074;
	b=MFLSGY+tksn0ZKdMmotGtn7Vig2FDY3abRccsPI0rvS9Pd3DVRqxxxvgrCAwUoLCDit9
	 DWcTf5XKu93jghNYZ+qz0TAyCyTTryZYqdwWuhatmRMdG0sqY/HMKtVph9qhpGEhB74tX
	 LjqjGJl1ZwnX2Y75UE5d+0/k6nc/KtiZpCDH0p+KIsl64FASud+13qZ/milRNvqengPLf
	 SgTzjYHbwIP39+DCatP66eqFKadtkaDlTYAgSrVZ9oSsjj4pprcUbkQ3mG+ifditI1ipM
	 Mv60RvAGZRzdWTJTb3e0yDSeJz7RVnmLjhqwk+UTSX7TmJiMv4a3oDoPZOfnU5YEqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016074;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=oO8bSQJNywcaIvFAdAnozx4kB5xY4T140vDo9WRu+mg=;
	b=xFjA5JvL53++rDUPKycE9dZUe52TybvhG27UP+sg0EGmjCZziQMqlxAOyyWu1ZcMXzcc
	 lZPFdBo9qQdhN2rFH6JQidmVL+g+uNgcc+1VxiPeHyjZVzr03meOFE1U6LS/oKbjvf9FI
	 g1DpNc6m3wwlyIlO/ehAVZjbYo8pik95qiyaKngL/qkj7SaBQb2Vet5nk4qpdFP7B/PKo
	 oVnpxD6DU0f8ucNATVFO/v3LK3dYTJMKzWMQ3g7Ss5cP3jecuWNire1mOI5/REa77kayk
	 zn3wa/gtjC/vz4QtfStSHD6I64dGcPVfL1XZNZsFMnxuLaDj3QJNevq3anGfvg3Xhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=dHCxR0fg;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C6606A332;
	Mon, 26 Oct 2026 12:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54C6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=dHCxR0fg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793016065;
	bh=oO8bSQJNywcaIvFAdAnozx4kB5xY4T140vDo9WRu+mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dHCxR0fgnSey0oAO5xjTrO2wZ+6qavIPEVOYJ1JhhmM+naXSpJXxHwqN8KB+JyneD
	 T/ljsEo3mW3nemsTraZfHeAu1bLMZqVatXRj1ycMhO+k9SX2+/P6RdSqtjCvp6zXkz
	 nzubOKndu1rwjk9utzesH/gG2GEk2PhZHUnzIgA8=
Received: from [127.0.1.1] ([223.66.54.214])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 430F4CB; Mon, 26 Oct 2026 20:01:03 +0800
X-QQ-mid: xmsmtpt1793016063tid348389
Message-ID: <tencent_529451EEDE5869C5DEE85310C49624F80506@qq.com>
X-QQ-XMAILINFO: NmYPxqSo4aXvmzhmY/DIqJ/Ksnrs9n19r1JIAk6h8e0XVIaHcstq3Mr650ptjO
	 aw0/e3xR5QHHOMyNCXGWAbx2zmCCvyEUipPswvTh57+LfK9I1tWatyflNz97StM79StA2qyN08oj
	 jU3WtaJM6ZCJK15DI3osIsRolCFhAtMtU7bF8m9/nmbJSUuBK6bHjZptkGCvOpod7xzIsip5Qij0
	 yauUyQRK9788GzvhnPlmJg+40cUS3Z7JV/VBDjt9o/QWPH2Luw76MF/2pZIlIYkNPeWFWzBkg8rA
	 3boYuhpccuGMQa1HoozIyIJ+TgUvoJ401NoR1O8qq49dpw72SkVX36C6SXRDBTkkHrqCSI3D0NnX
	 WOcqZWBWU0CZynpWK+9Ugj4fKh21CAl/RJOt3ajrfQjKME6d+F0qSMBkjOvvRMcGvIRXnGrt15sG
	 qo8dMWi6MFw0tXUm6A0TDcCH4A2Xts3RO+hac6sginpGYNZXxHATP1mJw/qg4VDLeyET5q9c48Fq
	 +r6MfU9S/JhrIELvYHqHT7Z5NqX5fU5P1NXwDl2uuqIpN6ni48+GJbGrGhXx76CYPPKje6m5IabP
	 FVkCex6aKan6yjAXwF7G+/IcfIFWHLd/97PoOtzluhX1cYU+NirXSEn07xneI2p3gzfu/+SzlC8F
	 Qeiv70/Is8XJaVyTn5EHUTmLDays3iU4nkAIZTnv7LVtkFLPjF/tGPEJtm0e+RMs8EQOBK3GuIAs
	 Y7BMoB164HrunUvL6EeKMiv+dj38Hx7h5T+vBc8wFqd6tRN5O94R2xT8dWZY/AqzPpiPomQX4skj
	 kRr04Hn85VNMcIbyEYQO7utS05cMn932SoxaM7ULPw5NaZyzT1zkYNCP7vbE9ehlH7uesO4p6n1Y
	 ZUY+S1R7dd6h7qNs3BDYDT/YoRpoIdOUvwlZWfuf6haG1z5viMZK5f5E/jZhxgK/A1WpKl+Pum2b
	 sMNAxFrIFCeYiAdM7Nd2W2KVbt97HjHO2G0ANCFK42iRf9FMjgrx9D8ftwVcsyXeRnONcMUvEff9
	 gWp0c/tsyaDTxAo4h6y1YLiQXUgR0fJDcURbaS60h/rMk63Nzd
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Wu Zhipeng <zepwu@foxmail.com>
To: Alex Yeo <alexyeo362@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: Re: [RFC PATCH v4] platform/x86: panasonic-laptop: Add
 platform_profile support
Date: Mon, 26 Oct 2026 20:01:03 +0800
X-OQ-MSGID: <179301606309.13375.996972986562937156@foxmail.com>
In-Reply-To: <tencent_8D20C52D31F04EA8CEDCB3B1A80A8451A707@qq.com>
References: <20261025191300.1259541-1-alexyeo362@gmail.com>
 <tencent_8D20C52D31F04EA8CEDCB3B1A80A8451A707@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Re-sending the tag as its own trailer so tooling picks it up:

Tested-by: Wu Zhipeng <zepwu@foxmail.com>

