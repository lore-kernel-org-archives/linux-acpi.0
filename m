Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286873;
	b=buM6xjwG/unbsVI3X0vEWh1np06nbbsv4aPai4H0dPGtvAxCXSNP68qsl9olRPPRVXfz
	 9uTR/52GWrcTF17cTHVWypRSchWZtVeVpZXr2qAx0lGWHDromXH7GwvPSNM9bG4YTNyeH
	 VuhBjrOCnyqVYuZkwETnp6Rzg4hwhGVeBGdbY0lUSbPLDa4lmK31qh49Ukna5Vpga1W7d
	 qdl/hakBUYU+AStFCYBgci4nF7wnDaSGkOBU02zzxlDGmZggHq5aB2BHImMW2nbNatcJR
	 CsDNwWpzdk3ckls2vuJ/yUqwd282kaFkuvpiZ+vjja8C1qUagH+XYWvt0NdawDYdhXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mCgbPzgmzkjrJ90WgvEpu49LYgOAawOzi/i2D+jOo74=;
	b=Nbr6ZcoETTmaRRv5XpF8ViNCbLdY1XHlJAPZ2yVmlyqpwGXrVBT1IteaIwN9+D9MY/9J
	 mNsb/0lwdczFumQBFuuet9HEFCyUt0s490K6uNpecxwRW7lZsEbAaJDIY1SQ1Q6xwsg+l
	 xnvtNLkjGVd+SE11/B38mbAT5h7QlndWx7Iu2bT9/yNDoXxIphm1jyH1ljjPjDXBPLIIH
	 +LF8S0LCkmOWoXS6uwJjenhml2bFQpZw0xl02xcSkzocoYnAsL2jTXfCROKzF6pT00+9h
	 8puAX1Y5ixho2Pv/jeFITXnCdLqfm1If4Q09Z/x+KMhzZidHHZn9QQVgLkH0FSO2Y9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fireburn.co.uk;
	spf=none smtp.mailfrom=fireburn.co.uk;
	dkim=pass header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ITC8oVJD;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3A606A321
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 15:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ITC8oVJD
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so24947485e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793286871; x=1793891671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mCgbPzgmzkjrJ90WgvEpu49LYgOAawOzi/i2D+jOo74=;
        b=ITC8oVJDuL0MCwfZGGVyNwJiBbCcUmI51jWlx7JhmNBAcsLvWeSqr+ygImFmdWpoBi
         HS+5NIj+oix7tFdVwl/iYuko+6gHZ8TQHdsAoR24Z60h6jFEd4VXTA6gkzp8mBT0RDfP
         ZJ+kQYi6Hi2TMjPEdR7e7FT689kLSywAFivWLT14Cj5PZt7KivKE1BzVOyyCmDnvw1Yb
         eFPC/6PC1R+zg/OoHH8LaIjlmt+FmqEy0q3MV3KkkTnxAlDlXqyqRzEmAuurzuLbuU0d
         RyJSdvKzz4751PwKjfkaZROPtW1cUlflwSV7SioNrO4sA0idHpzhtQo52OTbcgPPUpzN
         RsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286871; x=1793891671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mCgbPzgmzkjrJ90WgvEpu49LYgOAawOzi/i2D+jOo74=;
        b=kJK5y8ibFlxATqPwonFfqtsnarpRAVUpdPU2aeVavwjKZUO+YeGq4EjEAHutBI5z6t
         89/TdW5KvKI1cJa1OYyZHt0Qg3TyTjoSVWIYt4e1P4zun4ESy42bxcG4Q1VE10rvWrY6
         lAqjhp7r2HFazLBoCr2EPdXYaIJpqR6m14bLagYPXzp5sfC6uvfkVMsNf4AWdvfVFFB0
         hWb84j0iOsM88yDpAogmw7ipiQoQ2eS7cAaicKz6rRR+w/k/4ZVMAsf8UsBfwfNS0sLm
         rzCRRX77e3Lalchp5XiANP7/YqkrJFpigdTVqcKwCERcCQ7c9Lb2VHHLxr15Y46fyWh2
         jBDA==
X-Forwarded-Encrypted: i=1; AKwUvBwqVpdpggzjoKzNZ2PEeMtEhtoAYXGRlEEpztA94790ePGbtNVebqU6qnVyf+lFB5RzGcpZEGOscyt8@vger.kernel.org
X-Gm-Message-State: AFq9FYJBZeKz3HDiB2jkDLRdsfumi+iWmCwNVXoFN7viykKJZP9/cY+Q
	fPNI2ocmqfXLJ2Q1N6n5XfLaWMPjQnCoGjM931gFnZNQwNd1TkpLJp9kDOc83VNSVQ==
