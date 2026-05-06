Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BA277818
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033919; cv=none; b=tayLHXKakAGQ0KMldnCQBEy/hDI5VX11wJGfTwXXsN+VxTLdCEbAmKTErcIHg73jhemSwfI1VdpfTKA82/leqDdueBmEPla33k2rg7ust+FxKLFM7+ZZKWij50eJK8LwfuBbHJNR6b0DF2YN9mi+gZ+f2b6CtSGZl+DHRIaJ9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033919; c=relaxed/simple;
	bh=bpKuTDWLrq9nRB2Uy83zrkgw+0T+HWieTx8p+YwRkoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICLeLCjodUb4DlL5aXkMl4VRzouCf7v5ZhzTNpx7NxIfwfUR6aSc0WGH9BznCF36WLOy0o2yWWfyEZLPIhZzSzgAGuHzlXBLypoW/zZE6UwFJMIBFSZcCesuR61Gg+WUodXYuGiIgIA7whLbCvgF4Uh/0ZBNU/wW49IgjIx4684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLEswJx0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLEswJx0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso32379345ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033918; x=1778638718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8xQG/pi2YZ94Wyif4WkSnUaUizpmS2aclrnUnSYok=;
        b=iLEswJx0Kz1me2GcAqmFCKYvEnNaOKQOXFkWPHJPm3kXwAPzEId3NuY7C8CEDmNGqF
         EIyIFFh9BH2BMa6+9c2H+bw+UOfHVmfMmiR5zUdhQfIjoztgjbMJdg5gz4RVtfccDXbD
         4UpwLpWUz5GpcldKbFVZ1pe7jBetiCNpS0O/a1qWRw1i4FwLP1CNlXj44YWfKbbZr1A9
         ZkJ5tmBt1+ajwFCptseAfW5GlfkcxJfqyZuJurHbfV0Hz7SsMg7uQ6VJhXHd9fcA3tbE
         cYv/1kNrEKgY1pY6C2WxpeOZqSYkJqZef1c9CVi/2hBkgwvcyZXKFbxcP4E1lpUGYPA5
         C/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033918; x=1778638718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ8xQG/pi2YZ94Wyif4WkSnUaUizpmS2aclrnUnSYok=;
        b=NO9iKPlu60arQ3Z7wegStn24mPzE8hmAr5bAMi9Y45zNqCF0iSsKtWTABoHvYmU7Tr
         YRHf3e1iPF3WCIPHz3BKmGrp0ZCker8gCk7rt7L9qOdlR+8JCUEI5ZVvMImS+3fH2Py8
         ycbzsq8jyp4CNydWD+i3OaXgMCkXfMquDyw3SHNeN6E2vSTCLvwlircvYtR8xVjZ+pHz
         +LuIIw1fYcZC4mCZKIdA8Ahex0ia+2ptUjq9qka+U//lkfmrrVfn6An+403do0NJFvAE
         OgzgpqBZhzvSFZiuGkZQgML8eq7Lq4SKd0nd5AJ/VU6bFEO3GE8z5Yk4QK1S2nO9Z87C
         e5Gw==
X-Forwarded-Encrypted: i=1; AFNElJ/GKozs3BcTmdgj8RdQA5kWt5DBcPiKTe6y4Id0XnvaxGqYRPm9T+4vRfNei6A3K0ve06AlFKPZjMlv@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+B9gAcZflcsGd1Z+bwKtNPtRT3agICi9JnZURFVbOJxtv//s
	sC2ecfNzkO2rnUW6H3lZ0NXJLHnqv1E7fNxjpTgZPOUNRB1/hkQmVq5m
X-Gm-Gg: AeBDieudKlV+e8WWRWTzEx7YpVJEItLoDo/ALouDvXESKTeJ82xKpPV4Pxj1QtOU/OC
	QBugJ5khIPq3KV/LKaZDy3K9FPGaoeXlaR+3+TrZWle+F1Qxc3OV5b/DBPa7i52zKkQ66ZwThBC
	bS7icpl3tqelgHI+qrjOOj4PRwVDllmP7jyNVZCdeUWjXamjxJMuRnaT1lEmL0Nnvn+Bbo4VyX8
	YOW9Uju6WxllRA8AbP82aS1eNc4LmuEaRBfykn7U2IRJ/J2hlayguQuQT/8ovJRm+BBa3gT6+Oz
	Yb9ReaFXvvaLzwR40LDjTlf1FNSuRLqZNW3sgs3Nx0OJ9ldgegBPnRw5tyw/EbW4ZKZfrrP2NqA
	wqjHX6yWhYd3h3tNHf9Z/yg0qbHqlxrYKlemqIhJc74WPjJHMkBLOiZ1cp6AP583YyX2VrKwxzK
	wVOHmVAsynM1Nr8gP4KztdBW4Vf8bAH8ye4RPJqQSTrfnkhMCz8F3gDg==
X-Received: by 2002:a17:902:e54e:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2ba7a358d4amr14644345ad.36.1778033917583;
        Tue, 05 May 2026 19:18:37 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1ac6sm6319525ad.42.2026.05.05.19.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:18:37 -0700 (PDT)
From: "chunzhi.lin" <linchunzhi0@gmail.com>
To: netdev@vger.kernel.org
Cc: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	"chunzhi.lin" <linchunzhi0@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: motorcomm: add ACPI _DSD property support
Date: Wed,  6 May 2026 10:18:11 +0800
Message-Id: <20260506021813.3658669-1-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series makes the Motorcomm PHY driver parse firmware properties via
device_property_*() so the same property set can be provided by either
Devicetree or ACPI _DSD.

Patch 1 switches drivers/net/phy/motorcomm.c from of_property_*() to
device_property_*() on &phydev->mdio.dev.

Patch 2 documents Motorcomm yt8xxx PHY ACPI _DSD properties under
Documentation/firmware-guide/acpi/dsd and links the new document from
the ACPI index.

Thanks,
chunzhi.lin

chunzhi.lin (2):
  net: phy: motorcomm: use device properties for firmware tuning
  docs: acpi: dsd: add Motorcomm yt8xxx PHY properties

 .../acpi/dsd/motorcomm-yt8xxx-phy.rst         | 107 ++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 drivers/net/phy/motorcomm.c                   |  41 ++++---
 3 files changed, 128 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst

-- 
2.34.1

