Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9F34405B
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837678; cv=none; b=cNJQGNtvvqDt5Ah8tjUB+ugs1B9wLKksSPXIwltCMtDUkrCjTTLFxUv7tKBbIFTYkdyOMH0kWZtof1xRaaBW+bSZIYIORB51y8yN+CH3t+BSs3KHzBNvitHvUPH+0E1IrUI9do8RRrGkhJf5m8HJCMlDBcGmPnSOuMFf1iN1E1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837678; c=relaxed/simple;
	bh=vZyq9h3vkeF5aQxGQqlBRMFtAQOkVVXTBRKDh1HO88k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ha4Z0oghBADwfSAEo5AgoEH4U9aEF1Qa1dp9yIAo5iqwNgRIbR8hLJmV1PXf+/W2MyaAo1SKF6YRI5Vi10SQRosg1QNfm5m80r0MHdf6vFqQhbJnnkaFw43TrmcKww5gyGTs5DbZTXEwf2DFv6M11gdhaJGczd/wfEiHqtFW5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtH8wuXn; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtH8wuXn"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7886171eec.1
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837676; x=1775442476; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySc265PnZwbX1P9RXTWeU43Uza4/FiDlEOhs0dGdd68=;
        b=JtH8wuXni2mMdjU6drtXWKPdFHwyNXPyWbSMJvY/a5cOYX+RPOHzpaza0CLgGBGSVN
         S/eSERJmJisZEkZWrEpMWN2WOPScx95vo6OaYMDQb0XLSyBX10jKo2vsuQGdh4jP7Wal
         dSolkSPtx8UYH+9Btuw7wGwkMnYpRzC/MDLdokRH5Jv8Gi+/l6U/d++ZyxgqazkhUMJr
         TPu7TTZFERkDXjm+rokSaXIT3hZPfqb9eYvi9Vc6rI8Wx+D0dZJ+3/AR0cePqBK8cQLc
         FKBl8i9TbrA/pzSMlUPFvqW8XGFR85XWFD4IHqrlKd8hZJw+rIAGBFXY+LakH0QCQZaF
         uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837676; x=1775442476;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySc265PnZwbX1P9RXTWeU43Uza4/FiDlEOhs0dGdd68=;
        b=bIQAjCX966ggGDzl3T+a94O93O+piVpwP/ficr85rX7n9fOr7D3xcA9X5K/mvSRnMM
         C1SnEoQiyc5XfGG4DNhYIHGW5E0NbGaU/fL7bv4Rprqbb1icm0kJy1fZNITRH1VZwcpX
         WJ21S8MvTXheLA0co0FAp1SSY5mYPUG/omE0kCJjkKFu2bgagSH4uWtlHcxdq/llY/p8
         o9s9iHs0LD/NKr+8XfX4SktiEgefgmqft70vEX7QeAO8g9VZkN/2EBtShfTeapT3Yjfo
         1oHStZjIzhecndKbMuAy79GhKrwZmJ3O2+6xZtY8S6KfzjtLKDl6iKwyqXPFkmY8Fxln
         bycg==
X-Forwarded-Encrypted: i=1; AJvYcCW9RGo2YF7JingXRCMB/DtJg43SQAQYgsLQQjd3RbMhPi9sFO20DmjRmwGbqKg8R8UEMYKwK22Wx3Rr@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZnDZ8BzxMOewJKBdxNZ86QNKPARxOcyv6Rw17DjtBuf3/2xI
	+vN0dC4LAL1EHi7ROuDwT2f6snKYR+Ova9sOZl46caE5h5N1iwFiNIrT
X-Gm-Gg: ATEYQzz6J2RU0YKwVvg2LhTPj8ms+eSR9/vYOHaKoriP7HUTn8HVNmus8IwuGR09SrZ
	ZJ8VeKVO3FOkPnMBd4sN92JSDEyiSh4KUyZrWjCRW72HVy+4qfKUMyeOz1F5/Cxv89WnwwuM6Sg
	VQqB4ggG2mDVEfhjohoi1OB6111z/nWxWTlzcB5Ll/rq7IVNI9oNVJhSHQC91DTnUu0AVcyO8OM
	OAdg7rbtL9sSsCECLNXJbVbKKxNRH/RhAya+KJ1ggB9aNZ1zL6EZV1Yd9+Mpco6xQo+Oief5Cu4
	zkhX73u9NBtcsdjI8WCljpjkuRrtC6Wt5a2mQXTazbf+0VFIQzygiOVGsk8BMD5lSxTt55HeVN5
	4u4f3V4hdJhhqKKuyOCUjp1cNInD/DZ4M8OVRw5ZtoJeXJ6aHB2896ti9NjG5yKAdbsEPjPGtfC
	J+nrFTMY6Rb1Bky5kc3uZyvZibWoUpU6Rbi1Aaid7ElOnNBiyvJbjw5du6NxJn75SEEZM/p+4l2
	LliiWwzoTcvv/A=
X-Received: by 2002:a05:7301:a03:b0:2c4:4276:709f with SMTP id 5a478bee46e88-2c442767647mr2600127eec.1.1774837676295;
        Sun, 29 Mar 2026 19:27:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:27:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/4] Fix handling of GPIO keys and LEDs on geode
Date: Sun, 29 Mar 2026 19:27:47 -0700
Message-Id: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTfyWkC/22Nyw6CMBBFf4XM2jG02PpY+R+GBbbTMonQpiVEQ
 vh3K3Hp8pzknrtCpsSU4VatkGjmzGEsIA8VmL4bPSHbwiBrqetGKIwpRErTgj5yQMdvVEJdtHH
 OWGWh7GKiovfmoy3cc55CWvaLWXztryabP7VZYI1X8zxpUo7O1t390PHraMIA7bZtH6Nd0K6yA
 AAA
X-Change-ID: 20260315-property-gpio-fix-51586cffcd5d
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6826

This series deal with breakage on geode caused by a recent conversion of
the board to use static device properties for configuring GPIO-connected
keys and LEDs. The issue was that PROPERTY_ENTRY_GPIO() would create a
temporary structure on stack for GPIO properties which would later be
discarded.

The first change patches the behavior using existing in kernel APIs so
that the bug can easily be fixed in stable kernels, and the other 3
improve the API and add safety checks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- added printing offending propety name in patch #3 (Andy)
- Link to v1: https://patch.msgid.link/20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com

---
Dmitry Torokhov (4):
      x86/geode: fix on-stack property data usage
      software node: allow passing reference args to PROPERTY_ENTRY_REF
      software node: verify that property data is not on stack
      x86/geode: use PROPERTY_ENTRY_REF for GPIO properties

 arch/x86/platform/geode/geode-common.c | 24 ++++++++++++++++++------
 drivers/base/swnode.c                  | 10 ++++++++++
 include/linux/property.h               |  9 ++++++++-
 3 files changed, 36 insertions(+), 7 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260315-property-gpio-fix-51586cffcd5d

Thanks.

-- 
Dmitry