X-Gm-Gg: AYBFou0zVjP1hO9HZComuqE+/Ehy+59sznNGxxoX2TE2w08gHMRilEosmAq9H/4IjEI
	t7PvVB8ui4CQ1bz1qm2pGXue//1vAYNMN101C1epYgQzt18LEuUsCTzr0BDq62ZWWPuNbib/rVK
	fP4nlmmUS3n1ivPz7sTimJzrwIi39WPgpZ8so7Ztb8CWqUMdaVlXhIkHE/GaapEkGX9KtvmBeVw
	41YfntxlPr67CVnRMYXp3vZa/KzD/x4OCnzr+SR0hILoVFFfutAyC5RFKft7LnHjKWzqZTcKlaw
	Q7iaEZg5sxN5fHTdQlSZC2I9VD1XBqyxpCs1GWZI1VeEgw8KLvrNxL5vAbZnivU6r/JXGWUUy4A
	b4VzyjhUr0SKB5xoKZRMbTjgUhVYhIfoMp4hh8IgF/0bY5Tqc9YYQYcVbW4hlRNdV0veFvPAIv6
	bW9sn7aLO/2bGFQRtTfal/W6HRknp6ga5YICw+JkwS7aZ8OauQNhMXGRU9uAKVfanxv8XDTUJ4i
	c04bt0DLXMrpzM84WLYvpImvh5sXfONh0hprQIzbYZhZ5RffoQuti2aCAID8Jr8gOFavgQO0YBo
	o68vS5fbnLJMlEuunrmZwvymxopt4Fh0u9gx9AISI/SAIThtU6hnyMLynQddrPi8620mxwRDzDG
	D
X-Received: by 2002:a05:600c:4ece:b0:4a2:1960:6db with SMTP id 5b1f17b1804b1-4a9677ca10emr132657275e9.26.1793286870938;
        Thu, 29 Oct 2026 08:14:30 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb851sm30191373f8f.26.2026.10.29.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:14:30 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: superm1@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from its own node
Date: Thu, 29 Oct 2026 15:14:21 +0000
Message-ID: <20261029151422.56791-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029151422.56791-1-mike@fireburn.co.uk>
References: <20261029151422.56791-1-mike@fireburn.co.uk>
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

On BOCO platforms the SBIOS can signal a display hotplug on a powered
off dGPU by notifying the dGPU's ACPI node. On the ASUS ROG Strix G513QY
the USB-C DP alt mode lanes are driven by the Navi 22, and the CPM
D3cold table handles the HPD GPE with only:

  Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }

Nothing in Linux listens on that node: ATIF is bound to the iGPU and the
dGPU node is not an ACPI video bus. If the dGPU is in D3cold when a dock
is attached it stays off, no hotplug reaches userspace, the external
displays stay dark, and the level-triggered GPE keeps firing until the
dock is removed.

Install an ACPI device notify handler on the dGPU's companion when BOCO
is used, and request a runtime resume on 0x81. Runtime resume already
re-detects all links and sends a hotplug event, so the new displays are
picked up; the device autosuspends again if nothing is enabled.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f..deb63122828d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -641,6 +641,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	bool				acpi_dgpu_notify;
 	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper debugfs_vbios_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7f5abb03be1b..a4041f90b374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1280,6 +1280,23 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
 	return amdgpu_atif_handler(adev, entry);
 }
 
+/*
+ * On BOCO platforms the SBIOS signals display hotplug on a powered-off dGPU
+ * (e.g. USB-C DP alt mode HPD wired to the dGPU) with Notify(<dGPU>, 0x81)
+ * on the dGPU's own ACPI node. Nothing else listens there, so wake the
+ * device; runtime resume re-detects all links and sends a hotplug event.
+ */
+static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct amdgpu_device *adev = data;
+
+	if (event != ACPI_VIDEO_NOTIFY_PROBE)
+		return;
+
+	dev_dbg(adev->dev, "ACPI notify 0x%x, requesting runtime resume\n", event);
+	pm_request_resume(adev->dev);
+}
+
 /* Call all ACPI methods here */
 /**
  * amdgpu_acpi_init - init driver acpi support
@@ -1325,6 +1342,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
 	register_acpi_notifier(&adev->acpi_nb);
 
+	if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+		adev->acpi_dgpu_notify =
+			!acpi_dev_install_notify_handler(ACPI_COMPANION(adev->dev),
+							 ACPI_DEVICE_NOTIFY,
+							 amdgpu_acpi_dgpu_notify,
+							 adev);
+
 	return 0;
 }
 
@@ -1344,6 +1369,12 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
  */
 void amdgpu_acpi_fini(struct amdgpu_device *adev)
 {
+	if (adev->acpi_dgpu_notify) {
+		acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
+					       ACPI_DEVICE_NOTIFY,
+					       amdgpu_acpi_dgpu_notify);
+		adev->acpi_dgpu_notify = false;
+	}
 	unregister_acpi_notifier(&adev->acpi_nb);
 }
 
-- 
2.56.0

