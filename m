Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795621401;
	b=rczFdyEEIgaxZEAJRGv8vNCQ7lrZlKWZkm+IOC4pDdGfSYrGAeRxfMXHYOefn40fwIjm
	 1wEdttD/3fK7ixgil6/HOfHe8q87WtAurmewtf6ELDrrobqoVDDgw0Nnw5Qr/Njt+4v7N
	 HXSn9awU2Va7oy0Xz1354gsZOW3f3DwRLRQaCIumervcpa38EUW/++2ixMMso/AHZhQSS
	 jJHxInM3Sb43ZHD6RENbOmikSTPoLTneb+a85QEU8zjv7CsL7aWdaSKRp91PG6oBxMI12
	 qB6YJB3H6odI1DLsV5xZKuhv8WN30eYXoc2oZ3W094NRECVa3pQMpZxbjT88SIiC9FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621401;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=a3C7rA+SpSijTk5V2gvwjrq4DBb/DUyqG5DB/qsgSBQ=;
	b=PL0nzhllRzq9WFwYCt5MQTah2yUvglSlSOUFD2gQ+bStdHqLYZfiitf2fNDiwn7GRtG0
	 o7sf6mZ9NRIq6iGeiUrRhZvUi9Q15O1fiuAVRfSXbHXwhb3gfOt9Vpu51QsjIoLFxKZlU
	 Iuw3xcHI75w9/AnGHsbeCXw8PayzUjdTlwGST+xsEhBkIeGaN7S7vIBiaB2t6LkPhb142
	 gWfMOVaP8FFzmqxLlrWpvq012VLIu44sKkiz95jHEip7w5M6AgSLvlecZB4K+8x2AK7PU
	 3iVEP1xEXdcznPLX3LkgnnCdMWbLKfCzAgiOVh1cV9UCjwf8nnn6dWMWlKDnl2Hcfyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLLzcOLP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E864606A32C;
	Wed, 25 Nov 2026 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLLzcOLP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795621400;
	b=m2FDJ3vYumbzcdX5eh1bZVKK+D3AdRBxW+MdiqJIjdZCTyyZ630KUNOztevVqzdYnMuQ
	 8qLdGHdlzXh08yWlldN9B30sAtw2oAQH7tDh/yxZhEtPhrfYcdpjDGBTEiSTRBRdUh+RM
	 OI5TVkuBOJZlmQWyZGiECphUoumezjnTeTQ5f/PGTLTXGPo28G7TpuK0oOMptPu4RUVTf
	 ClxqYglZ6qTZFL/fBvbnSxRnqF7Gpo2ZbZHvUuEeMEUDxjn3uLjIbmrgiu4WuQvCX4sKY
	 TA7Hi9VdLcwRdHDLdOli6GI35Yk0suaBk0ZXk2kHzwr0q6UrcEcN1zUXhuC6Eq6FRtQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795621400;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=a3C7rA+SpSijTk5V2gvwjrq4DBb/DUyqG5DB/qsgSBQ=;
	b=e5vEX4VRxX9FRcalN44uvXMBGVsxyZIvLczAXAAHNQGPBSep2QLm1mb3cyhYil/75Rjs
	 apdVgs1ui6trnRjYg7OkvRWcueWGnJG6jkYOHxiz3VFPRSWnDrSbIOxGumHkNiMbV/cEi
	 zA8tSZbTPjNvu8V0zFSf1Bvk7jh4WI8ydA5KQtP7YJDmuhfJ8ERtopMyFcSrYhTTq1kr7
	 /1f18RKlgzHfl7FGWxJIp0u/csQUZLzbDrWx12r8bc8Tq5oJId/wNlCAf7/V51CjxLk0P
	 tlFN7eOZFr1wlystF4jclEWGU85frXyPuDeNO0kyACsXeXbWi0flj51RhIc5VjoV0cg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5CB1E1F000F2;
	Wed, 25 Nov 2026 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621400;
	bh=a3C7rA+SpSijTk5V2gvwjrq4DBb/DUyqG5DB/qsgSBQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=DLLzcOLPtWDRi0PAlqJNAuFfFqqPfqSpvI1yMhYRcirMQpLt5niafoDnyCPu9T/hL
	 5MKfpL5eSPHaZVJfeJMRcdKnJkF7StH4iDujBYv0Nzpj3U6Z0Sg4yFv5DzoF5g2MY5
	 USm7gkWyO+coppuIaTb84f9fy0+B/sfWqHINNrtLW8CSVxv94mhmb7Qi7YEemHDjJB
	 D6NM6DrYTYzIQ3Gcltb3HEl0mzb+WAL6Lj9MmWefBDaGwDePhczGNlphdDSQeUz2g9
	 6LjksC0goFsrWSCGqOT/kooa+F+e+m4VMYex6ooB6K8LBluLQuwrYtB2nAIzMBwQ5c
	 tg+DLfRUHUO9A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D817F4CF21;
	Wed, 25 Nov 2026 15:43:11 +0000 (UTC)
