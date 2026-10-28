Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210243;
	b=SP/b0WvdNGQ+7OomGaxdtjhNSl5yY3DOIDUQVOFmImQQ0AM887SdwZGYA563uiVZ+uOS
	 RFFfQGF3/wAv0zu/ba+n8PWEhgIE3Irz5/HvpG/tt1sRJk4WuOfh1eTUQgnQe+ezSd/jf
	 Jt58aVb8/NEyEXoBPTDOggB1nWG4VA3NrYOUCEQoMYHgDrpcrxD2WSvxzmvAKsGeem1Sp
	 uOcktNQOQT5dWZAFOaWllD+e3OYCpU3pGo8qOCff9n9v3121FdiEFpXagm16/oVhUwcDI
	 1WudxHJQZsuK0nR5yTB2VFqJt5JVmsirBjb97+nTb1SRWI497QSz9F9uvp/JGHQZNcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210243;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=leRsxSy4HxY9FAGDz3nMFd/+TourUtvCbzF0rPFp6Co=;
	b=eL7x0T1pp/wSrv1w0T6vcR3T4L1cHb0U8c9crVQD352ykDBYgt5tOGdfdFnUqInYemot
	 zROW8g+VCmvuO+kusCr9rSEkcPBCtWXc4Tzf4wzYtN5nAd/XmSoBwNqpzX3+NlD9C3xbM
	 aY59NoHA59/sLvkcU/3zVcrqj9UScs6M7yymkxeK1nHi5VlAnBasc3N0oZ6LL3OoDLP5R
	 4wjLxNn6yDWH7hj7SuxdoR1hkDy1ZKA/YYTfcF51BYR2ZenWYA3xtL+I+RvM4xl14xSYv
	 GFw8GVX7Yoc/qjdlEe5igs2gbHwpY3SdJCtx5pirM5KeZK6rcKVu451YFQ4UDs50+pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCUHuvUW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E506606A31C;
	Wed, 28 Oct 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCUHuvUW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793210242;
	b=GYE9exK0uq73iBjkxsrru+SwK/uMU9xUxlzfoWFvbU4+dpHWox/U3WQXTQkI9lnl78kG
	 on8ZKN9VFepqfqoEy0g2L92OTrRwOfmXRseTw5kBOUn570rDDm/6yrnWHZB2HLgmcd3H6
	 DTWzQE935qAGCha0il+FxUwQf70AVit1yLDIR+efmiT7v+BexBHOvPPDJp+J7MN2rjYWR
	 3xk9ciFPfR8yWjOyHG++HPNwspTAYZaTQ6FrBJZv9ORu+P++AdqfeRDU3zuoUpuQZOi4Z
	 VIMY+Cv6EtgYh8VLBTDl7bcVGYFuNHtvpdln/MRtAck5o1fETU3HVJeSTcORfHqwQhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793210242;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=leRsxSy4HxY9FAGDz3nMFd/+TourUtvCbzF0rPFp6Co=;
	b=qOH/qtD20h1ZXwD9HuirsA+AIM10PCiD6fs99aKHA97Fg7lmdIeeK3uR5f79k8U2Y09S
	 cYVMXDja1DQQPpTzuM17Wu53LzYgAl7toV5llNMVYk9E5EYshsm9Z4ru+qdhrG8zgRFB0
	 eFhfwAEqsLAv3oyB3ZiLOyNlP477+iTBiSAGQRnAzZnpchX4Irb1qUVdxvgY3Ct7AOSOv
	 zhieC35h8X/zM0Xd5YK2uK9taNy0+JTzYaK9eV61BPJlrJQSllGOs+bt0LdKpqhfnqlYx
	 L4fB68KhSxza8tLneQM/UrucGxhL7dPKxcyop8zY3g7EAcUG9NPWIrOwMG7lZnKtbJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5140A1F01825;
	Wed, 28 Oct 2026 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210242;
	bh=leRsxSy4HxY9FAGDz3nMFd/+TourUtvCbzF0rPFp6Co=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=bCUHuvUWEa/xBFDH7xzE3E0vLHDQ25wn8b66t3tXVN3xa4JuxVap8jtasl2V8BfaJ
	 eXLPklp1r2i7TKJd0xr4c/bnOBFYtMnLuTUmGG4tna1atEpKY/V6fbcGzXCOmkSdGI
	 CsWcJxBs/ojmvdOnKtnGXq4Abi/PF3px2k2Jp7763nJFyju1Ie4Z9VCjx+y8Ey/qpM
	 3ksnupZc9ZbIyNkoZYx2KrCaiL7oxBQrCVju0Q37pCnNOZdBgLcGKY2nxrd/wNf1Me
	 AyhOluWAxNVvJ1MOYp6ODkMPboyJ7cPvc9KY1FgbH1ds0NG+Kz270K+CNS7OiHDqwn
	 7S1nwYAQEKwfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D69A34551A;
	Wed, 28 Oct 2026 17:57:21 +0000 (UTC)
