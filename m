Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971160;
	b=d6c5kX32Ap+4YkLzhEWDWPv2nrZS6e4uo56b5O4ZTw6v+eYNPw3ATTfW5JcWPkPuOm9i
	 AV7j6mYPEjB28+NB9CkXXIeVhGDoGV9zKVV75NgA9PaUlubmtMN+C/fBpLxZoQaepTf4L
	 unIrpjJh5zj78TTFviD4byZCc9qWWELvVBY+4zDYZ+YVxyrM0TfcN4TLyw+6LHgNO8y+3
	 Q4/fvbJCb1SSe/TyKBvQQE9ve53vPB8Wyu+gmPxCZwBjvjMQ1e1P5rBnCyrZvFyE3/WUp
	 /p/TyYjKWZDBl1jORtWjqxBY8jTNfFeyNq5n9gubWaeQH49yrTy2v60AX6ooWDB5l0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971160;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=IhMAffZkLLvq9YdgBEn27sR4C5FUy5F/wfuofvZO1As=;
	b=w20TBT2eCwsSvmlWyZtAG7TH0JN6lBTDEpRr+BjC1eFIbLyJvJTf4L8YJoGRunIkVAMq
	 7U6o6oixS2sQi0exAaCWLxru2RZQ4WO/foGAQfhmXE7hjo6QdHeRJN3lh/Emm/VEHvq6n
	 RfMl7/wCeqBIzNQEwMEWj96A/SXKGnNXx5NH9NnXmH8XtXNFUT7LMFyqH/toMfh5tYA/h
	 RcJdSGIq7CIYdJCQKbsPlg0z2HlTTWD0Icm6qL8FLRARujq9r2od3FJjuMpS49judDGwn
	 wcc+T7s7OSQAhv6f0G8SfCOUVhrVmoVxa3HNFXM75xcfM/xxEVQNDHe8h4tPDs3lpew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=T28Kjju5;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF9606A32E;
	Fri,  6 Nov 2026 13:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CF9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=T28Kjju5
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jLfrx09CxzKmHS;
	Fri, 06 Nov 2026 14:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793971137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IhMAffZkLLvq9YdgBEn27sR4C5FUy5F/wfuofvZO1As=;
	b=T28Kjju5Ajsi8mLUmoylRl8GrHunbANU/NcLldCyjK2Srf9r9KyOgaqbgeMGqoHZubEf1h
	7o/TT2+0O3w5liaHcHgdfIT2Lzl5jQf9kqPmWiJ14i+kQUd1dPzblGZ6wXk9pxOk7U99kr
	aDmkLY5NFLgW83m+dsETy5g4zMnIwaVZS1aqwAdGh8AjbV615NhHKLW94zUPvq7c1kam2b
	qF1trTH3ff9QAtjtjiYtvnA9XuBczu3VEfTNUwPSzhEdyoUIEbHqNAq8rLr6JjaQEWhyRa
	+0w0NrJjVFPhtNzFGc6SpR6DLW+3j4C3qGR8vD7V+N/ShFpbX00wD5rwH8tRXA==
Message-ID: <52b51e8a-384b-47a8-856e-5e1e4c98e82e@mailbox.org>
Date: Fri, 6 Nov 2026 21:18:35 +0800
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US
To: platform-driver-x86@vger.kernel.org, W_Armin@gmx.de,
 ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
 linux-acpi@vger.kernel.org
From: Nguyen Tri Nghia <nghiant@mailbox.org>
Subject: [BUG] platform/x86: acer-wmi: Nitro ANV15-52 platform_profile WMI
 failure on newer BIOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1nbjm11ggsarqowcb7hrksugobbty8xb
X-MBO-RS-ID: 410a2308b127fb22f2c

Hi all,

I have opened a Kernel Bugzilla report with acpi_dump and DMI logs for 
Acer Nitro ANV15-52 (BIOS 
v1.53):Link: https://bugzilla.kernel.org/show_bug.cgi?id=222240

Unlike the ANV15-51,loading `acer_wmi` with `predator_v4=1` on the 
ANV15-52 fails to expose working thermal profiles with `Input/output error`.

Inspecting the DSDT shows that thermal profile transitions on this BIOS 
are handled via an EC shared-memory window at `0xFE708000` (offset 
`0x607`) and `\_SB.PC00.LPCB.EC0._Q30`.I have an AI-assissted 
proof-of-concept using that path in a unofficial kernel module 
`Linuwu-Sense` (Link: https://github.com/0x7375646F/Linuwu-Sense),and 
would appreciate any guidance on how this should be handled cleanly in 
mainline `acer_wmi` module.

Thanks,
Nguyen Tri Nghia


