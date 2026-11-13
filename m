Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571508;
	b=Vbtf45D2tbJQxUVNVBH6UmR7sgvodGXi+Z3Fo5HtYcTmyWkIMDxgKeHR5zbX6TUxSqrc
	 51UrvXd/y0EYnWiVcqasxIy0oRqx/pR2DFY/ePVUHLOkaf1ptyMWjsWCf9GbeIXe5KfuD
	 VVRVcO9VMYcTPGY5FBbkyDqBB01Hec8KIGpj+zCDAn4V4gnsOtJ1jA/BzhWRcBe+rPFbf
	 PX49E+jkWEvbz4i9ERpaOocQ4RDioMhLjrZ5WiHTNufKxIDw8jMH3sKEqevVrVUSXaJ1d
	 lN5lGjvNYndoUwcd/iDlK5wRh15cOHAP3WkC5egaUCC61GkNkLlECjDYF5eVyqb+JAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SVSumMJf41m2t1kfH4cBo93/dZv3LW/Up6VpBs7ax7k=;
	b=P6ZuGVvQNac1xD3ECu0f8yYLKcI+buM5L9EMzXvSSM57dJCuDR7iyYByplk4RT+Zfqwo
	 TxSodWh6EjdjIqZHyC/sUqLmpn0MOJ2JSVX2lruznqAyHdJitCT/wVjxDLTtogkE/p+5t
	 7IipG+zALl0NRpDdY6JAbu1up/BGY6BTDmZFyXT24EIwCTIxrnAeGzHqV0M/k3QRVtU8D
	 xJE8mpMIwzUZulRA4QavDLVk/Yuohh8CT1RTK9wBWTmZwKoyGjosHo/oGJiXEQARFszHI
	 d+sMYscgFK106MgyYF/1/CewR8DKypDSmX4ZkJ+UfrZuC5fayjGZLjY8Te0qEguCpfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKM4Kj6k;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69213606A889
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 12:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69213606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKM4Kj6k
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1aefd1bf74aso628406c88.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571507; x=1795176307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVSumMJf41m2t1kfH4cBo93/dZv3LW/Up6VpBs7ax7k=;
        b=LKM4Kj6k+92jKdvI5GTxqjdQpsk7TFvgGgJoS/rmOaYB06loopKAmN9v+BgMBL33H7
         EsWKdONaY86Al7F/Xh0qUIh0CjPM5BbM2prskdcvJOuKuY/VzfCrF0shfVgUbEGRaA9e
         EciXOOcm4DZTvlp02zYZlJIDbsgO0d68TREEy30dZKeiKFoPlr4L4ULfAOJk1fcibY9h
         oM+jEM62FuHmW0WcGwRopgw4yHB2HdZo2dxTPCoKqeJagFplIok2ojp2J9zaRAkl+WV6
         MJXEBAxb4XwIz6gdFxIPpbYhhNfLLkZnMKyjV4krx4Ohod1indS4xHnerHjHfbLDE06a
         6s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571507; x=1795176307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVSumMJf41m2t1kfH4cBo93/dZv3LW/Up6VpBs7ax7k=;
        b=HWVl23f7EbffHA+y5AS9FUKS3zv7py5X0HFHjHh8V0w+14lr9gWxid21dTYFnFwNoZ
         GwNoQIWhiEL5hbSn7PltuTStb/RW7KM+UOy2e8Bs2vTrkYWW2kkcQSxGIfUc1G+agcKv
         ZNb0SDy2tvZvCh7cEgE5mLGR6187xYm8uyzb0VFIGksXUgnh2GHiW+eltkVJfGmO3ZTD
         WaXLuzVtcnTYS08Xak7i8MEweRIYP+7N96V8iLNGkdyd+bmg5mTJyUwni3SRMlt75+HX
         rI1mx9qbZ06YjQIzWDZygPmtinQXLkLFUWxEcDqwf/usnwhe7WGv05IIq6fe6Bmlj4Od
         1uXg==
X-Forwarded-Encrypted: i=1; AL+hErExOQHEf582yYFYgzbj64q3v91RDJCb2X59WZyCs+htsNeJtH6D01mNiXjvQVdlfAzg5Pj/sCOCfGs7@vger.kernel.org
X-Gm-Message-State: APuU4Z8v6bOyHNTyaDGKZ8lFIRHelYqMLXiE/nhB3eaxa0m3BciU/hqp
	iaEUzPdnHKniJDrJIYd2sfRefcvByQYOrTN9rgCwV2V4Ld/ydljXo5I=
X-Gm-Gg: AYBFou0XabYJFf7iW2xgAYLYMEy9jixAS5ozRo+hNpQ2qQeKrgaGAJrrelCmurkevpO
	3Yf/+tkGQC9syL2X0z55OGeITxdKKot5JUZeZVzWY2WAIxlGJf7TlIGEImNTU0UGRIOPQsKtufP
	2hpUFgEfAvY1q/3LEd9sJny9SK/gduK4irOkAuzIG5ylePWEIOeVjgyJh7j9mtJy5jiaArbklud
	+0dP7nmXXqkDNNiDqdIhNd4pH8V+sD0dT3FIplaggfz2Z44IZsQaX4mxFFs4nsVCCNCKEiRQxZk
	NIhng6wqdHdomii61vhHw4CJPJSNM3yAsN7GWCDlcWyLvhUiv2f3umhl+PtJbJBETf5XyFJsCJr
	eOXa/lkdYM7PuPdH6mhyBcioPtqaBkJmDHr9onmmo3WQ8GonhFet9SUnDXl2ds1n4YL+nPU9G7T
	AAiV8vegLkJO3vJQXn603uNdFlAmQowLeQlTewzYiblW/v8XQ3tejKSbCYsYiVu3nB6jPxwc1k3
	lZ3TBAfaSwE20sq1wGqJq1FVVNHWdj7qLQ7EEfMJ4PFqKMpoH1eyw+0cn0utH6zcp3aByylGxNH
	wewNv9Qj5TkHBPG6mUhR5FqHOAHJ68tbtsIMEFvtY6wnD8mUPzvFpiwFnHzb6zeAOA==
X-Received: by 2002:a05:7022:285:20b0:1b2:3e1d:17ee with SMTP id a92af1059eb24-1b4f5f1f212mr4239072c88.9.1794571505635;
        Fri, 13 Nov 2026 04:05:05 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.205.242.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm8146246c88.8.2026.11.13.04.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:05:04 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: rafael@kernel.org
Cc: atharvatiwarilinuxdev@gmail.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Fri, 13 Nov 2026 07:04:58 -0500
Message-ID: <20261113120458.1170-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0hHOKFYS4D+CLRiCF0hiRK6SOY=VKJ619rTNauipnHsrA@mail.gmail.com>
References: <CAJZ5v0hHOKFYS4D+CLRiCF0hiRK6SOY=VKJ619rTNauipnHsrA@mail.gmail.com>
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

> Which one is used in older Macs, ACST?

Both, APSS and ACST, i think they were discontinued from T1 macs onwards (so 2016+).