From: "Ashton A. via B4 Relay" <devnull+me.ashtonantila.com@kernel.org>
Date: Wed, 28 Oct 2026 10:57:21 -0700
Subject: [PATCH] ACPI: processor: thermal: Do not leave a stale limit when
 not throttling
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
Message-Id: <20261028-acpi-thermal-stale-limit-v1-1-4b0ab3230f01@ashtonantila.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7oDJopZepbiYxLFOiVYyUQrBu
 3dqNx8e/PcqKGdhhXtTIfMuKu/FwF0aiBMtT0YZjMG3/upaf0OKq2CZOM+UUAslxiSzFOzIBXv
 YDgFMXzOP8jnTj/7PuoUXx/LrwXF8AUJ0NY98AAAA
X-Change-ID: 20261028-acpi-thermal-stale-limit-7a1b102a1bdb
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ashton A." <me@ashtonantila.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446;
 i=me@ashtonantila.com; h=from:subject:message-id;
 bh=x1WkoMix8m2IRMmaFk2Qs6ugRzKiV6VPomK9EBpWNAM=;
 b=owJ4nJvAy8zAJXborYascAmTHeNptSSGrEfmjdUsZluDn3d4J9aqT+UoTdyVE/2+su1mz80+y
 wP193VZOjpKWRjEuBhkxRRZ8kR2vQ3duPnrzMo1NjBzWJlAhjBwcQrARAJyGP5pH11b5P504o7P
 y/ZdbmZdcu8f04GaS2u62tKqpLJYosr9Gf7XXLAsYlDTPjE165BBw1Nv9oZ5fRnVHMv8uR6eEPW
 f9poDAC/fR6M=
X-Developer-Key: i=me@ashtonantila.com; a=openpgp;
 fpr=6E42C46BEA7CB8965829F486494594D16730FDC9
X-Endpoint-Received: by B4 Relay for me@ashtonantila.com/default with
 auth_id=1348
X-Original-From: "Ashton A." <me@ashtonantila.com>
Reply-To: me@ashtonantila.com
Content-Transfer-Encoding: 7bit

From: "Ashton A." <me@ashtonantila.com>

cpufreq_update_thermal_limit() sets thermal_req to cpuinfo.max_freq
scaled by the reduction step, also at step 0, when no throttling is
requested. cpuinfo.max_freq drops to the nominal frequency while boost
is disabled (amd-pstate, and intel_pstate with no_turbo), so a cooling
state update in that window leaves thermal_req at the nominal frequency
after boost is enabled again. The CPU then stays at its base clock
until the next cooling state change.

On systems with an ACPI thermal zone that has a passive trip (_PSV)
with the processors in its _PSL, such an update happens on every
resume, when the zone is re-initialized and step_wise re-applies the
cooling state. Suspending with boost disabled, e.g. in
power-profiles-daemon's "power-saver" profile, and switching back to
"performance" after resume is enough to hit this.

Before commit d15ce412737a ("ACPI: cpufreq: Switch to QoS requests
instead of cpufreq notifier"), the limit was recomputed on every policy
update and could not go stale.

Use FREQ_QOS_MAX_DEFAULT_VALUE at step 0, the value the request is
created with. ->verify() already clamps policy limits to
cpuinfo.max_freq, so this only drops the stale limit.

Reproducer on v7.3, ASUS ROG Flow Z13 (Ryzen AI MAX+ 395, amd-pstate
active), with N being any "Processor" cooling device:

  echo 0 > /sys/devices/system/cpu/cpufreq/boost
  cat /sys/class/thermal/cooling_deviceN/cur_state \
    > /sys/class/thermal/cooling_deviceN/cur_state
  echo 1 > /sys/devices/system/cpu/cpufreq/boost
  cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq

This prints 3000000 instead of 5187500. With this patch it prints
5187500, also after the power-profiles-daemon suspend and resume
sequence above.

Bug 221795 reports the same symptom on another ASUS laptop with the
same kind of ACPI thermal zone.

The issue was diagnosed and this patch drafted with an AI coding
assistant (Claude Code, Claude Opus 5.5). I have reviewed the cause
and fix, and I take full responsibility for this commit and the fix
included.

Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221795
Signed-off-by: Ashton A. <me@ashtonantila.com>
---
 drivers/acpi/processor_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 11036f0d2b9..3663a54c043 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -97,8 +97,15 @@ static bool cpufreq_update_thermal_limit(unsigned int cpu, struct acpi_processor
 	if (!policy)
 		return false;
 
-	max_freq = (policy->cpuinfo.max_freq *
-		(100 - reduction_step(cpu) * cpufreq_thermal_reduction_pctg)) / 100;
+	/*
+	 * cpuinfo.max_freq changes when boost is toggled, so storing it when
+	 * no reduction is requested would leave a stale limit behind.
+	 */
+	if (!reduction_step(cpu))
+		max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		max_freq = (policy->cpuinfo.max_freq *
+			(100 - reduction_step(cpu) * cpufreq_thermal_reduction_pctg)) / 100;
 
 	ret = freq_qos_update_request(&pr->thermal_req, max_freq);
 	if (ret < 0) {

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-acpi-thermal-stale-limit-7a1b102a1bdb

Best regards,
--  
Ashton A. <me@ashtonantila.com>


