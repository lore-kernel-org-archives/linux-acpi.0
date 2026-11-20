Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137145;
	b=JtktbFKaTmdMhMZp6/MXhh0bfFm/QMacpc9LHlDCYxtYjurj8LlBqkOZYdEXVbtUbGn2
	 mFxgLe7hp254SCTUZkV+/ZPfc2cEV9RIt6nu+YrVco64P62vXkFasQjwdwL0htlrQ1WkM
	 n0+9rC7XQzKc4/+gEXT9DXGfJHOGzUgyIXxBdKGLKS6m+vUC9WruXIzRQeOzjcKQf7lUU
	 Q+kC8zVA9u4BqZ9sGAkTYgzyMLJqzAjQIhmPRhosIZZ0lMCyRHATdFDcDh0cIQtkkpDfZ
	 Vy2F49RXTabv0kK9tgJNtGHqkPSCs5k5jin55v5pV8zEu+J7mPjOZj3BL1FQe0tD+VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RSvQtmGA8qR9VJRLGzOeM5PeV5O6KqCuP/U+uVUr560=;
	b=yy5kj5qVco29mUpL97I1yrKK/LjNQjHDVPRBH1U51aim9YitJVib34PQhsANhy2jG9Z5
	 zQ/2+h78jPGBkwd52AdH+HRcV1Ogqdj/m54EY7Q5e135BRqm7x6cLqb2xCNUAUIxjS2Ws
	 3unsPwiEHfET8n43wpyJij91SCzLgFTZjjOPgZ3LxQjJj8b/scTzQ+6wKzKg6qo40+OAE
	 h/7Bpnh0AtDkAY35blel/mSmugHv+lzPGrRy5abwEdZZWsEZRpqN/i1gqZw3auTNi4riU
	 N0Dia+FyW4DZ8E5EBYMFGC6khiuqY9i23Q6CzpVCLOdOt/fJWolDEGTxu0sFDmolZNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AlsGCg0R;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0857606A320
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 01:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0857606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AlsGCg0R
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a8cc11ac42so519083c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 17:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137144; x=1795741944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSvQtmGA8qR9VJRLGzOeM5PeV5O6KqCuP/U+uVUr560=;
        b=AlsGCg0RNzLQ9aozfabMWDwdTx6zgLTww/CasfLIoz5jheG5rBv+9qjwPU6qwNMHO+
         x0+OVNpFEu65XlBcE0mNLJr5oxh+YfZWLiqtYV/sS6Js4pDqXD0siNC4qnOGWO5G/Q5w
         Vnl8ItHWLE/jj6KJIZuVVpsqNf+QaZIu2MC1sYsFWi0SpT+68deTEJ4R8UbjpqIZaIXx
         +c7HqjbJ6/yqi0dhEgw/xysOptuPxNJkn7nt9ddo0AvdThz4+Fo3CPAVSbIHhYZv6yex
         LA0jaWKlbpb+0adE+fb34Nyiy/hZYikce7gjud9yDiu6DNah73lSz1L3HAjT6FNL1wAW
         Sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137144; x=1795741944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSvQtmGA8qR9VJRLGzOeM5PeV5O6KqCuP/U+uVUr560=;
        b=qjAWsLp/LjS7ZbVBjO65MrkFADG+fOSXGOtyEWT5eMY096YfWlLEU+437+g/A8QKig
         Uiqyu7G3A66CfURbcJQjAML/SRy5oimZm7hex6PV6qRtB1Fl2MZ+D11GV1gZ0gpkT3Gx
         IuQttxJxXIShcwF2Ne9M4ppFsFWXlv7bpL6zRvJ1NLSVF4hCv/SRDiqJWdGT5WyfHgG7
         /gGM9ot82irjw7XMIbDq2lkApefsuzdTYbqz9aKWhvymLb/9BJc4WDcD2PHWyoeMpuep
         yP3VH0MRT3QdKeOhcHmAIqvezwluxMsDWh0eszgky/VCSOIJMoDyEHRfhIFrx2bZowWi
         Eu+w==
X-Forwarded-Encrypted: i=1; AL+hErEFGhT5dwijqSBSBZXxoxyGGK4VDYPRYvtYEtIAJOHC75/ObWDgj3e+NLwztZZRnOszWCBn9H0js1+l@vger.kernel.org
X-Gm-Message-State: APuU4Z++eYXbOj9rRMCCxIUtjaqH9slrTFajunUgSFhx6N4a90cB4BYF
	DdcC7pWcfBEthASxiHStEp175q+f5RWLHN+/jXKdCjtLQVaOdC9zQlU=
X-Gm-Gg: AYBFou3i30ZhthJdip7PoU/e7DxW5CnjlhiUtiGoJSptlvdusDDnHdO0hbFt/lXVMH4
	sKBkYIAw8YgS9/yjwVUYBd9nLsfPvP0fm3hGBMJM3olopjkpFTQVzgdKUSKuJiZnOgVrOVH7ETJ
	B4hUwSc3SD7uM16E8O4u0126d+L1y/YpV3m7zHTRbB6qor/N4XmGXV7xEGX5Hm9pRYQWSqsogSk
	UxlYQaS7qOzdZlCcLknRJg6UUtkux54up0m/hkgRljzj2+q9XfrbWPZRobxc5P3sPTDvgtdqvcO
	blL/Kg4HsQAVzx5txwA6KE6d5majRlzQv00PwblqZsApP+qArbmle/ebH9kXFph+jSqvdQiqIAr
	AES4x7S3Nbka/YC8fKPQ93nGnWv17f8lOn9fHKGprggu6gwbervmND8jJAtlg9X2+Vg6ew4XNBv
	f9N8L/XeeRgDQ57N4FQJfO1FNT37sP9MRHDAhUKrOPyYDsl0x2FY/6fW2yoBF8uh548ese1+HSP
	pRrjklwVxLjthey+LKJ4OdcaCJeWWg1hxVuXZH2yxZ6llBp6YNXfAOyxmCD3WrGpyI8qdt/BJdI
	nsyZivR6o1tBKpyaTzTuAEce6SbFxf3ikeDZKcE2CrYmUgN5bIHjSTdq09mhpbk=
X-Received: by 2002:a05:701a:cca2:20b0:1b5:3417:9bc9 with SMTP id a92af1059eb24-1b5568ffe5emr1217643c88.26.1795137143675;
        Thu, 19 Nov 2026 17:12:23 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.23.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm2370006c88.3.2026.11.19.17.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:23 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: atharvatiwarilinuxdev@gmail.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH v2] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Thu, 19 Nov 2026 20:12:17 -0500
Message-ID: <20261120011217.1296-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113131243.28214-1-atharvatiwarilinuxdev@gmail.com>
References: <20261113131243.28214-1-atharvatiwarilinuxdev@gmail.com>
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

Hi,

Can i get a update on this patch please?

Thanks,

Atharva
