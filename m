Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5739E177
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673459; cv=none; b=mX0wQ6SsWG1ZEH1FPgHnXficzmH2hBi7HLSyL9PxQmrgn48OmjG34eIUOJK15fA69PZ3t/3XSiJmsH73FcwZj9peo9CgHs1O3gumwxIe47gK+Yy2Se3Vpms1qmztMnsPwf3jPuV6ahtvdDdCnXxWBvZObJcTV4CVtcKPFTQOkqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673459; c=relaxed/simple;
	bh=rGewoBv2ScUyk29jPFBjVpjQ0sFVMwuXWUMDaqZZ04k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao/YbLU3YXzD7q9Q++3RFTmAxQqNPZex8rWXnTWT3eKbx3fEWaFDpkqjaq15+rHl0KRnQRU/SZuuGpHgZR/yLtqNRH85Lh8gT7GooFHHr7B7bpV0Br9z+YFFiuJJcrYEFzWcXSDqIvE1H2r0j3DyMNlwExIJGsYLgQzRj1u/sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGxFq+cz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGxFq+cz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bcec8613so3562207f8f.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773673454; x=1774278254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGewoBv2ScUyk29jPFBjVpjQ0sFVMwuXWUMDaqZZ04k=;
        b=TGxFq+cz4sJV1LPt4FZhCwb8ZWtZubL9ZPh8wD513yTM9xRPIzTzg6iai2aIMqaJt4
         IxQfA3gZtCqCaJcqhNSFC7hLHz9Djmr2OEPn1+TN2q905XsvDRRDHu/N1U7jPxFla6nH
         TErrTEoNL7WSrhgyFnc95xtK9v+zh8z4HJV33NmhMJXdBVM5/yNrfVOK1R5j+Dy34iNY
         +C4ddYnUub1H9LMduBHm6+grXVkk1MVZ/VhsynI6q6KuKrMwVT729LrzzWE8N+D1TLsC
         JcPe6jrDJb8O26qCqj0DxZwcDVWz6nnRcx9E2iNmaCV5UPiUhy0nhHcBoS9jKHtTtl4p
         FkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673454; x=1774278254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGewoBv2ScUyk29jPFBjVpjQ0sFVMwuXWUMDaqZZ04k=;
        b=pPK9hWjLV/agFLZIX7q6A1Tw0Vv67i67q9jtcqA+ehxdaHSydICSENCYtQct24K5E+
         dhbt+8h5eExJZi3gp2wMV7ik2VQ1xqg32JivHFU4pEt6dvB8QZZhdyBmfbL1wvfcVhVA
         56z9dYPn+YnzjEsQ3kiIlsF7kwGD494PTp/r1A4HyHjgWsIw9l3io05faMzhRKq3LO5w
         mMMv2cjgbmdUCNMi6AZTtRLONwPn+DZmfhRNHF7aKovACxCNab5P/fR+WSk9cNsXP2w1
         ik9oTmk5p/dtvpPia5mLOactOhW/UMM4HpNWypTB0DbUhuxaVpWUsG6m8+GypM2LASRJ
         PBTA==
X-Forwarded-Encrypted: i=1; AJvYcCXwfxfHFmhA9+r6tPi6BFZ0CbEuGWsbqsEF1090Foq3k9AP+KWzOJrlvTzcRaKGc0Y1jgmLgGxXVGhH@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMuJ0MhFQGmi8NpZo51m/6owBUuOXXqUuT+4X+tFKQWeBUaZY
	IA5wZAEVBNA8kT30feofoNEYq6rSjplVKkseWJTJbzNeqW1296rogS3Q
X-Gm-Gg: ATEYQzzMIHn5JL7b/6qMyFeUNlVXw4UlnA0yYu8uvuyT3F9O1YVRdt+wiElYGX5JOml
	/qh1Abllh2DlOpYARqUI5F+//kOZAY/nFfbDCAhslwz28St/8541HNUj6q6uUP99xJ/SZGSfGMc
	fSsmTRDxZpzinIE+EO5Aco7LtIBpEaxyMS1EauXIQyGtjytwzYXMT1MKbcHVgoAf3Hmom2nxw4Q
	XifjsGCNBqH3U6Eaed8L+X1mfHiK86+D/8TIc1ChRttNiTo831jzz0wC6wo5cC9tm6w3cXBcmau
	KGYSPwzTzjoARYx3XcGzth3QFc3bZq2YtW9sBRmVY1VpAyFchpXnl5485lnO8paueTTzY0PhtF8
	vgRgVIkxPyPLdrFgEGKtqCLgIM0a0wLajx2gjkukV4DIQkpBqvee5ZEdf3wYAllSkZ33/OHO1Jq
	7xIzyTL2YgGKWRsPLLFfXL+0irCUOm4E5tMYgfnpNqzdAxBbJp3vdzQ61WVTGtTPSPx/65gIi7q
	zpRcnly3UwEIsNdMpQQInY0+hGzr/7OsPOlCLFEwVSlA5zASCMO4tnhHVRuasifgpQMgPmhPIbf
	15dehLXlIN8=
X-Received: by 2002:a05:6000:230f:b0:439:b6d6:723 with SMTP id ffacd0b85a97d-43a04dc3209mr24334097f8f.42.1773673454171;
        Mon, 16 Mar 2026 08:04:14 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm45642278f8f.24.2026.03.16.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:04:12 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when vendor-specific sibling exists
Date: Mon, 16 Mar 2026 15:04:07 +0000
Message-ID: <20260316150407.30475-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316144510.GE2275908@black.igk.intel.com>
References: <20260316144510.GE2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Mar 2026 at 14:45, Mika Westerberg wrote:
> Well it needs to be somewhere unfortunately :( Gathering these into
> one file at least makes it sligthly more maintainable IMHO.

Fair enough, I'll move it to override_status_ids[] for v2.

One thing I noticed: the CPU match in acpi_device_override_status()
is mandatory, so each CPU family that ships boards with RhProxy will
need its own entry. The DMI check is already optional (skipped when
slot is unset), but there's no equivalent path for cpu_ids.

For now I'll add an entry for INTEL_RAPTORLAKE_S without DMI, which
covers all Raptor Lake desktop boards. Other platforms can add
entries as needed. If the per-CPU duplication becomes a problem later,
making cpu_ids optional would be a small change to the loop.

Thanks,
Edward
