Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C82E7F3A;
	Wed, 19 Aug 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170568; cv=none; b=S++1a3A3i7mUuP80HK7iV8S+g2fX7M82gDKDKtJDJ6qiDWc1NXLnAGdeZtz0NgK7kF3sFozzdUzFgyo3gYFuI/WcXcohZlzkdM7+tpZVjRHc6kryVTH87SG6qX4UONnJj05knS6cPEjLnDjphzOeLLrLgKGfjm4PAAIn9MdchbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170568; c=relaxed/simple;
	bh=6XJRCr4BLlghvTMmBdYC2HCOKClI4rlCt4oQqwlHdEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3j1DKKG2L/vlSAem8S0+8Z3KTQi5FzKnu+bRbVU5+meb7Em+qHs2vUjbH0SME5wt3DN1uRa2Wmk3aXm1uxDi4E9c5SCXEtRxwDykLcNvhqtpKp1qI8AyeVVH9OMe22G61KdXKyX+C3ARH6sk2dqEhFXo4eOIDHtIw5qm4tcY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTJaL3fQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTJaL3fQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7231F00A3A;
	Wed, 19 Aug 2026 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170566;
	bh=/quJiVVjvx+QYXmUOPvcZFzCq2jM4zCcwoljT7Pgkh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTJaL3fQKj8mUxzyd1wRCNIbDovge0SZz4T3Ai/DzGBMbnXVYs8r68bURGBXJL8ae
	 pljYqDaBuM5yPRT3z3lGTvJPyCb3EUrhncKH1B2K+8hjrJ7jdYsAbDL8XOnUBCyV5e
	 xYbCcro+3bRY84D8igjz7F7hmrbcSHOVYtR2fTIsmMUxUX4hjHl1wwQ/50b8QoGWZ+
	 EYOK+Dgi0q0XcdidE+6r4yLlYEtrjLrTZui9JoqUaqO/n147rA+nWh3103Wma+iVFG
	 vX1CR0TtACScLCaoReAgp/y6vOd/w2/4L+zfcZGMUV3oV/8ctjizVKaTah4ycLz/51
	 jC4RlP3HKVDoA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Colin Ian King <colin.i.king@gmail.com>, acpica-devel@lists.linux.dev,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 1/3] ACPI: Add Bob Moore to CREDITS
Date: Wed, 19 Aug 2026 22:12:34 +0200
Message-ID: <3711645.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <7982261.EvYhyI6sBW@rafael.j.wysocki>
References: <7982261.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To me, Bob is a silent hero.

He had been driving the development and maintenance of the ACPI
Component Architecture (ACPICA) project for over 2 decades and while
he was not vocal or otherwise visible too much, he was focused on
improving the code delivered by him to a community reaching far
beyond the Linux kernel.

Bob retired from Intel earlier this year after over 40 years of
continuous service and departed from software development as far
as I know, and he is missed already.

The kernel depends on Bob's contributions quite a bit, so he
deserves a CREDITS entry.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 CREDITS |    4 ++++
 1 file changed, 4 insertions(+)

--- a/CREDITS
+++ b/CREDITS
@@ -2906,6 +2906,10 @@ N: Thomas Molina
 E: tmolina@cablespeed.com
 D: bug fixes, documentation, minor hackery
 
+N: Bob Moore
+E: robert.moore@intel.com
+D: ACPI Component Architecture (ACPICA)
+
 N: Paul Moore
 E: paul@paul-moore.com
 W: https://www.paul-moore.com



