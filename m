Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202623;
	b=r4Z35QhCD00p8JFqH4wY7gimbmvNgCaR3Qm/IBpi+TPHQ2SrGD24MAr6y9e6/wu4mak6
	 NdRjG+OEmHMEY60qec6wKKAXUguVYDphzCJH/FyUgDd4Ycvh+FqiXdDR99oSaYILjA4kt
	 fPNfZFwROuZ0j7FL7p7C44NKPQn+tDszsvo0plspGwULwby83hegSbhWh+wbIr3MjCH8h
	 tPx7BHzrFYBOypwWweirYL+cQMVRITFNB/O9vPzVPrzfrUrTtSwYMTJMLURx0YBz1Tk/B
	 XZo917AvfASMPtW+XOPmRKSCT/aNfJDlXapklnaQtcqXpfy2y7IdM+jvhw7jR0DSEQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q/7W+N8PGRXVivlXwZfu/zXqRkAwgaijwKLj6Vh41I0=;
	b=UJqVMNVK5NUlHOAF3UA/bFI7AKlyxPRotjfvqQldwqRKnb6b2QM79zAQlwoQN4LkaiEu
	 Q7Ts3eL9lDvVapp+/c40OMNJsoUkIetccFtM/vjkKFp6p7Og0kcrJdrn4D0bw/ligCBZZ
	 fOkLElJBWv1YFY1Kaatr0ynjEbi1l4z0apW/EGIvHjGJmucR4uwtz+vYBCcnjXqGdgpio
	 C5KRm7879DKBSFCpdrJQQMChYJF8x0K5T/F8QNrgPD9fXA468K+wb7vVmvYF2c2225NYu
	 lqMK5D7GSwz1PKqC753VK1dphtPGmlVEFZdeivOSU72gShZA7pWT/uEJbUye+uq2wqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=a1UIf7R7;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED287606A6D2
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 19:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED287606A6D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=a1UIf7R7
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so985484a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 11:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795202622; x=1795807422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/7W+N8PGRXVivlXwZfu/zXqRkAwgaijwKLj6Vh41I0=;
        b=a1UIf7R7KD/wYIUwBDgkTcz/P1Z86Z3/Ckat+nwKTOtGYAmAzlaOyO3YF8zmNLmiV1
         w/QRe0B0uf+dx2HpWVh67hf8e4emw0O+AM+LrsXLbSbLwVg7JwoflThxDKi/bsZaOf0U
         ptBeFUKuzH5Yo1Nsxnz/sx8Nzhb+u862g3aokXk5pmG+pLti1dA8JxyG4qzpRquX8gj4
         hR6447JnRlVFhUHTUX2AtWrvUuNt3Jt9emzG3YxTUuDT9YZ/ugri3IG+lmBs99omBl86
         XWe6dWPQp17ElVSwXRxbhP62tqpv/tCt4ihGepxTzBaAV+e/3o/P0rDg8YMtqH1zWnq4
         4YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202622; x=1795807422;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/7W+N8PGRXVivlXwZfu/zXqRkAwgaijwKLj6Vh41I0=;
        b=nN2VEJyjwnC1lenkvM131HAipCC5ld7B6tAwj+926SS5aMktda+fUywTua//x4L1HY
         xL79htvilkhdp7r36nRNQ6/l9BEXKY+Q23L8u7Sat18onwprkrK75vmygfawecAOtmCy
         EQp3kWeqrnLEXX031b2LJ5ZUTJNrpcpCfbngl5S6A4AGBc7Ep5yA4Is4x0rubhL87Cny
         udDB91vbbYUnB02RPIOCvItvl8I0v8gfniHUq5PYNQP1861JjKYvySUQ7b/vpQ5mXfpB
         JH0SNQm5aSFaQ5DuWToG7t61itfeGbKTf0AuM419bkNE1p9Aw+mnwpGS3cvcDA856MjC
         LHpA==
