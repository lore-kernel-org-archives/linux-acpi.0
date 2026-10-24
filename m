Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820902;
	b=M/3EC22mZU6hiaTeX7tbtj2f80N6/obXwby75x+T7yJpwQIbsJn3AIdjnIKoPIBkwlG+
	 8N7wu8183XjpgLHdVwwRuQOC/XhgC4QOqPzc7r11eBdeDx7JAKfz/1iz5jVNimLRmwyxB
	 u0YkwtXLcJ+FaWgG0eBTw8mFVY4t25cg3yZDL316L6T3xRiwfGp8a0RBiMO/kxQVEix7Y
	 Sez/77rrB9yfZ3cXnoDQLt00T5nXHE6xbk1P8FyRcuv/0y8dXwPuXIY0V/wanL+5dd9jg
	 j/GIg+8umWZqfcHF7hiKW128qWha/lOEXhwN5LvwuAn5xTutw8hkoCHN1cQQEQ3nxfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
	b=OReHWxVE9tV+dHgBzwdqscNGSaaDqlH3ssreNtqmgaKhARotp0B4RQ3PPgSZT84pQMfa
	 ztNYDL1wpLSymX1dQDIf5kUGLiE0PKQ+iKAICRHOSg9/kVSWWyKt+L2/yjdGp3aIhhv3E
	 FRUAYtVzidCLX1VMIwpmRx8EhChGZoFtq7a58y5gnTi9NahvyqZYdWbVIHfb57DDtD3FV
	 1e55hSk85Z55Rs+x1ot4upgvhBVVp5EAaQmhBTO9z7/OD2WMO+ZreNXTFsYAtxsgsymIy
	 ePx9yVqZ2wslOg49JEILc+w0EXuU6sG6/4UWBaVkMoMiiARTpUal/ECbjVRmqg4wxew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHXQ75jb;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10EC606A31D
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 05:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHXQ75jb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso15578275e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820900; x=1793425700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
        b=eHXQ75jbOsfxPG3i87e1VO0X3uwPAbBy91TM+fOWXtit2BQpXi9n3dTFCKtKvViCf2
         9Uj1tpZjyGw6WXmVGREnAdblX53nevh2tQe3n/LmE2SBvMO5inlY3/Tp3TjtYzCBzhy0
         R6xnpOvuRt56mZrPbYtPR1DZFp5BJOzucSElqaYBf8MnLWnS4A/KSfPEbAdjuyTX/0xM
         z+ke58s5zokAoOJAFlvEtUb4KXCiEnvZFizByPnR4fKsZ4iJRgcuP6RlCv1I74H0f5oL
         BSOUj3ays7QEJTYf6EmD7rPAS983u/xtjFClZtqAGMvJtXFilpeTwfyrf80K7mFcnfPP
         nzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820900; x=1793425700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
        b=hqNnkqRmuLnKmw0fvBt9TA9VHyk5/rYXr4vZRYgkQBh/5IDR5SsbWZnEg7F9JqIK2U
         gMUzstLCDe+VmlugTebXJp5uOsIBJU8yoAtMcCkuOLnEaEhlDBgTIyJLuyCoMH34GLis
         Br6vYwxtDLR7iWuiOubIDt6KizTV2eFwqiIHhd70QrjZVzQNa77gMFm+rVfFzoAP+Z62
         q8vYnzJMfpjT3ncA/44+Row7NQMTxgV3iSdwCRWbmSspXR8/6IoXtuc+04Ej38LZDp4A
         xmbz+cNw1bPu7K5hRiIEbjhGaMtrXL7tLwNsphz1PDCaewYuTHF+kkyFz3jKsMPNIkXG
         ZZlg==
X-Forwarded-Encrypted: i=1; AKwUvBw/uz0uY2QAlr8x45rHjCa6v6kO9ox89LPmVyvnENaxLcffQRCW6YVuOXg4evzuISYv7ITxniNsegxS@vger.kernel.org
X-Gm-Message-State: AFq9FYKIizQOxeZobcROdaqIgpy4VAHpE+Tv2Kh01M5G0WgoTxoVOQQN
	zFGtqLeASLK4CVq/ug3hD6i3YlI6X6oO44Ofkc+Tjjs2dJnLnaZ4HGD3
X-Gm-Gg: AYBFou0vrB6Bhrzx5oaG6hgJFCLKAK+kj17kSF449qpHNGMjwtiFJeZDuOxgVQrtHch
	OMoCGv28UAL2mbd0HIio4Tyk3YnPzMgquUr8+s66rBW352OtNWjow+oVoHAq82t59tbEMtsC5ns
	ASqKyV6DjeXQ80sH5Sv3itGVBmzLNZwk12JzzSH063+YbA1R9MlRVwLgyF3adagG6jcM8t5IBXz
	f+gG/3zPlgO8C5uXmyzmzac1JTa2DTXeTbw8zjqbAa4bQZTdyVMpRRdxxRtrE3vH9kCfy4Z2hyQ
	3SrhAfZXv84jwFFUsrv7jvTLftu1ofQ2VQz890pG1AdXyPMbxuJzuonoOyuuD8NEwNPPrmcwROf
	7q8fNzmQYdXWtTNG/wXZxo/GOHXF6yn2PutHtaIjtwtRHh22ihCDFxuet7NymG6oLW2IV9uZI8t
	ZI6/Wp1tsdHZgmcydtFkrRq+2ykUn4XjA46sA34GyC0SErj6I71GownE7Tz6gODmkbBoQVolqag
	Psxhf7xJwkMQrYUMPrlwC53I4Ade13ayPe/DIIEPRVUMMooPLD+FIxYBoVoBstkQsep5mEH4Xri
	qNU=
X-Received: by 2002:a05:600c:1987:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4a35ac3a7b1mr13113545e9.2.1792820899903;
        Fri, 23 Oct 2026 22:48:19 -0700 (PDT)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d6f6fsm30737725e9.12.2026.10.23.22.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:48:19 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Victor Carreras <vicajilau@gmail.com>
Subject: Re: [PATCH] PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Sat, 24 Oct 2026 07:48:18 +0200
Message-ID: <20261024054818.21654-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atsWqqpFptswGQKy@wunner.de>
References: <atsWqqpFptswGQKy@wunner.de>
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

On Fri, Oct 23, 2026 at 10:11:22AM +0200, Lukas Wunner wrote:
> This is x86-specific but drivers/pci/quirks.c is used by all arches.
> It should rather live e.g. in drivers/acpi/x86/utils.c.

Thanks for the review, Lukas. I have moved the quirk to
drivers/acpi/x86/utils.c in v2 (and dropped clearing
adev->wakeup.flags.valid so pci_acpi_setup()/pci_acpi_cleanup() power
dependent tracking remains balanced).

Best regards,
Victor
