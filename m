Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113414;
	b=SzkcRsUyyb+MwdWN431hO20SbntUpJdRIM2zAAUjOgdpPxAhlv6DO8NI9IFDqQslPKXa
	 GMzdu151E0CldcOwmjsdygoUfmxCoOTLxeH8nb80l4j/bwo7PC72l3GK8qFWgsZHgaL2w
	 RpATBzNMx/BJw09KDOvoc8t7ID0d89FEsXk+HeCYirlZYKaJBOUcEovz7vB21cGyI9neS
	 oHqXD0FMrUeeQkF5qECewa79FQqFbgrUGR0in7U+bLsElMaMiQDJvtl0e+VGTE+TiCDUL
	 5jZ9VbLV/DlmOIRNiXi/PER6jBkkTPN68ZTy+SnY9Va5YalmGGsNGUVmWs8be7QO1UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113414;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eRS37zsfkOJOU8eYMJMXWPS/vrfoQ410+ADA98KKDdY=;
	b=B0svSLnDz5y3+2VTg3tUKyI+edAk9iOkUP7tXIOaE31TDu6yM1Ofog4Q/p03XbxSdwjv
	 FxQ2FRS9nbQ9VHTuhjDyooYPDWE6+6MQPPVNU2Lxz/GGoT4KjlPMtbwlyDlGd9Hr6BKym
	 3hv4HHDhDuRGNbH7ElZY36u4V323PxXbMaElpuOFxGMtnPrptfyn87LQVVlpNePIgni//
	 7MtrhTvIr8nLrKQnHGqCJKUbsKDjltRWoGvV2/1z6Mc5NhjZV9G2zxaVQmBpTj41sRdxz
	 IgSMkzOTHjtTTCIVDneMZnwIGLLn61lXEW9shQ45PNiCl6IX9Fk2ZxLWSG0WQ+5PDaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK4ZbTIY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1F606A331;
	Thu, 19 Nov 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK4ZbTIY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795113413;
	b=m9TkGpU+wi2NDZbPy5dzQM/53Wv3mI1kByQe1AB6+xpSH+r/icH59o3Zwg6yPg59wJkH
	 5R6llBgIei1M8TdFa4/HYXahGLhAMb0U5m9Rc1X5oBUZrJhdqv24ZXaVkklDirtKPQ5vp
	 mg9Ao9PzEOxyk63B8GM5s2zj02ED9jCFeoyMmKMu7Tb9I/rn7yazKfby7qZVliNaPNEgY
	 5ZZ9AJY4dHk6US2Euaes5WzsBULk9ZWKETkk+CNG79p7eo/cri+bLcHGuWSGCZi/H+Lh3
	 pxTKRast3mckapgQ5im2W9cr8OcwladtPaw+7jLC9uEK/T1FGMrBVbf7CmQ48G/iAJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113413;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eRS37zsfkOJOU8eYMJMXWPS/vrfoQ410+ADA98KKDdY=;
	b=OQAfMu9l0W8swENFngXnPduu3ThB3nkriGfYUigsPsxBqJNGHq4+eGYauVPfzyGSF97o
	 E0iaAfM2Waxb2HrUAVU0aMPSwJFCy6ABWom6DTFkfHSMU05Q8JEFWXocLNa59vlJ0y+RX
	 ul4XzLfuwSaptp9m5FvJQsF/HWSt1znOAAFTRiFRwaueg2AjLbhDhdjwX/BuFYhlBLg07
	 I/XrJmATgyI7Y9WPrxYhfKwoxSpU9Cx7peLtRa3f9V1cYHa9tPDUYWjoY80bwb1vqOr+b
	 5p6x5kT/BmAq0tOmUfLsOPk2Qf77/KFMezhxh0htMxUUhqwl9dulblgCyKGdL7QM+mw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AB3881F000C6;
	Thu, 19 Nov 2026 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113413;
	bh=eRS37zsfkOJOU8eYMJMXWPS/vrfoQ410+ADA98KKDdY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ZK4ZbTIYHTeoNrJwrzCA4dfHwb6LhONEi9I/L9yCF7lsOPN7Ec35rHTiBb9fg+J3O
	 Lkdmge4vWwj7UVPByk0eh8xdLp6U5Irtf8PqQuqdYW1cSOLzLegr3P6lTzZJXtSvNj
	 1OWKWFcJ2tZHO0DqU2RYnxx5/1/Nj8du6PM/8H4ULZFa55k7A5hxJteqCZXszG+zYi
	 dvfDl3YJXqixadXxBKfx+C/Kjzi6rdWZCNbRCN9qVUFgMSTwY+cZClxqlrkbBsGx1/
	 C9fFzjVBNLdzLzgxnt4uCigDJSz2gv/QhLvbXdnlDSQYnV7MVvkDiWsK/ZWZaUwL3L
	 3uBfBwDXPvbYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3BF1E4B3A2;
	Thu, 19 Nov 2026 18:36:52 +0000 (UTC)