X-Forwarded-Encrypted: i=1; AL+hErFpU30KAcf4zk2s9cYBCevII63Icn1KC2ZnXp69xcEC176CUmmSAUjMugTbMwxYVVlFLNIV4pq+I9+r@vger.kernel.org
X-Gm-Message-State: APuU4Z+lqConpd+dpcDgwlXPuhp++n63uweIu4ZvmyybAL+q/V2UseZc
	Cb/Uze32X69cUICVTI9kj/tOL6Noaav0GF/Excy2EbgAUrH4ObcyUqXI7DJ3/m8ueea/PCPzZxQ
	Wx/qv
X-Gm-Gg: AZFdTZcd5HrV49of4XjTSZA3GPgmhyl28gk+gLoy3kv5+4N0ADDMFqwpFksIRYNwZwP
	yUpoS9jgBBqDvkuNxqTkx0Ie/Pyzhd2t83wCTJnXknCHzbakSgywk1poGVM79s/Z/+mZLaKnALX
	y9C+1Jk4PfxrX8Wv0+7jGgk/1FVHMa3hUMzZi7OMAbleXQQiLBTCAAxn/vuG2y1je8UMXghKHqI
	SqCm7yh51Ex64IAk2/k6lTR9C3TEEh+0zRc/MInTDgYxrdNy7vYLoaimVlmRcFZFxnhxBpgibAQ
	GgMVxNvtmR6/AQUD+cRd22spIr5Jaq5ozDMY8HFMrHz3zmw7IwbxwHDLgyG02luNUAxu5vOvkiv
	ENtapI7Xs2n8O0IyMkhrN4eZ+Ngm+k9rOm65YEup8IwjBNt1z078DyAkvmpou8d8cu0ZYaNjjXv
	iNfO15gag9YEPtF1KoV63lVHNF3vd7o4ufMJzO83LXpIYrNlNlQfCJtJTEPmeARSDX6Zq/aWb3X
	ty072l49bgMlgqFkuDP8xfVISGYe9D7gFHZGXtkTIdjUNApTnJ9j5vJZzwMBdq1k3WOj36hJcaI
	Tg3sp8hWJ3CnjZxpRAtzBWj57P0eYm49nziZ20vHHWvXORqHHYMLg4EVdoXUb/H1BAdNCEUDN0m
	Y2wD3hV0/GROMJgRURHY65Lw=
X-Received: by 2002:a17:90b:17cd:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3b41c900b24mr3971595a91.24.1795202622295;
        Fri, 20 Nov 2026 11:23:42 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:dd51:675:4b81:7ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm8367651a91.1.2026.11.20.11.23.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 11:23:41 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org
Subject: [6.18.y] Please pick ACPI platform parent lifetime fix
Date: Fri, 20 Nov 2026 14:23:36 -0500
Message-ID: <20261120192336.26131-1-artem@trailofbits.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,=0D
=0D
Please pick commit a9ba4dd2f18bf3f439d9ef0d8f375f90360ba1bd ("ACPI:=0D
platform: Use acpi_bus_get_primary_device()") for 6.18.y. It fixes=0D
CVE-2026-100072.=0D
=0D
acpi_create_platform_device() looks up the parent's physical device with=0D
acpi_get_first_physical_node(), which does not take a reference, so in=0D
theory that device may be freed while it is still in use. The fix takes=0D
one reference with acpi_bus_get_primary_device() and holds it through=0D
resource inspection and platform-device registration.=0D
=0D
The fix is in 6.6.160, 6.12.114 and 7.2.6, and in mainline since 7.3.=0D
6.18.y received only its prerequisite, upstream commit 72530e1f72b0=0D
("ACPI: bus: Introduce acpi_bus_get_primary_device()"), in 6.18.57; the=0D
fix itself did not apply to 6.18.y at that time. It applies unchanged=0D
since 6.18.60, which picked up the ACPI scan changes f234fdaae1ca,=0D
7617cc05df28 and ab06eb920401 that it depends on for context.=0D
=0D
Compiled drivers/acpi/acpi_platform.o on 6.18.64 from a cumulative=0D
x86_64 tree using allmodconfig. No kernel boot or runtime test was=0D
performed.=0D
=0D
An LLM was used to check applicability and stable-queue history and to=0D
draft this request; I reviewed the result.=0D
=0D
Thanks,=0D
Artem Dinaburg=0D
