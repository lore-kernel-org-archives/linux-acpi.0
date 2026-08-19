Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E62232395;
	Wed, 19 Aug 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170565; cv=none; b=ZRQLzmcTgzkE7eMJO637zsOH3BUhodr8MaHC/ucfTnIrxpjdPOfk6IKgB+9bpbNaKYhCvsDIDbnfqkIGSeZkJ85u4V+UWfNC5eMIAH8rTb7UR/JbgFeYX0y0XJiwSEO18kIk7O+4dUI4I2B/JixStStId/2Rwj2ldnx0FToB+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170565; c=relaxed/simple;
	bh=AzB0SDKcedei2OFPqblN08f3aKA5UdqXdVIU2+Aq3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgDVvn75supg0B4Za7PBO6+SAGBbFrmQMTVjGVPeQBMrEgJQ/PbxXvkRdOY7SmR0yh/O2stV8oU2yZIG+xrpGjVr/MoAdsL4SMP9pTzhgadolD8WxgcC873wJA6MaOiDx2TzLXqEAzNN5JpzjVqx0IyNjgS7s8Z1+QTpCSb9RTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VScCT/VQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VScCT/VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C85E1F000E9;
	Wed, 19 Aug 2026 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170562;
	bh=KRC9+ciSlIXVYYpxH+nbh2IVdOnLyUcrW5XbPtk/sr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VScCT/VQGaNQ+AJQoSs7OIxASM9W5pGp+IPgo+BCiYUohNXE3hZPc8dJQDDwZGPXF
	 zRXYK4x4mdnUvFdmQBIFR2DSuH6H0alSMvcgga0f9fH3ouNW+yodrGTdVttdaMvUZ8
	 oSwY2jHmN3GcuY6TpYCeKTxegLcU66NTLdT6SGjeB5Llgk2c3tu7x0BgTl503vy1Xr
	 nWgkUSM/QxwwH/W8mdbDjjtD1AQ/8dV1eyI/ALlJwj9v8CMVsF8WEc8OZBkuwOd0UR
	 m1PDghCy8+Tjs46tud3ofwRHItKXs2Xc2fKVLbpac3w6xjR8k+2+TA/5+6jnvuIti0
	 xiBRbjqI6Iu4w==
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
Subject: [PATCH v1 2/3] ACPI: Update MAINTAINERS entry for ACPICA
Date: Wed, 19 Aug 2026 22:13:13 +0200
Message-ID: <3356863.5fSG56mABF@rafael.j.wysocki>
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

Update the MAINTAINERS entry for ACPICA after recent changes in the
upstream ACPICA project.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -314,15 +314,15 @@ F:	drivers/firmware/efi/cper*
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Saket Dumbre <saket.dumbre@intel.com>
+M:	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
+M:	Pawel Chmielewski <pawel.chmielewski@intel.com>
 L:	linux-acpi@vger.kernel.org
 L:	acpica-devel@lists.linux.dev
 S:	Supported
 W:	https://acpica.org/
-W:	https://github.com/acpica/acpica/
+W:	https://github.com/open-acpica/acpica/
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
-B:	https://bugs.acpica.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	drivers/acpi/acpica/
 F:	include/acpi/



