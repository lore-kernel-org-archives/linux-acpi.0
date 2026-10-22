Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688331;
	b=bXHB4gF2GKDOeIHe/lHVwSgVPTCujxssUaGATJ4X7v3m3vpBrApFSJeFx3CaqW9Dal9w
	 TPN/RNtUaaZ0Pp/reUFNd5jId+FCtcjXsRFVUH/L66VNw5oM0a0vER2ccraS6zYj3gtIK
	 N71vjQtiUyKAU/kmTXn/ylsBjWYaLc+N8NMSnOT+oi3VAK1muURF/RXevVxCWkolZ+B+v
	 QcFlv0XHpuPxZ48x1Z0regQKpBK5k9kt++xe5XLlv2z4t++sPYYAsVOekBreRaRwahlcf
	 CGMo0cGx8WU0moKWsf22nBBsAEig6X08k6kvtn9n2aDI/HHMFeyHr3t8tzYHHh2BYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
	b=kJmojoOy6xtue6pH7xvJe3Gjffqc2HZpa4oozlK2QVwPM7VCVCaMHTaIaIxxl2r/rOVn
	 q6EiOzRw4bJaaUcfD9qxDlrq1VOl7stA1eQth1GuB3I1gZe3h0gP8JrYWeGtvaHWfsquM
	 /IVlUS+L84YjgdC04YUvyHj0O3DyFpCfdQ50WvQhusNKYLYwLjvTVE1y9tkH0UvF4oge1
	 C1Mw+U5ieVjbDrJn4wzTItyfUC/gYcrdq+AtWTdfUPDy9ZTdbP4mG/AA5K20dHa5+vjGY
	 8FpzXmkWp4mkWKlD21PcLC/uRYNgnE+Z2qtnbSzEw48vUn4esy2fCyzBDxUMzrAYX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=eQRcHZvR;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FD606A323
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 16:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 136FD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=eQRcHZvR
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so2702806c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688330; x=1793293130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
        b=eQRcHZvR2vd9ZIlpOH12y640m9H2xfPxm9TswHnMTQdHUoqdFjEZvYpAfUxySnpznM
         Ct1fnWck5tZHcH7DYwVIplagroS9AML3MEcIMtLvNhXbYfkcpdb7rSh0KVyGspQsNq2I
         iiN6n7n0TPoO3XUj79+oKa6ESqi+hbfz4hGZTfsEpJR4tdT5TpvgXioAab2N8zXDW40q
         Cx7vcalkW9o7vGWXWChDD5/FTlp28bUydovKVNvaL6aoBmTh5fYbFnztkjeldTE9vk/F
         lzcSi8cpTvUBHeomTbKmOAqhZHRxjDlRPZ9ZOPiaiGUuF1+8XSRXz0V7WjCKA6ugdwSZ
         m7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688330; x=1793293130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
        b=2Jf1OAi95TRhRiZEayWgAVLE4lRWbNN9HKxfSU3kxuX/PLgMj46HbrFTSkja3jQfvT
         wbF22MrbwE6M+EHG1n/CaY7QoVqJebubGW10f+lRY3XsNM4oNEw0C6nYNG2ZVcU5R9pz
         XFE3Z4a8ZSR6+6Gu/GepNL0JAUx/6wct8XoXAigYLJw7sCe9oBLGHHWejbd5CSzC0pJ2
         dpLSICXXpv6PQu8m3QyizB1jQlEvRkpkhibRIMaJLRglDS5Hr8TVCiXOgcVIfbOUHs5e
         WMvjEW5egES01+Rt17ekhXqaFTziee5TgCvLBZkI+IVOn3Qd/5nyO43+QbyO65FcHQ3G
         Xceg==
X-Forwarded-Encrypted: i=1; AKwUvBwxO6sIp9RRE22x5Ii1y7MQKdhMCgDG/ppshrTPPYW1qG+PA7Es2amcMWkPWkOQcsZxYBVrnuwcbCXX@vger.kernel.org
X-Gm-Message-State: AFq9FYJKb/yOXG3tA6JuE/5ednwoqDNCxN3RksTX63/fijQ1b8/XasJZ
	ZHyy2bMoqRDJs6UUvfK63PbzAmv1yqWv2HPXWHeKHacxAKLtFrJiEq9H2VK8mcCz73KDATd243p
	W5cnX0h3/
