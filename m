Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD805CDF1;
	Sun, 30 Aug 2026 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052788; cv=none; b=FZm3+zprtAPCTZU4SAdx2Wl2xjwrxk5C1G8vim89k0tL0F301ExmHtOUwBdyR3wDrnsR9NHdhBmSOcupbvQG0p1SyPbdLeEOineuTvZzY21NyjmLfn9mtCZIDiFOdnvdMMgF1jSxkb1gEjGttdyf7VTkDu85BQ8ZTIJk7ZDZl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052788; c=relaxed/simple;
	bh=bBAVkR7J+jhX0M7p7q3MN7iF+qUyn8nYAEm7xPP/ViQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=nUQ1B71WqfJC4AG/vKL6FhYoGkUfI/Jx3mX3R9y+y/QklwgTemJZZUFRrKGxwm3wJD5y7Sc6ycZzCqhypfWUvfSfY2PxkqxkkjEQixLHEBicFtkGjEaMANZkMhRdOSp2QK8+6WM9+9yB2R2yB3g/pxRBbllh0AMoxyVE4WHWBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cdine.org; spf=pass smtp.mailfrom=cdine.org; dkim=pass (2048-bit key) header.d=cdine.org header.i=@cdine.org header.b=kbkO5tKR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Is4J8Lo5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cdine.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdine.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cdine.org header.i=@cdine.org header.b="kbkO5tKR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Is4J8Lo5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E7F74EC01CD;
	Sat, 29 Aug 2026 21:19:44 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-04.internal (MEProxy); Sat, 29 Aug 2026 21:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdine.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1788052784; x=1788139184; bh=UX
	iJMnQXlpvgzMAbhK9ZBau3/cDbZtLOTU5YJvvM34Y=; b=kbkO5tKR+GSpYzMdKw
	MquGZ9cQE1Iekudf0u8RQbfHtWYo79H4TGZoEBvl4uDRGV+VnmJqstgAW7aDoP+q
	R33P/+XGlsX4nOtmmsdYbPXjZghNh9HM8pnFQEhoBP5Vy3Gp1kj7pIb24j13NBVP
	PP2dSNAMxz80+pRF0VylaiLan5+VWoInl8cwceHnlmESz5oGzGrIATzJ4moCYk3b
	AuRX1gyZeLlaU8z+qi05rvuOFijRJHYkXMZJeGPlR8Vo7gA/fi/ioXvNbe0kzU/5
	X8kK6abMW4FwOfEO1nYWvDGhji2DS0we65ep9fSOfcXy/EWR6skCQcApuu/JbsRw
	YA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788052784; x=1788139184; bh=UXiJMnQXlpvgzMAbhK9ZBau3/cDb
	ZtLOTU5YJvvM34Y=; b=Is4J8Lo5xj1OBXj5+pibuPulzY8RI8bs6BV1dhS4aWV+
	nautOIGzMN+LNOZ7lLli1+0r7jK8dbBt6awpTvKd0sPNhGiTVzbFe8f8sq32yHQm
	3HY3gf9DDgnEsfsEoaFbbozsTnHtVkg9P1l9pnustUrvWyTWCVL95ISv7X1KuDpV
	1hCSICjLXi+lKsEFXT+xxdbpUHzCTKGm0TBxRB2UTFqWRX4I3Kwt2ea9rz89Mms/
	XLXbhMbOcK0SbQndyDHz0cTPbl2ecW2l7rz+x4yWebavhs83d/vg5FJec8SJDakq
	0m51Jec3vqbKzWYGveNRqxaBrYrcHz0MiSrfxnLDXg==
X-ME-Sender: <xms:MIWTapRcbVj-2LmtONgOCwixdm1gzUnkx7jQPMcuo-fd86NcOX0hMw>
    <xme:MIWTatk2vHPEEOmhmapLgAq9PqHht60cnizajVRTEqGbQBHjxcjbS2RgV-ZTuL8Ee
    MJp1H47l4SHS7MtywMUGGNU0oBOKdOD2OeyBxjZv7Kn5sYG4ew_EYg>
