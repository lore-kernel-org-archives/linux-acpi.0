Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C54345CDA;
	Thu, 16 Jul 2026 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245552; cv=none; b=ixpD35R8HHSMgvnQR01saqlTO622hibHf6Ngzoe3U4mSA6J6u0lM+hWi0V1sxoCaUpzNuJUExGfNIk3a5EPGfG5vgYDSFXN/decccMJYscMW8JwgI7N2z5MrJu1xLqVdfWQrQ6n7imjs13OrEvPSxvYxFjO2oHVUmke7IvjrOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245552; c=relaxed/simple;
	bh=7dAcpxOSrUAVGwGuGp02j+DtdiuxGy02JSJTb1pdrCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgRzMaWXuYjBL5TkP21FQhHFZieSDgUH3YWn+6XWhqMuWB+wMlHImEhTwgQs/EFkWh3grxfK4R7Zi2eFMbpT+lsXgmGh1xdbCMOuANLV9jBxhFdku7tkHXMs8K40A0gX6p1lhFxHkt+wdZz3VyCFjteDkHhUvQgcypWLsEpDbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=IVdbOjzO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IVdbOjzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784245548; x=1784850348; i=w_armin@gmx.de;
	bh=1mJEEvm4FbiJHeJ6b+OnPJ/M4l9XDDZkezBn7mj51to=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IVdbOjzOiMkuy6ohieq9cfzBfoTd3qjOjkJiVmY2y0oRlVrrSllK8shN7tasqwxO
	 5Phm4mRLmz6PLchBMlZwbnJql+9dcATw+B8uOdmXgS2f+WC8xGei69c7LWsKGNiZe
	 CwoSgcgPKfdcVNZ+T/Cb3qLmjFrVcRtATYKtwf7EDHdMw8MtfxZdSAeDPh5dCoxZl
	 zj31E05e3y8fGGGNId9v60OMiSQUzPUqRhr66hxyGvW8eseFBFjkvI8sDFTzm45ej
	 NJlGr52a5TiI5nezbS6EP9j0+xwlHc3FOvaqjK39Z7tG/46tS9UiGNR7P5vqkfunt
	 4pts+tTO7+rf/FfQbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1x5j2x05zb-0153sa; Fri, 17
 Jul 2026 01:45:48 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] platform/wmi: Remove dependency on CONFIG_X86
Date: Fri, 17 Jul 2026 01:45:36 +0200
Message-Id: <20260716234538.1303811-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260716234538.1303811-1-W_Armin@gmx.de>
References: <20260716234538.1303811-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKz4vvcXZRETbUo3vJfvsQVfsRKLVrkD2ForUyt0tPvMENb4ai4
 lock3NXJlrAGfzBmBKagdpZaEtEl5bT/MuhLf9HJ6lcyZFCFWeYaqpceQPhdNZqU1EQfGd5
 SPdcbVEUueMdtnmvT8C4qMUxB88yBiMktLny/Lel8d04bmKEeQrP02bgh+W+4uNBwB7OSc+
 FeBFOQqc8d7oPgX/d0jzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:acGHytyt/+A=;56cL2SN23qW6fDqPdui+0V6HLPO
 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
 =

The aarch64-laptops project found out that some Windows-on-Arm
notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
exactly like on x86. Remove the dependency on CONFIG_X86 to
make it possible to build the ACPI-WMI driver on arm64.

Link: https://lists.linaro.org/archives/list/aarch64-laptops@lists.linaro.=
org/thread/U2IZENSIOOHZHGXVN7GM5HX5O3FD5KCF/
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/wmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/wmi/Kconfig b/drivers/platform/wmi/Kconfig
index d62f51ff3b7f..36934b5f0194 100644
=2D-- a/drivers/platform/wmi/Kconfig
+++ b/drivers/platform/wmi/Kconfig
@@ -5,7 +5,7 @@
=20
 menuconfig ACPI_WMI
 	tristate "ACPI-WMI support"
-	depends on ACPI && X86
+	depends on ACPI
 	select NLS
 	help
 	  This option enables support for the ACPI-WMI driver core.
=2D-=20
2.39.5