X-Gm-Gg: AYBFou2joigbh4yFp+6DRqgZup22I5eys2JQK8MIXVQ/utenHIkigVYypue6sl4jNSZ
	f3eYvKUod2X6wA/xFNv2CAri5zPZvi6q9SiHEJ4ALNEcJdSPdUDFjs0Z2oSXNmRu5Cb7LCUJe8R
	cKlkKvE/gAQYWNClWlDvyqtCBzN10VBVaZVqo8OaTINf4snyvHAL8JHsMY14d266zm01mRDZoOH
	CyAp1s5ymTwZ2iXFv8AlpO2cmtKNHoNz/Wcd7DxUcytZ+EVD3IbZELYrRBURXhhNVuSY1y0uFze
	Vh2xYjDTlKW6VAUQx00kufFBLjJBG2DtUO51ZYOnDsMeuwcygFxxVAFs5lZWJ+whxLbwe11rrM4
	rz4duEf4gXx8ryOPDtHNW4loEBEV1zlV692mAH0MqFtxE8gdt0bDP2P1Keczk7qaHyWJQqkRKhE
	AS2A2SfyT9GccSIMo98BJ4s94jc7jYqSKkmCEXHn+YrD8Dp+om4COd8HhkqBxzeB5ggz7xT+iVo
	HTqH3flDqqHP4EYhJBBS/cb7WfwGplNh0pOc9skhQdj3vys7ET4gzY/sZzluRZsBnPqhW/1t2vH
	3u4+AU83PqvSEnTxF/+rdbIscV6+uZWRX1w=
X-Received: by 2002:a05:7023:a81:b0:168:3243:c911 with SMTP id a92af1059eb24-195a0effa19mr34185c88.37.1792688329950;
        Thu, 22 Oct 2026 09:58:49 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:48 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/2] PCI: Add boot options to disable DPC and AER recovery
Date: Thu, 22 Oct 2026 16:58:40 +0000
Message-ID: <20261022165842.1463451-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
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

On large modular systems with a complex PCIe topology, allow userspace to
inspect uncorrectable AER errors before Linux attempts recovery and to
opt out of Linux DPC and EDR support.

This series adds two PCI kernel boot options:

  pci=noaer_recovery  - Retain AER logging and correctable handling, but
                       skip uncorrectable AER recovery, including CXL RCH
                       callbacks and recovery of GHES-reported errors.
  pci=nodpc          - Disable Linux DPC and EDR participation, including
                       ACPI negotiation and EDR's DPC-enabling _DSM call.

Firmware-owned DPC settings and firmware error recovery remain under
firmware control. The two options can be selected independently.

Changes in v3:
  - Patch 1: Check the recovery option before dispatching CXL RCH and
    ordinary PCIe errors, addressing the CXL callback bypass.
  - Patch 1: Preserve current GHES cleanup and device-reference release.
  - Patch 2: Add pci_dpc_available() and use it for DPC services, ACPI
    DPC/EDR negotiation, and EDR notifier installation/removal.
  - Patch 2: Skip the entire EDR registration path before its enabling
    _DSM, and prevent native-port overrides from defeating nodpc.
  - Clarify the Linux-only scope and rebase onto the PCI next branch.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-1-yurypm@arista.com/
AER review: https://lore.kernel.org/linux-pci/20260709190616.DF0CF1F000E9@smtp.kernel.org/
DPC review: https://lore.kernel.org/linux-pci/20260709190730.E19A11F000E9@smtp.kernel.org/

Yury Murashka (2):
  PCI: Add pci=noaer_recovery kernel boot option
  PCI: Add pci=nodpc kernel boot option

 .../admin-guide/kernel-parameters.txt         |  9 +++++++
 drivers/acpi/pci_root.c                       |  9 +++++--
 drivers/pci/pci.c                             |  4 ++++
 drivers/pci/pci.h                             |  4 ++++
 drivers/pci/pcie/aer.c                        | 13 ++++++++--
 drivers/pci/pcie/dpc.c                        | 24 ++++++++++++++++---
 drivers/pci/pcie/edr.c                        |  5 +++-
 drivers/pci/pcie/portdrv.c                    |  3 ++-
 include/linux/pci.h                           |  6 +++++
 9 files changed, 68 insertions(+), 9 deletions(-)


base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
-- 
2.51.0