X-ME-Proxy-Cause: dmFkZTFMi74plZTRsMMynkByVRAUtnbyL+SZggYx/IHooXpafqWQB2s6mEpYhLzZ8Y4KcG
    pZNnGwAcCmQFSVTJU4TF6N7ssJKp6VrrBz09aL7YYydvh1tKajD9Ie5NriA4p8dAYs7Y7r
    ho40UAj/UsVXnvKNWWDRa5a7OKjF/FOueuO7MwA3e1wG4uqsFMvIGNsllJW2e8FExpg+xX
    oMShqIdcMr5BjJA5xapfy6afyU7B9ClU6p6zndjvCV+zsAuQoat0fTN+T9p1XYjqU6IfEC
    N/MvnQWFlkFqhE7KIJZnaoLjFtqTyKbJBzFOkWuK99J+rHCYCeDTSUcrZP8OoNpuy6ZkOJ
    ca7M5pOq41KA6OiYTu+v9ddxRZ6KxKju9NaaEQtwRaBIgUKctKTrT+WKelYvp5KK/+YiB1
    Ahx6q0WivDn1PuswySHb/jMtQigS+8w5sKSHVN/EzWWQtEvp5J2cumm9PibG0pA4uM6Db0
    em3yElXUaQo8/KPu8llxkNalC15cNYaR/Tw13ZwV+9cjfqEBLfLnY+zY17wYXjNk7q6e8L
    /jUPmEX/kUkjtgyAgRPo9ToEo9LOJeT45WIRyjjf0BAJsNJahJds9jyBm9O6qCGvWVZc09
    NMfseqSlWzcPRDdVK5oM3crG19kU/cvCxvitlYnkj20Xa2oD7sVm3DiXZ7AQ
X-ME-Proxy: <xmx:MIWTag6a8y5-j1BQoB9BFyuoW8sfmmAKJqJtro0bloV6_XRZgWk0kg>
    <xmx:MIWTatV5n1FeTf75MvK2tXA0f5NxRsHxIZeRkO1AWWdpMkkDZCSAhQ>
    <xmx:MIWTai9Ro5acOoKbTgY27ltGDbE7D-CQV4TBnOP8lrKuyVJTkbEaMA>
    <xmx:MIWTapmx-pJJTfc-qSgYMGz7AKqBYgo6v0OPcfRFYYSMsJWn1BJKLA>
    <xmx:MIWTauvTc4sBq5tuoBqDOizrwaaLhbULwhlLXPYSTexeqYjZEgYYrWGA>
Feedback-ID: i7f6c46dc:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA2CD18E006C; Sat, 29 Aug 2026 21:19:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Aug 2026 13:19:24 +1200
From: "Ian Gallagher" <cdine@cdine.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Message-Id: <90ab9b58-da8b-4ffc-bd4b-adf7590545a9@app.fastmail.com>
Subject: [PATCH] ACPI: button: Add lid_init_state quirk for Razer Blade Stealth 13
 (Early 2020) RZ09-0310
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds a quirk mapping for the
"Blade Stealth 13 (Early 2020) - RZ09-0310" laptop, which exhibits the same
issue as the following two related products already accounted for in
this file.

- Razer Blade Stealth 13 Late 2019
- Blade Pro 17 (Early 2020) - RZ09-0329

Summary of the issue this fixes:
The firmware's _LID method still returns "closed" after resume when the lid
was opened during S3, causing systemd-logind to suspend the system again
within several seconds (15-40) after waking.

Signed-off-by: Ian Gallagher <cdine@cdine.org>
---
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -146,6 +146,18 @@
 	},
 	{
 		/*
+		 * Razer Blade Stealth 13 early 2020, when the lid is opened
+		 * while suspended the open notification is lost and _LID keeps
+		 * returning closed after resume, causing spurious re-suspends.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Blade Stealth 13 (Early 2020) - RZ09-0310"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
+	{
+		/*
 		 * Samsung galaxybook2 ,initial _LID device notification returns
 		 * lid closed.
 		 */