From: Ahmed Abdelfattah via B4 Relay <devnull+me.ahmedabdelfattah.dev@kernel.org>
Date: Thu, 19 Nov 2026 20:36:51 +0200
Subject: [PATCH] ACPI: APEI: GHES: Poll error sources at their poll
 interval
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-acpi-ghes-poll-interval-v1-1-6f45cc65fd62@ahmedabdelfattah.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDvQicWaXqW4iHHUkRBDxkpBv
 HvTdvkW/x+gnIUVHtUBmXdRWWMBXSrws4sTowzFYK6mISKLzifBaWbFtIaAEjfOuwvY342ltr4
 N1tVQ6pR5lPfv/Oz+1le/sN++OzjPD1CNW/97AAAA
X-Change-ID: 20261119-acpi-ghes-poll-interval-b7291834d9a3
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Ying Huang <huang.ying.caritas@gmail.com>, Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795113411; l=2604;
 i=me@ahmedabdelfattah.dev; s=20261106; h=from:subject:message-id;
 bh=b0r7uAsefW4rVRodqftRqt01KuYseuhB6b4wZW5DsI0=;
 b=7OeOLkqnaiisgRhsJRFMAxD2RZOD5klGHMbhOVzIgcqVOe3WSJrNsz+Rl9honXUPN9vy3ZXh0
 f3pkdBlhqU6AfYOGiilsbOa0ms60LZVhpRENZ8NoXPgebQSrMXSSs8v
X-Developer-Key: i=me@ahmedabdelfattah.dev; a=ed25519;
 pk=DHEHKU4PddrkJ/iYMZpwyyXsFyIQ6ySjTttKLrt9YqI=
X-Endpoint-Received: by B4 Relay for me@ahmedabdelfattah.dev/20261106 with
 auth_id=1438
X-Original-From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
Reply-To: me@ahmedabdelfattah.dev
Content-Transfer-Encoding: 7bit

From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>

ghes_add_timer() passes an absolute time to round_jiffies_relative(),
which takes a delay:

	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
	ghes->timer.expires = round_jiffies_relative(expire);

round_jiffies_relative(j) rounds jiffies + j to a whole second and
subtracts jiffies again, so what gets rounded here is 2 * jiffies plus
the interval, and the timer fires up to a second away from the Poll
Interval in the HEST. With a 1000 ms interval, on some boots the polls
come every 1.5 s on average, for seconds or for minutes, and the rest
of the time they are anywhere from 0.75 s to 1.95 s apart. A 250 ms
source settles at one poll a second.

Rounding the delay instead would still move every interval that is not
a whole number of seconds; a 250 ms source would still be polled once a
second. Drop the rounding and use the interval as it is.

Fixes: 81e88fdc432a ("ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI notification type support")
Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
---
I found this while timing a polled GHES in a QEMU guest, with a HEST
built for the test (one polled GHESv2) and given to the guest as an
extra ACPI table.

Tested on v7.4-rc3+ (4405c18c95d2) at HZ=300, tracing ghes_poll_func()
with a kprobe. With a 1000 ms Poll Interval and without the patch, the
intervals on three 10-minute boots ranged from 0.77 s to 1.95 s: one
boot averaged 1.5 s for its first two minutes, and the others
alternated between 280 and 320 jiffies, and between 240 and 360. With
the patch, every interval on three 3-minute boots was 304 jiffies
(1.013 s). With a 250 ms Poll Interval, the polls settled at about one
a second within the first minute without the patch; with it they come
every 80 jiffies (267 ms). The extra 4 and 5 jiffies are the timer
wheel's granularity at those timeouts.
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5d888c82efea..92d54c6b209a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1276,7 +1276,7 @@ static void ghes_add_timer(struct ghes *ghes)
 		return;
 	}
 	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
-	ghes->timer.expires = round_jiffies_relative(expire);
+	ghes->timer.expires = expire;
 	add_timer(&ghes->timer);
 }
 

---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-acpi-ghes-poll-interval-b7291834d9a3

Best regards,
--  
Ahmed Abdelfattah <me@ahmedabdelfattah.dev>


