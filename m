Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822018;
	b=AWEZVeFjgMOcJGT8dP37xgPXRDiDDxhRN066o5FnyPZ50ZRVXl4JL8+1knyQVXc3uwDK
	 QOld+gHbEMitOVQ0go18JVhbPw/uEF97+rt+5OPcTTNM/ORGlILu/xneB9o5LF46Yr/vD
	 CFnOqVa+pe5UQLi03QJnDJGw3oIzDJoBWPeklPW1b7KKc+GOCbQzy18Ag/+yDxNYxPCnJ
	 ee/tRWC94hzo1VGn0y6H4CqT2PFPJ4XIdz3899EE+rVito5N2swL+EVEB5cs68opgjfFM
	 HZuL9VoT0OWJjMKx+nCbK63vPmScrb1RJW2sfkCpbwD4tJmjyEwue7c5O/vjvcV00XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=CzKek/Pq3oc5TdNtEUzC7qZSDq14o4MGXxlh0CTfKNxn0JgAJRB42NA5/TI+zMiPVu5D
	 9rnA/2QN1KWfQPVRIquFPYaiCMJaNS8ATx7YzGemVtcqY2h3n0bdeEn88glLexXFLPWyF
	 WZ6FudsUJDfS8jjv1yoznqGwbRuXdS10ko60jAhE2X9TGS9akO6QNyoucG6ZGtBne1D9i
	 s078dHADjAdjPGUb/dXXFYpykYeGG0SmrSByHWgBQ9MZJ601R+fD48P4bCzf7zov0Wej5
	 K1anZmDD41PKkt/H4sbWITp7VtaN9GFHUUD6loizB9I7+tf6c2A6ntVTnnIqjYg8+PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8463609609E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8463609609E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so1943050c88.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=qUPEHlTHuw2qwdXN9V/73TD1HyU3N6+NfX7o7Uyad/jgaO77PNTvrDENOA/cffsEYM
         kiMCjVFgediDV6jT/czQfjoYvCL9oCVXWo+JXuS4bfkICGvqQ5iwl22ToyBwtjXCvsH/
         Ab18CyCwp0zbf7tk9J2KR09RXHQLpQnvcv85kgcLTIa1lGBhtFr24PUY1cbPA5rraWmJ
         OEII4nsleCUhMejWc/gU2V1vIHqZxdxB1p8I6ORBsWQGVJ9LHM/EC9JStjrLd2jGn8mi
         6v74TbGkq1MgP9P0b1uqjAFAG/FrlFS3R3Lqh2o+2EqQWhRf7KNvNXY97L+2/UNa1Oia
         9Pig==
X-Forwarded-Encrypted: i=1; AKwUvBwij45NXQipXD/clha4BaVKeD1NvqATt7QtIBMSmLGHfWKG8gALwwHoiQgDar7pFw2Iai2NycZw0WQP@vger.kernel.org
X-Gm-Message-State: APuU4Z9LIOEt1U8BCR/rdHmsKyC7vr9Grkrlzril3vj2u4wSdk9x8n/l
	vpY7AYTlQUECeQje6/OidG0/y5hzHiA5ejF2OcZLBlSNlKdKOV7V98s=
X-Gm-Gg: AYBFou3PxSjH8v21Wxpkf/IA0O3qq5CArOwrzpoXq7qDs1krNc8B5VCbCjUBEjFxIgY
	hIVreUEGXa+6/nsGOlxKSDlyKvPrHQIh0yfFvkMQAQPTBsr6I2kZhpAO9AxZV55CjYpEP7UW4o8
	uc7QTIMRM1W/MsKRVk7nOyUng71N5QzVpGAl09E2eir0ykJAxM8kqu0/kKlgUceiC7WMyWS11oh
	iOy4LLtyZODpNvuV95ErmbjwzzyA40zb5z58DwHovv4N6hyxHDG+WaaPYmbw6MssMvW/ycoDAWu
	zrrI4vnwI32TBkram3/5Hum+MF1q4+1ssPJkxlVf1Z9Wf/zZHyJMP+owhZU6fwGCePEN0obh4cl
	cJKdtiiOhiejjQlZsFTsijScbB2Q/sStn3L0UlyCz8bJVC7i0CO/9j6O4EYaZ0Y5sd9VlsmtfVK
	Bnp5YIzRbBnvwkoAdC0BB5fmudzWxLcUKTfQP37QVZOhqwYzCwKpIgAeWXCozd4utDY13BhJZvK
	3Rb/ThUqvidizDkbYdVEuyZ8upnDuwjtTSHQHTa4lSqLXlGVc3yFNX6q2jruX0zLTccaaq5J0cu
	pV3IbGB1J2FcQ0Mbb2jtVb42inb5pqhf0LcIhl4D8OEOMIgU7K3mrMmcd25qoALQ
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
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

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
