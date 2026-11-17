Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906970;
	b=5UHk4kF6/x4Fw9Fy5CGcK+FWy/lx2Fn+gRzA5TCDHEt39tL7J00OHerrRxs/kG+h7mo5
	 ZRwsS0sZ63TwDBNlf1rE6zXj2ZRinXNLjqCJ7P5DkTYRkWOJP51jUMs4qMsN8plKtDQ+E
	 T3sNJ27dRgxooe7K1YQksmVHnEgKrSBPW6vSrklvsjJZlPqEDP1+bR/4VRMWSioUSL0I9
	 AFzmC0t/1EvL8C1TfGmnoTOtD6/uypI7UlMwugC+/88xWFHeN0gOxssyzC0jzj8clZilW
	 twWbx3l1V0jve2OF4Jj11T+Z83p5TIwHmgH5HW5LCRYhgMyV/T9TO6Al4fgJAgLgVgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906970;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MjS1kvczGJ9MD7C9i1acsvxqzRa5iS2JUD817p0tTWM=;
	b=zwvQXGYeI6XSh1WQQN5IC/GN0QIGgNWKCddJ6Cb1d4I6qtGywEgkBkDXuj/IeQWXCX3f
	 ZSdSjxOpNp0vn0wZTY3O8ZG7DFmcED5BEjULVKO2Mf+OGubgaxqH6eRltrNcxrsnUcGzv
	 G35XgQdFonbJVNPlxWvEWuYhRD5e0/3mIgGXaJ62v4YbKItKqsiC5dX31DiI0hf2aHsZQ
	 fuaWjtxmTCjX9uYO2vh+eCrAPaxXXuLzXxdFXUJzl4Gqd57gQFTyqg2T8hRvQX68kn0hn
	 +1V2fQedC6yvGD7t2d+QN5Ah69ubudvG/oa0EIaoRru6K9kElJhYlm2q7cdexUBqVrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HZwwMeYl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF4606A323;
	Tue, 17 Nov 2026 09:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDF4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HZwwMeYl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464FE1476;
	Tue, 17 Nov 2026 01:16:06 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AABCB3F673;
	Tue, 17 Nov 2026 01:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794906969; bh=lCkK9oimo3G3AZBfJSzQ80ZQq8ND0CMwQ9euKXpr7fw=;
	h=From:To:Cc:Subject:Date:From;
	b=HZwwMeYlp57BFJ/DWt0yIc/3A3B08h9xCqW4Fl9PUmeVluxEkzolL4ELsjzXJ/CnN
	 iTcxPG+m+C49gHyrcwShLmG/gJOy5CJyq2D/TnuZUIgMQlgdKsZp8XmCa3JSbb7ar4
	 qZzoCKL84/4nsD05CWt6KV7X4j5sgkw+ZuhS86Vg=
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: ashwin.chaugule@linaro.org,
	al.stone@linaro.org,
	miguel.luis@oracle.com,
	catalin.marinas@arm.com,
	Jonathan.Cameron@huawei.com,
	gshan@redhat.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] ACPI: processor: Restrict unsafe driver removal
Date: Tue, 17 Nov 2026 09:15:32 +0000
Message-Id: <20261117091534.895868-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
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

Hi,
I've had the ACPI CPPC lifetime issues on my list for a while, but I've
been hesitant to restructure the code again. Looking at other users of
the same removal paths, I found independent failures outside CPPC too.
Do manual bind/unbind and processor module unloading need to work, or
can we disable them for now instead of fixing each affected teardown?

Manual unbind and module unload can tear down state still used by the
acpi_idle cpuidle driver, processor_thermal and cpufreq. This series
blocks those two operations.

Patch 1 suppresses manual bind/unbind. A second unbind after a nominal
rebind dereferences an acpi_idle device freed by the first unbind; QEMU
with KASAN reproduced the use-after-free. A separate test left a cpufreq
policy capped at 1.6 GHz after processor cooling was unregistered and
bind reported success. Manual removal can also free CPPC descriptors
while cppc_cpufreq, amd_pstate or intel_pstate access them.

Patch 2 removes the processor module's exit function. Its cpufreq
notifier otherwise leaves QoS requests attached to policies on unload.
I can also reproduce a use-after-free without CPPC: unload processor,
destroy the old policy, reload processor, then remove a replacement
policy. Module unload can also free CPPC state used by cppc_cpufreq.
Keeping ACPI_PROCESSOR tristate preserves late loading and load-time
parameters while normal rmmod returns -EBUSY.

Ordinary CPU offline/online does not call the processor driver's remove
callback. Physical CPU ejection does, and is outside this series.

Christian Loehle (2):
  ACPI: processor: Disable unsafe manual bind/unbind
  ACPI: processor: Prevent unsafe module unloading

 drivers/acpi/processor_driver.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

-- 
2.34.1

