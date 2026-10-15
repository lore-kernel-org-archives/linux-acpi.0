Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931865625FE
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085451; cv=none; b=dlghiutUN8ourGKTyOxeejucoDJqwjjZbDXgOx0rALVO4Bnwd6kTra7AHUOr4E85wC6J79J4rA1rPfcdEKG3XQw0CUXTHrD086oQWQmADW9otVz2Z7sP8ZrohMEvciDq2Z8015VekqLH+c4R/RmTV34+V4tBZVdR95V2WDrlFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085451; c=relaxed/simple;
	bh=9g9zSq074iPd7lmg87fsZCRtxqvQNuxb1lPXVSTpQjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0gdFBUf9JU5tGmHTs93Kza/gk/CezAzPBa6CZHZ/c08lFZLGGJIxP3pKJ3dzNU6cQd9SkxR5NuST5nCszeL/ydlYJfSBdboc3/U9PG4M+9xqEdDGWYGV8I5q659ld6VNHbod7r2H1ANVApoW625JefJH0vhPrwu4ZuQDGEoP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mpy/S1Hd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mpy/S1Hd"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93cc1ab5f6cso650453185a.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792085440; x=1792690240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYdLOSjrNOs+xotfPTGhWGTNQmq7/MP7sLOby3eu2kk=;
        b=mpy/S1HdS9xrCkKQCXlvabsfjOdtGZIKXRuKOyy/eEUJFm1IjYzL3QdQ1qgFhDTM1m
         ajdFWvnZ33Am2nuDKYISqzSewbbYIUI/BbrB3GbxLGGclpBPzcB5D4hZRzrI4peLwv8O
         CR57msEQ29Sksmz60azbaperTi/6+zeXU/he1BkcOExXWNxdfZUe0oNHjgnuMTg/MFOS
         2fVqXRUUgWk3kYO1vmMfcV5sRztLYOvCB9v86sfBjyK08oK0aIUMThQE/GLjJSPPKDBc
         Cm02Dpyr4qmcvBMGdfaEBSYg62vF8vk8g6G4D8GoUyDrHHvXQcbFxM0yVGtYLsePGATP
         m7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085440; x=1792690240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NYdLOSjrNOs+xotfPTGhWGTNQmq7/MP7sLOby3eu2kk=;
        b=aFVgaGQ/uSr2le+npOM6K5kZieNSXnYARjRVafH8uQdqW14+m3HaY9seHV+S6J9/Z7
         ifNOaj1NKm1EHa7kUoIC4UDAWc8U0e+e6luJ0B66/GgxgJr9b8P3fGLJABKOUsTnOnRo
         wXNLUaxLyfvmOlyT5Mp1YoregFsHGJtCij57SO+V2Mf3UxrSmJHna7BLlOICw5VOb6mF
         /HTt3gFRnRGaMj2lOoLCnlF1vbzqQpGaOZDU8mgI73clMB+/+fTNx9n8audO7yhc+eEs
         ZBx8SjuiKM6WbRP2smgiBWWKZxR4bfJjLQ+kNSjqvZP27fgBeYp2hL0SWF4i3qjdmqwO
         SUcA==
X-Gm-Message-State: AFq9FYJ3xw0buVJDLWno2CnTAtK/XHZjlZPP9DCyQ4UHfqB10VOCZK1i
	QwcAGnr2JfN5taWiwCDWXEZFpYBFSZ6Uib6p+teMBtWCHu38lRscicXjV9BMkolHdjo=
X-Gm-Gg: AYBFou1rlVBU25WBvH4tL5e3nHaShBn+kE04Jd3L+HL1rwBosYkJ29cLQz0GxOdPKXQ
	kEAO8mugH0/hhyG16ncIuU35RsrO92c4PlJDYqIFwYK8EQ98lFF6u3Yjbuyh8nsXxdupY+28b9l
	SaCoHHhdKPN81hyeZOYiG74zZl85kBcXrt04/G+St7Q1Ht36f1aolwck2uEJxChaL4II0Qa4JiJ
	HxINH9RheU3GPuBsoSaJh0/WiT44mC5MNAjH+R/d1uv3n5Jfw33hYCinG85eGcey3OByl60A/QJ
	Cg/5kSAFo8aHtuOYVLrnRmJ99V2GHKsC4cXsk0fMCwPj61Bng7LYUTEdgzPqOLvP0qBcTvLyRpQ
	IbA9uK2QgHp0lAmWqa/vwjhMWtcn75TxbB3NWH8RvInzYyYw/11IQjp5ENsZr02wpjYVzlai5AT
	hqiZRfziOtYZdck1eeK9rGzF57GiT9dWEFnYP4Aa9s/jRF8BAoMLoR9EESp7/ag2LoMUVj2M54E
	oq5VSGSP+ZE47DwyQswkYPXFofgPGjRqCFTYnQkz6tWAj35movDOQsqJn/r
X-Received: by 2002:a05:620a:2781:b0:93c:5951:38e9 with SMTP id af79cd13be357-93ebd28cae1mr3125418185a.52.1792085440261;
        Thu, 15 Oct 2026 10:30:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095bbsm825062485a.9.2026.10.15.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:30:39 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [RESEND PATCH 1/2] rtc: cmos: Disable ACPI RTC event before handling it
Date: Thu, 15 Oct 2026 13:30:28 -0400
Message-ID: <20261015173029.3091872-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015173029.3091872-1-gourry@gourry.net>
References: <20261015173029.3091872-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of RTC_UIE_ON can stop receiving update interrupts when rtc-cmos
handles alarms through ACPI. In one 50-run test, 40 runs passed and 10
timed out after receiving between one and four of five expected events.

The ACPI ff_rt_clk counter stopped at 218, exactly matching the number
of events delivered to userspace, and reported:

    218     STS disabled     unmasked

rtc_handler() runs in the threaded ACPI SCI handler and calls
cmos_interrupt(), which schedules rtc->irqwork. The work can run before
rtc_handler() returns:

    ACPI SCI thread          rtc->irqwork

    cmos_interrupt()
      schedule_work()
                             __rtc_set_alarm()
                               rtc_wake_on()
    acpi_clear_event()
    acpi_disable_event()

The SCI thread then disables the event that the worker enabled for the
next alarm. That alarm sets its status while delivery remains disabled,
so no update interrupt reaches userspace.

Clear and disable the current ACPI RTC event before cmos_interrupt()
schedules the work. The worker can then enable the next event without
the handler undoing it. With this ordering, 150 runs delivered all 750
events without a stall.

Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fa04ece151b8..fe514b1aa343 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -758,7 +758,9 @@ static u32 rtc_handler(void *context)
 	unsigned char rtc_intr;
 	unsigned long flags;
 
-
+	/* Quiesce this event before rtc->irqwork can arm the next one. */
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	/*
 	 * Always update rtc irq when ACPI is used as RTC Alarm.
 	 * Or else, ACPI SCI is enabled during suspend/resume only,
@@ -781,8 +783,6 @@ static u32 rtc_handler(void *context)
 	}
 
 	pm_wakeup_hard_event(dev);
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-- 
2.56.0

