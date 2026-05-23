Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608434752A;
	Sat, 23 May 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544978; cv=none; b=D+6Tef3lEiHf3yKE2gQIRIClrBrYbfsfZDjy26rI3ydA22rWYYAw6JNFnz+UrNNhvi5t8rYewKlVQk1RHH2T58BrPhfqcCqnXfBlJGVA/Ob6C6xXrC962NXNqc2ObCVnA7mUuX/amPcYTzODluQpSBu6yolkE9fqif8AE32PMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544978; c=relaxed/simple;
	bh=a0fx5WGU9a5+wCg9KRZO6soijwjDNeO7wmRX0WNak08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn5SI8uR2WctHJi00NdKQVj7UT0iqhzdwXpS+zfbB6x8ma2Aorn4RBWiKxtpG+EEtMk5dm+bpAbqjJY5ssAwTpyHyOOV0BmARJeQ4irM95qiAJfDzyTBiW/20owy5X0HM/pmVdzzgPU/EQsIkz6LO/8nPUeyR3GvJGSzIdQhk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CahzoAU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CahzoAU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5CB1F00A3A;
	Sat, 23 May 2026 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544975;
	bh=fuOTrHOj9uIrl6Hh+9LOPPhruyGEFguBq2wvPmBPjYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CahzoAU0cYZa4d4XQ2gooWGHjt0pnJ9Ot4ClzJwVSfAmrOQ92bbrik3HeEkNTnvQM
	 mWnlFgmNe/RJDLhoM1itYFkXjBlZzqnS/QQkJ1qeuGHaeFTlZvpXA6RAitIv6BFuSA
	 lyfJgPUDyMamaYrHCO9aJB2/nyVNooulQARv6/ePYMDcCESEJD6yvzhK8prwkJ77wY
	 nr7kKCcdOPp+bWod+GrgK3XgBC2TwylLfVZjl74BtMvYZ2XCLBRB5uZBxSBA63giB+
	 iXN1tecIyQxxVIZG+kGoir7PPpsOzvj8YyGsK5wA30ynNReKiZdTaZaWG8+rZDPEYy
	 3l4c3wvqvf7ow==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wQmwH-00000005YFc-1pb9;
	Sat, 23 May 2026 14:02:53 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ge Gordon <gordon.ge@bst.ai>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	=?UTF-8?q?Yu-Chun=20Lin=20=5B=E6=9E=97=E7=A5=90=E5=90=9B=5D?= <eleanor.lin@realtek.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 01/17] ACPI: GTDT: Account for GTDTv3 size when walking the platform timer descriptors
Date: Sat, 23 May 2026 15:02:26 +0100
Message-ID: <20260523140242.586031-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260523140242.586031-1-maz@kernel.org>
References: <20260523140242.586031-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, 
 eleanor.lin@realtek.com, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Since ARMv8.1, the architecture has grown an EL2-private virtual
timer. This has been described in ACPI since ACPI v6.3 and revision
3 of the GTDT table.

An aditional structure was added in ACPICA, though in a rather
bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
add GTDT Revision 3 support").

Finally plug the table parsing in GTDT, and correct the parsing of
the platform timer subtables to account for the expanded size of
the base table. This also comes with some extra sanitisation of
the table, in the unlikely case someone got it wrong...

Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index ffc867bac2d60..950d5efdf85ea 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -34,14 +34,25 @@ struct acpi_gtdt_descriptor {
 	void *platform_timer;
 };
 
+struct gtdt_v3 {
+	struct acpi_table_gtdt	gtdt_v2;
+	struct acpi_gtdt_el2	el2_vtimer;
+};
+
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
 static __init bool platform_timer_valid(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
+	void *platform_timer_begin;
 
-	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
-		platform_timer < acpi_gtdt_desc.gtdt_end &&
+	if (acpi_gtdt_desc.gtdt->header.revision >= 3)
+		platform_timer_begin = container_of(acpi_gtdt_desc.gtdt, struct gtdt_v3, gtdt_v2) + 1;
+	else
+		platform_timer_begin = acpi_gtdt_desc.gtdt + 1;
+
+	return (platform_timer >= platform_timer_begin &&
+		platform_timer + sizeof(*gh) <= acpi_gtdt_desc.gtdt_end &&
 		gh->length != 0 &&
 		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
 }
@@ -166,6 +177,13 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 	u32 cnt = 0;
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
+
+	if ((gtdt->header.revision >= 3 && gtdt->header.length < sizeof(struct gtdt_v3)) ||
+	    (gtdt->header.revision == 2 && gtdt->header.length < sizeof(*gtdt))) {
+		pr_err(FW_BUG "GTDT with invalid size %d\n", gtdt->header.length);
+		return -EINVAL;
+	}
+
 	acpi_gtdt_desc.gtdt = gtdt;
 	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
 	acpi_gtdt_desc.platform_timer = NULL;
-- 
2.47.3

