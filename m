Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727557;
	b=FpPD92D/CJsMBXgaWNrkTV6aZgvxGbQGrslQkno1W3+oxB/9W12nKjgBwAMUj+1Mmy1W
	 Kp4menTTsafMLeyuUmzy4IRe6mjlayL0qDRdn878dw+yHWWDgro9fhTwBpjmGkUr81dMq
	 e/f+lWx+67fMztad6YWkKwOU5JTqRpul+0txCPBu5ASOejDqmrzbdBzKaOMnwny/qddIF
	 CM2Pqe4H2HMtiP4SV9EQxy1TqfmfHVlAzuc3BWNXnikC4T1we0mcpvsw6SPN54w4xfZle
	 947I+0e+YenN+06PmZSpIyhBPfxaekSEoZsxfWsyXACe3rI+8hgq3wU+72zutofzG+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qi31N6FLLr5CvBbEX306qs395sf+fpsGjv6D4cBZe8Y=;
	b=zjBCMe8wf3iyyJl3/SSP1I9Uhcna2eOIzck8wFIkRHmnmQWTvsdfPg9lfJLO8ALx0MLG
	 RKjd+wwNg3xX7YtHj0/WM1BWaVbrKiobXux1wckZEfZ8Y07xxiAOKpQEweO/SuYBNDBlK
	 vqO4Nl7SgyZtyLWPUBrgm6o+nc83y+CEUaTiW0bMPbpRk2wCts6/GWksoFJF2oQlBZDJr
	 k58bPwkNCUygMQAegHUJNTNPMezLKUjazxxbvkZxzxx52bY47X0JaXKRPPOq/7BgisqKW
	 PdYzQWFF46PXKLRa3C7tEO/M7foYeO8fnpoqVvBS88ZVwNg8gPb3w6tdRPzd0M645ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc+TFfd3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7C606A32E
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc+TFfd3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0161F00A15;
	Tue,  3 Nov 2026 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793727556;
	bh=qi31N6FLLr5CvBbEX306qs395sf+fpsGjv6D4cBZe8Y=;
	h=From:To:Cc:Subject:Date;
	b=Nc+TFfd3eoGHScAVVuQyyci8+gBu3y+2HHDkIlXYe9BE8rm2QhZFNC+rv8RtbnP28
	 RxBe4J2trJP3qHIIm1ZYpgBh/xHKXNMxxREi7nKaodwEFR8l8ZMAOBH19enV5W8LIR
	 ww5tStQ/5Kl0tArlJIOrsGACk5HHS0tsu5RllQfD7gUIXG3SaeeCJnWLfn6DdkW+lZ
	 ec3A+llXC7yfjrx0+PYGD8UPD6rawxtKkvuAiED/hcxZKDWm3hXe8J0Pto2LMJSXel
	 893WS1OG5ehiqq6IHmArwLl+vNl0Ql7kkRyc/SiIwZ/0bq/mr7g806hKnOaLL4tARn
	 js8y04jRFmuGA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Jamie Nguyen <jamien@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dat Mach <dmach@nvidia.com>
Subject: [PATCH 0/2] ACPI: Arm FFH: Add support for OpRegion Offset 2 (FF-A DIRECT_REQ2)
Date: Tue,  3 Nov 2026 17:39:05 +0000
Message-ID: <20261103173907.1996118-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
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

This patch series extends the existing Linux kernel ACPI Functional Fixed
Hardware (FFH) Operation Region support to accommodate FFH Operation Region
Offset 2, as introduced in the Arm Functional Fixed Hardware Specification
v1.3.

Background
----------

The Arm FFH Specification v1.3 adds support for FFH Operation Region Offset 2.
An OpRegion declared with an offset of 2 triggers an FFA_MSG_SEND_DIRECT_REQ2
call instead of using legacy SMC/HVC or standard DIRECT_REQ variants.
This mechanism allows the platform's ACPI firmware to interact directly
with secure partitions by evaluating a service UUID.

Implementation
--------------
- Upgrades the arm64 low-level FFH handler beyond generic SMCCC calls to
  natively support the FF-A protocol. It negotiates FF-A v1.2, identifies
  sender endpoints via FFA_ID_GET, translates ACPI ToUUID properties to
  register formats, handles interrupted/yielded calls via FFA_RUN, and
  returns standard FFH status codes to AML.
- Leverages register-based endpoint discovery (FFA_PARTITION_INFO_GET_REGS)
  to resolve unique receivers from service UUIDs. This approach completely
  avoids RX/TX memory buffer ownership complexities, keeping the low-level
  ACPI FFH subsystem cleanly decoupled from the main Arm FF-A transport
  driver.

Sudeep Holla (2):
  firmware: arm_ffa: Share FF-A register field definitions
  ACPI: FFH: Support FF-A direct request 2 calls

 drivers/acpi/arm64/ffh.c          | 227 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_ffa/driver.c |  48 +++----
 include/linux/arm_ffa.h           |  19 +++
 3 files changed, 263 insertions(+), 31 deletions(-)

-- 
2.43.0

