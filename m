Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134194;
	b=E5PYrWH6X14WZs30o56PBN/UwJg3vNi9ADrXS3baqnl0P55bke7/1hqay6zZx45Kl0H3
	 qXJAcflR6BOU0XMpJi+hWvt563ZEjyvXfZyXrI6bItZPX4HgwYxaJW1mjvfVKnRR037mH
	 OO3nDvtrB/FnPV27CB/3q3PUIzVDnmk90b//2q/xmJ6VaPJkhYGnm2D+QQr46v+frKpu0
	 9U8zkqrvYjzli18gOvAV2FBhWLOqciVlKgJNWofNR5VXfkX0TLknSIAtRVrdLkgIAQyob
	 ST0OhL/aKNOadEbW3N3kx10TxbGiKP+2ERcFEv97MEdL0NxEisalOZ7r6TZdvezgn9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nXm7V+55JTESgfbXuII0g/LeSG6H/Z2OSofXDdA1V+w=;
	b=G2AejcZo42Wwuk3NO1cuX9gM2cii+txFULR4mTLx8m/6C5+S1gT3p1mnfhFv/JV7UUBR
	 h1UIBYyABStjx815YUTVX5NxxDO/F6x7NyncyZhCszyBUmRldx1XjWAqZCEgebmtY2IHJ
	 DRYJjdpUbDw5GE3Z8TAEoDaODR8mvPgmHHJX2p4JPkXoWv/KsQsqhjA7zlXJVcA9VIjPm
	 NxW2zci6E1LnG/4VycdA+JuVJqFn2Xy3zbFOonR6wy6r9y7Mft1qZN+MBITNtNMfoFC3N
	 ranOC7XUCiyUW2SqklaGLZBRmG6LVozNqAXXfRjPnL7HwwoeDcLOY4YKHcVpZA4XoJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oBVH6pDV;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67446606A32A
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 00:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67446606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oBVH6pDV
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so303419c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795134194; x=1795738994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXm7V+55JTESgfbXuII0g/LeSG6H/Z2OSofXDdA1V+w=;
        b=oBVH6pDVdstlzHaOVOVULqK5ysRH24Asv3ZAkSMY6iAhO6LcrfMT9jtVdAeh8oT+ev
         ysqpmm5usheSEUJOkIzzvNuQKCrBB8JCk387SEvoa3aoeSHSse4GpEZd7qsKKvaWvTMO
         1iRpxV7t46Cvp6wDo7sYPCmtmJkEi1hlhDssbSk1AMACJ2wl47yQR4Y+mVQyhm3gzKxj
         LkP7QcT9rdb2RYwKPBxGvMhG1vuRBhf3PlPUkk9xfuWlkUEBM8ma6ocjlti/iQkE0VNL
         lNypHhG3r9faR/HfQKW0iyErDtDcnKObhwu9FelI6FQ5HH4k8fw//OmvGEcxbGY2u4VJ
         dURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134194; x=1795738994;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXm7V+55JTESgfbXuII0g/LeSG6H/Z2OSofXDdA1V+w=;
        b=qbSmjXt7vl4k2Ab98Ol1lMSgoBdNKJrm6LHQeY3GX559xw4oDLPEmKxn97BYTRqHof
         4n9aWl/ImxO7xhH6osIQVII78WQQjSuFYM6S/NzPMQ3ELciinfZhXWQ5pdvZFTPrCV1i
         Arai8bN5WAyypqZAQI48tLXsBFrxZWgjlNCVAa8u8a/2ZmTBaPuwCIayhTSdUfhJ+66O
         IJTfXDeCxtyRFNEf9VtEcJvDfUbcgWV4rpnj18TWixJfjEojh1y39WGE75Vh5h0Qa7MV
         KXHt1ngGpRfaOio4Gysg3A0sAWMjyWTfq3OR+f7Hargqa8+ndTbIC7rhHsBBFa1xDODh
         ky+Q==
X-Forwarded-Encrypted: i=1; AL+hErGyZ1vOw3KQPdRbmVqqqo/84YZ3fd4CXgU1hfhR4vj92ij5A+FZx3NFhQRlM6uJjP5qt7zjRfv0B9l8@vger.kernel.org
X-Gm-Message-State: APuU4Z8+EK1uqTAOpPvzxGv4WVBi7dS5r9xjiQo9szAaF4HvxQZnXqKH
	1e7YQZsMhPpFmPdnlQZTcwZi1Z4CGG83HMpvG2SddMiv7XOFDcfVvBHOM+8nxFfmXO9gfWY0e1f
	grVpgs6P0ur369A==
X-Received: from dlep8-n1.prod.google.com ([2002:a05:701b:4588:10b0:1b2:5589:f43a])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:204f:10b0:1b3:a05f:892d with SMTP id a92af1059eb24-1b556903388mr1192470c88.40.1795134193081;
 Thu, 19 Nov 2026 16:23:13 -0800 (PST)
Date: Fri, 20 Nov 2026 00:23:09 +0000
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120002311.394649-1-digonzal@google.com>
Subject: [PATCH v3 0/2] PCI/ATS: Disable ATS when ACS TB is set upstream
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, decot@google.com, praan@google.com, 
	sheenamo@google.com, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

This series disables ATS on endpoints when an upstream bridge has ACS
Translation Blocking (PCI_ACS_TB) enabled, preventing ACS Violations on
translated DMA requests.

Patch 1/2 stops pci_dev_reset_iommu_done() from re-evaluating
pci_ats_supported() and dev_has_iommu() independently from
pci_dev_reset_iommu_prepare(), tracking whether state needs to be
restored via a @restore output flag instead. It can be merged
independently.

Patch 2/2 updates pci_ats_supported() to walk upstream bridges and
return false if any bridge has PCI_ACS_TB set in PCI_ACS_CTRL.

Changes since v2:
 - Add patch 1/2 to track IOMMU reset restore state between
   pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done()
 - Move the upstream ACS TB check back into pci_ats_supported(),
   dropping pci_ats_check_acs() and changes to pci-driver.c and pci.h
 - Read PCI_ACS_CTRL directly and check the return value and
   PCI_POSSIBLE_ERROR() so inaccessible bridges are not treated as
   having PCI_ACS_TB set
 - Remove the pci_warn_once() logging and helper function

Changes since v1 (v2, based on Sashiko review):
 - Move the upstream ACS TB check from pci_ats_supported() into
   pci_ats_check_acs() called after pci_enable_acs()
 - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly

Danny Gonzalez (2):
  iommu: Track whether pci_dev_reset_iommu_done() needs to restore state
  PCI/ATS: Disable ATS when ACS TB is set upstream

 drivers/iommu/iommu.c  | 14 ++++++++++----
 drivers/pci/ats.c      | 19 +++++++++++++++++++
 drivers/pci/pci-acpi.c |  5 +++--
 drivers/pci/pci.c      | 25 +++++++++++++++----------
 drivers/pci/quirks.c   |  5 +++--
 include/linux/iommu.h  |  9 +++++----
 6 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.56.1.708.g77570a6a1d-goog