From: shorezero via B4 Relay <devnull+shorezero.proton.me@kernel.org>
Date: Wed, 25 Nov 2026 10:43:08 -0500
Subject: [PATCH] gpiolib: acpi: Add ignore_wake quirk for Lenovo Legion Pro
 5 16ADR10
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
Message-Id: <20261125-legion-gpio-wake-v1-1-8d49be040868@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNT3ZzUdKAS3fSCzHzd8sTsVF0DixQzUwNDI+NUcwsloLaCotS0zAq
 wkdGxEH5xaVJWanIJyByl2loAIKrvNXQAAAA=
X-Change-ID: 20261125-legion-gpio-wake-08d650123e78
To: Mika Westerberg <westeri@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 shorezero <shorezero@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981;
 i=shorezero@proton.me; h=from:subject:message-id;
 bh=HKljuG8IXgLzJKgOm9anjabO6803T7j6Njn0CeH5tXA=;
 b=owGbwMvMwCU25VMaw6w3TVmMp9WSGLLZmfglm7/svsSxsoQp98T2YrYVxfflVxku9OVcuC1/8
 aV7x5g/d5SyMIhxMciKKbLoKtbMvVe5/EiHKXM4zBxWJpAhDFycAjCR6+8ZGY6Yf9Ty6D1cZ7Iu
 vKQg+vWxg9u5l00uzOOYLa9UHXbcoo/hf8GeU/GXHuxtNrp9f9MxneyHroxls5+oRLOGLD74arP
 yNX4A
X-Developer-Key: i=shorezero@proton.me; a=openpgp;
 fpr=2D217C9DDE79A7C48835035794F266009AEC826A
X-Endpoint-Received: by B4 Relay for shorezero@proton.me/default with
 auth_id=1637
X-Original-From: shorezero <shorezero@proton.me>
Reply-To: shorezero@proton.me
Content-Transfer-Encoding: 7bit

From: shorezero <shorezero@proton.me>

On the Lenovo Legion Pro 5 16ADR10 (83LT) the system resumes from S3
immediately after entering it, unless an external display is being
driven by the discrete NVIDIA GPU. A lid-close suspend therefore turns
into a suspend/resume loop (36 cycles in 11 minutes, about 10% battery).

With pm_debug_messages enabled the wake is attributed to pin 4 of the
AMD GPIO controller:

  PM: Triggering wakeup from IRQ 7
  GPIO 4 is active: 0x30047c00

Pin 4 is the only ACPI event interrupt the firmware declares
(\_SB.GPIO._AEI: GpioInt Edge, ActiveBoth, ExclusiveAndWake, debounce
0x1F4). Its _EVT handler only deals with the dGPU: in hybrid graphics
mode it runs the EC eject handshake (\_SB.GZFD.HTPE) and then does
Notify(\_SB.PCI0.GPP0.PEGP, 0x81). Lid events are delivered by the EC
through GPE 0x07, not through this pin.

Booting with gpiolib_acpi.ignore_wake=AMDI0030:00@4 makes suspend hold
(an RTC-timed suspend and a real lid-close suspend on battery with
nothing attached), and opening the lid still wakes the machine. Add a
DMI quirk to apply this automatically.

The investigation and this patch were prepared with an AI coding
assistant (Anthropic Claude: Opus 5.5 and Fable 5.2 models, run through
the Hermes agent). It collected and analysed the kernel logs,
disassembled the ACPI tables with iasl, proposed the test matrix, and
drafted the quirk entry and this changelog. I ran the hardware tests on
my machine and reviewed the change. Testing: the quirk entry was build-
tested with W=1 and passes checkpatch.pl --strict; the runtime behaviour
was verified with the equivalent gpiolib_acpi.ignore_wake= command line
parameter on 7.3.6, not with a kernel containing this patch.

Signed-off-by: shorezero <shorezero@proton.me>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 3f89a8760..07613e13a 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -465,6 +465,22 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "GTCH7503:00@10",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from the dGPU event pin (_AEI pin 4, handled
+		 * by _EVT -> Notify(\_SB.PCI0.GPP0.PEGP, 0x81)): the system
+		 * resumes from S3 immediately unless an external display is
+		 * driven by the dGPU. Lid wake uses the EC GPE and is unaffected.
+		 * Found in BIOS RLCN29WW, hybrid graphics mode.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83LT"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "AMDI0030:00@4",
+		},
+	},
 	{} /* Terminating entry */
 };
 

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261125-legion-gpio-wake-08d650123e78

Best regards,
--  
shorezero <shorezero@proton.me>


