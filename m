Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378756;
	b=lEhNmb1OOKYxU0rzXlEjWKVKfDGhskzS0W8ttghH8Z4VvCAqx5lWxCTqRiecn0+7XfVN
	 GpEeUfnV6u5VumFVcP+TQQhPXv1l+r2tFWp0RsMOXFUhyhHABqM+rzz3CPZTjQsvw+htU
	 SNYt+xkw/CdvDRvH+nY9GpNo+VSEMOtcGNp0uS0+GovfXCEETGNtA4iNWY5ljj7rOXHtz
	 UPhh87sST18g+aQOKksu98MXwJf6K9zaIR66CtW0aH/sXif01wlZvEyrETBy1cxoTU9Rl
	 QIgcjk0QC+IUcVjblFxJx5jIbkyFwHTRMDsQ30KTxNhYTCzEvX3L/pMrm5hUZGsn14Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
	b=pjbnPQm2XuD+oq1kUSk6vF+rAcqv6wr74oWoNyE+9+83Ov4UtYfKxvXuVBNQr/G9QaU/
	 l2q2EMNftCCmvhQOud8/+Ijg7i5NP2K7PO4gFSmEqnr5Z6+dWOkIqJOKZfvw7NhoVo1gq
	 9VYMcwGPhRxiDmkxoO235ZBkB6ZGS7qEr4uz5rGKgt1jDnA/o/B3+a3XcWCmRHeZKHQYX
	 B1CpAGJQDhL7iXhw/7SK1GHYQI+//Wl9Hmq65xoq7gPJRtn6uSh6bndbefOWLY+ZftmfN
	 NbmGsXynDtKZnG4sxere6xHBksZBKcvADJ565Z7Td1YmDYCKqV4wBjMDIl0J5w6z4og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHlREPoq;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FD606A321
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 06:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 158FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHlREPoq
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so2050679f8f.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 22:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378754; x=1794983554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
        b=tHlREPoqa3VREtd/3FqXEUOQP7wEvLpOjRoM9iujAcGnu2x208KdouZARqXfWc8LUp
         xQPFMmdwxe0xffIOTCemDQi04ZE3O+U7kC7Az5oHwzwHT0Kb/PNDdI8MkPRuIC165xZi
         J9LjxfJQyt7jUVlixwSoVo4Au61L8iJDi0e7wUe4P5RENdlkHX28QizsvyhSScqj7GLA
         9uTuUbaAnv7tzNWvwEHBoa9OD9fTDDsYS71kqMeeJ5Z3BL5Sq6qoectk/JdgJLn9+rnC
         iiHX7XhC2ap7sdO9RGcsPVuCZ+FTEamoYDxeG8NQ80Ij2fqXLNBF/mvJnCFJybSK73Rb
         FWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378754; x=1794983554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
        b=MC8nFcF2WfkCD2ua+F/ly1p941Px7cSF8D3PWYya5Z6HC2uLJKlRJtrpUWcKLMjWD6
         Mvo24MIyIUIrWzt23E6iX+KmFuUHuQICHBwuG3Y0Y4F2fNdIO9QrT6wqU/9tLNbVHJjC
         /pG+gbN46bOxHv+YKH59MmtIdCPsyEfkyd4KtL0rOJ1bp5AhQZ6tfoXWookX93d/xzcX
         8oRREnq2UFAkymB3RhLu1XEvPgeUr7fqMVS58wHYLRPZ1fN1kRDRlKee7/yrP6Sr8dJh
         pQ6nxoc2ghYPvCvwQ2Drrm6qUKq3OBIAAO2B8lJB+8lYd+a8fnLXywgYsiemJ3rp2ipd
         h5ow==
X-Forwarded-Encrypted: i=1; AL+hErHhJN5A3KyPHAudgdN/OrJmG/02H6aAAkwenbPpyR3+EMmHTs+FNcb685oQJoM6QXaNeWJak2y6YD16@vger.kernel.org
X-Gm-Message-State: APuU4Z/CGUt9QHTLVPam6NYn/3Q9gSrboviyd4om9V0HEtm+L16LhyEH
	nu/p22FHZb0yf8+KdpFVaxPgmA5GiI+Z0ks76m+794RHJ8ItRt/yHE3B
X-Gm-Gg: AYBFou1TQBw08S432/5wiqqMgTtpgr9f4R7cmN2cf/0CS7cbhZW1EgYQ21F5ZhRLRN7
	VL12fEdvvnJSOVPKtm0Cwp/5PbBdGE7sAFL0FpHVthaspSrKBpgoQWEk6E3pYcrbtoZWyPKhrft
	Q6FPFAqGKi/GazcqpD2YUBt9IsiXMcesW3mdlu6tjXDYtJq57td/xeI3NBu1VOx/in4YwxFMn1/
	Ys5joM6tAKuiNHSEF0xJ6GrDF6DG2Ql9B9kNJe3CdepQXQfqYJ9i7bvKnL2gSkKU7rZLidNKURm
	Sp2c+zDCn8hwbNeLF4DUzRGeBXk+zjMsjkPGscSpUe33bymJyyAlOreLxhpU3UtupiD+WcVyKvP
	jXCIQQX8SiE14IU4LNJNvVgduYhkJ/gCcI8gMxvxwLvi6/GtDqdt/9SO07UkcI05+At3+beXSp0
	frvlR8sA0/TyJWeOnxfxBoubY7NvzjzH5QJCse74ebHD8sc1oqoMAR97bY7hx1u/NKqUTItujlx
	i96Y+RWiqwu9y1qfBlv5u7/ShpPuDAkfPDTap31qpkLIU+U5aqjq+52aGl5pplLKbXpn/2sHD0+
	1nK+UWSGnFhLXRqmBL+G6RBV1eiIjKuKyHFs18VK0inc/Rhr+D6ukF48sPoq1VCWJHc0rQMRAw=
	=
X-Received: by 2002:a5d:64e3:0:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-499c903d741mr1957954f8f.23.1794378754237;
        Tue, 10 Nov 2026 22:32:34 -0800 (PST)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c027sm8981259f8f.24.2026.11.10.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:32:33 -0800 (PST)
From: Victor Carreras <vicajilau@gmail.com>
To: rafael@kernel.org,
	hdegoede@redhat.com,
	bhelgaas@google.com,
	lukas@wunner.de
Cc: mika.westerberg@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Wed, 11 Nov 2026 07:32:27 +0100
Message-ID: <20261111063227.14511-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
References: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
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

On Mon, Nov 9, 2026 at 8:32 PM Rafael J. Wysocki wrote:
> Please see Sashiko's feedback on this one and let me know what you
> think about it:

Hi Rafael,

Sashiko is right, v2 does not work as intended. Clearing can_wakeup in a
final fixup is undone by pcie_pme_can_wakeup() when the PME service
binds, and in any case acpi_pci_wakeup() and acpi_pci_propagate_wakeup()
only look at adev->wakeup.flags.valid, so _DSW on PEG0 still gets
evaluated, both for the root port itself and when wakeup is propagated
from the dGPU below it.

v3 follows the suggestion: it clears adev->wakeup.flags.valid from a
DECLARE_PCI_FIXUP_EARLY quirk, which runs in pci_setup_device() after
pci_set_acpi_fwnode() and before device_add() calls pci_acpi_setup(),
so pci_acpi_setup() and pci_acpi_cleanup() stay balanced and both
paths skip PEG0. With v3 and the SSDT workaround removed, the root port
and the dGPU reach D3cold on my MS-1594 and the touchpad keeps working
across repeated D3cold cycles. I'm sending it as a reply to this thread.

Thanks,
Victor
