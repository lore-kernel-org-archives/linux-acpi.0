Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5435F16B
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706527; cv=pass; b=A+nDizhQt8SWO9j5BJqRkGaMf7HdZJtjwuYoBmxobF/uksWCWUVex1rxhANaKgSxEEEriHyef9jA5cWCs+QB7aHZ+y4hmxyKHr3HA8yNmJPVGhzPw9+rqRIpZWGEIc5HG5Sov+RaxJmLrclPuLAfY2awVRjBLBAtaSRWvvI4BCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706527; c=relaxed/simple;
	bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=skcO00mfjSTC5I8rFoB9O5lbQ4vnkOqZbybtJqj8eFJogILBMZAvygaDXRpUYxfxq1pqzm+7TzM+qF84b3Wej9Wdb00NPMqEg0O4pS4brtrn43BVUsc5wara9gE1Oel4KPBFX1Gj70JvJtM3OnlUevA/0H0rxl3Zj2qJpcmHFSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V46GW3xD; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V46GW3xD"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-738bcf9a573so423790137.2
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783706525; cv=none;
        d=google.com; s=arc-20260327;
        b=KrfC+8MMeNSnbVRCTIIwDK3oOPhA05a8HvygK1T/+x3FexudpyngIL0GTnYaiAsmqE
         hdglpr6Pk42NTNFddz1e7JkBWVSeKMQBf3vhe3Jd5M5F0tWQEQ7/JxGrY2z2UDZUAE0q
         5cSe0wJ6025aR5yTO8HtWmR3bNxmkwc1qBJjg0Hoty/FudEIR7tOia2OLZguL0Tdrf6B
         gZI1JdlmA3nsATJfDLlBmOKZZ7h8biH52gSWWl01Xo2ragTbwu2ufUoj5K2nMLcp5+km
         m8uH4qsUrOr75o2ho8vGO4ql5MULHrztbkvYjOzykd37XjHsD4hktxRQMfIFfITlb5eG
         vn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
        fh=0E8vApQuMtTUv8fhG2EfB9GJw1NyJaEm3mHtPO+geyQ=;
        b=RWnJTrnwfozuyGQN1mS9VYfA4KpSWvKGpwoFziVzKnDndLbBLViTn6ZAq+TUMde0M7
         tF8IGuc/cvlL7eOYBh9yen0ze94Sbq/1C74AkxJAFqS4ckRABEkumFlFOeDEXMDZOo7D
         P5JNPyBSpXD2HdZT60krWpODEk+PToEETGz2SHlTEnUpnvpAS4oTudEOapp4kWg/Sl0a
         1s4AMHRHFD8vDgNnQXuNX7wfwqK8SsrLNqu4DrJA4lJIC5aD+TbrNx2Zhvu5ot9JiKiC
         oCPdlR4i2YYtkRd2f9p1pZDw2vyCrBj+DxGasqR+uMlmP30RYAFyuGmFgcQkn24YHlSm
         mW7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706525; x=1784311325; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
        b=V46GW3xDyuqCalswSaSs+FOepZBqwDTn5PS7oGv2+rGvp9VbepaultgHippZKbzWiM
         SxsNg4bHLzZ1ue2JBmnpBl8cGCT/iQ6K4Jln2bPLey4Oysfujj6XRxwIs1d8R0bhsBlx
         nsVnjkUeXCF74+jTGnyt+8cs68HRdwfOP1y0k6OvzGP7N2hk8HqHGwxFOt9wSYsVN/mY
         se0rzo1jiSG6uXKUYrp+Qndpen11+92KZL38xEyjivp+TtmZagFSVS3QpelugvEo5lhV
         1xP1xFILV42qOwS3GWiKSjUHvtfr4ZyRgSkgQ73EO9Kj3shmoICoSR856eQ1E+pAwIih
         UiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706525; x=1784311325;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BlimoX1CbriQcmrDmp1LB+hjsXlgxmYzLWDj/mXuzv4=;
        b=CWDAazuZ1+Uda6quuXHgb3mvcNZQJAdPwJK/l5woQBH5nYZID2xDPSkp4Pzl4J2tjQ
         LUqviGbh788uhEaia4J1HyKV9STyepyn8xQ3z8/N7CLhdwJCa9ecE6LmIFF9rPpcfRAu
         hwkqMd9VEOBz88M/g+GXbhet21K1udjxajjgUv/QNCdStMXw8yF5BaKZ+G6MPJi+f/7P
         BaetNNHVWQR08STtxXpBWXZ+X+J1F/8h2hOu381i6ZOrPS3H6LIpahd1+9XMU2zbm2rv
         zH/INOnB45QoGiZoX6HsMHMbMk9ffK4JtLVYiUct/LKWKdMDXuKx5XzcnQQ55mRtavXm
         sCqA==
X-Forwarded-Encrypted: i=1; AHgh+RrlXhGzQ1PRqQykKbciIvzr8GBmS6yi3EI7lF4gtlkrHn5jea4AF1PspLi9QwA4PZwsSqpBM1Fdw0R9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AgrE3BwPhubdyd4N06AQHwnxpihEl5f0Fdr69sQFGQr5Bcmk
	ic+ElDVVmgOjZmWhbUGVq3mD4Q0A8a1SY3eEeelUispvWnxziQwCIqlZ/QGBTEXomtVvMSWjDY1
	V4IV5PXUuTHYzqsRN17IHbcYWYWFaGXg=
X-Gm-Gg: AfdE7ck1lVT6hgZodakyFgSuiu4bH+joZ85W4mYMZM2dApV3oTysKJJTfnkcDJVerIn
	PpXUUQSLIrkw98HKv/AgnRXRbx4YfWIEFl8T6cbbUKx3XKKkNEmic8WxpU2Zi++cGAdFjQwVaoH
	SmXSz9T/b3poEEzs2pZpgUcc1Z0iCkoqPtjVo43JHXwP9fzJ+yReZ6BK0+ZBV+WIxUtfQadRsyr
	VIeN9LVguk3rk3/nKL+qIluzbb6T1zl/B9HA4FReKqscbWRbpoq2QU2NhHhnkzQltb7hot+tiUt
	+BHIKtXJCKwg42IeldnoqZ6UGqJkz0b37fcgti90uq0tCcd+x9G/MUYQJZF2bNcYv8iziIWazC6
	n6BQmUBoHQUXb+DCeOI1bIoiCJX7PjQUUrOo2eokCb/UrJuKy
X-Received: by 2002:a05:6102:6891:b0:738:d6c:7104 with SMTP id
 ada2fe7eead31-7453384d14amr296475137.0.1783706525271; Fri, 10 Jul 2026
 11:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Avraham Hollander <anhollander516@gmail.com>
Date: Fri, 10 Jul 2026 14:01:53 -0400
X-Gm-Features: AUfX_mwWzHxqlsdRXMKYl-ddla6vBJRXE6CpJ-JSoQ7f70O37_nQ9val2xs48eM
Message-ID: <CAP1mzZSp9A5w7ac0Qh-NAdtT+MoerWxYngfQYcm-bVF5yDWd1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ACPI: battery: Do not generate too much pressure
 on ACPI methods
To: i@rong.moe
Cc: jeffrey@waelti.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rickk1166@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: Avraham Hollander <anhollander516@gmail.com>
