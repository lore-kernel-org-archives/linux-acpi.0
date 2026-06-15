Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 661323B19B7;
	Mon, 15 Jun 2026 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506463; cv=none; b=ICjVuxcz25SW22kcvHX/UKuE6H4XCi2cyJPClF/Hj5k+leHl66r/lRRAI2h/1qGDiyuh5F2DTjJbXRnCtQFE0U54HORADsQ+zD400AwiF/Pg+Bb9Pcds9WHLRpVPihmQ3ZVJFrsp7DMjzxGaRG0GolrULx/GZztLqvX/04zoWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506463; c=relaxed/simple;
	bh=fBKGufv79DV1yo4PRkjLnnaosbrw2IR3W3V/ilSfgG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDm3iTrE2n+TfflgVVg4WNGBGfG64fyDQdiOBnjkmqExcshA8bT++Dwk8T2hp05VDOknreaVgYGiYoqzjT4RXKV81jZ0f10wEERYtzSwsGYVLBf+/cEIO23ATK+EhwlS+PEE3tx2JQY46D5Ywaw+qN6SrNv96km2RjDGShBED7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=eR9JMr3c; arc=none smtp.client-ip=220.181.3.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="eR9JMr3c"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Sudeep Holla <Sudeep.Holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] ACPI: processor: idle: Add __cpuidle to acpi_idle_lpi_enter
Date: Mon, 15 Jun 2026 14:54:01 +0800
Message-ID: <20260615065401.4611-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781506449;
	bh=bvFmYaMlQnQ7txn1i0luj6Vjw0Q2TvEoIXKYnjrFuPM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=eR9JMr3cKlV3JfCSCz7YNs8eCKDyP/tT2V3jNkCzJD8J3CNOSTbrWXU7dnZdzN4ol
	 kz8vkuTDkuVrIXqCZiQcsi2VYPpSMa/czo5W0ufhpPRse+MfOpTeDKhLheZOqdwLcz
	 bQdFvzyf806YrSDNxIb6XxT8v+jBE6e7QRtrUktHJpVpfoZAODl0+1LYHh9o9CrJne
	 OM4QZaZpdJDXziDhenLfAM0HmOEptHmBPvPJPDFgU8I33QdYpAJrEknPJ68FI8N912
	 iC1weYDbAU1H00oWZiUn9YUn6PhesHMhkWgC6lc8r42dHZ3ryvoQUT3Xr/9/G5T9MT
	 fx+e5u1d8vQJw==

From: Li RongQing <lirongqing@baidu.com>

When function tracing is enabled, entering an LPI idle state
triggers:

  RCU not on for: acpi_idle_lpi_enter+0x4/0xd8
  WARNING: CPU: 8 PID: 0 at include/linux/trace_recursion.h:162
           function_trace_call+0x1e8/0x228

acpi_idle_lpi_enter is called from the cpuidle path where RCU
may already be disabled. ftrace's function_trace_call checks
that RCU is watching before recording, and warns otherwise.

Mark the function with __cpuidle, which includes notrace, to
suppress ftrace instrumentation in this path. Other cpuidle
enter functions already carry this annotation.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5facc..0ca404b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1156,7 +1156,7 @@ int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
  *
  * Return: 0 for success or negative value for error
  */
-static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
+static int __cpuidle acpi_idle_lpi_enter(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-- 
2.9.4

