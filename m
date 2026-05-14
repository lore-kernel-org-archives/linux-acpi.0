Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95F402BA0;
	Thu, 14 May 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771398; cv=none; b=LB5UfJGNJ/iO34L6dj060BUGXKXBgj52W8XoJyWdZIY3kqjbCc7UVNgeiBDTYj5fQcWjGqeLK9pMBrN2AssSwWKi1w5lab97xbjFQMh93e/odfEGXwt4OpDShnDc5Ukw0SOXaU5HXLoRve9COFvB7mcYNPqVu9nH0gvV0cqcKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771398; c=relaxed/simple;
	bh=t5gE4bxe3l8Rm89s70bV5esQES6c2DxTzt/nvkCifQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k326F2Rnsv3hMtwoA+iUjcxid0kIIH422aenpjG3ldJFT2uOqz/lM9Z1l4Kpj0Kx5SSi+40KSrz4ON8bJp8YF6Ee4tQFeJ80kjwPklfrjaMNOgcWxAlV34UtZcBqRzgtkXhtKDTMH8xSwhhlgYTHGfb74FMevXRfZgT+XmfIer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LydMEQYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LydMEQYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5142C2BCB8;
	Thu, 14 May 2026 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771397;
	bh=t5gE4bxe3l8Rm89s70bV5esQES6c2DxTzt/nvkCifQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LydMEQYykl+lrouBNxHsfLVGYzROXndlLpIbgH6j0m2tH/PvpdX+T4PKnkEePAGXJ
	 c+SWlcf0tRdp9R4ycU6c1fGIsHuiu7L7vSo7UNjlp26c1Eqn3QWjBn08/z15+pWrJ4
	 r448PK7bN9ERWC0wmgvourvyLhsRgsx3zD0IE4JMq9Cn5EKUBZAILS1Q3XJ4fS4GpS
	 oPHJMDP6uFtU327aMaa4Q65Vcy6orGWiUDS68E06VbEVcnWqge4Wpd/VAplO8sozhp
	 uTWmohZ/cNTPb3/0tnhxIs5R6EnvZM444E2D4zoVmOs7ECPV9AkfLmAJI/Q7j8EaGu
	 n850763jlqEBQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wNXhD-00000002Oqg-0nJO;
	Thu, 14 May 2026 15:09:55 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 01/17] ACPI: GTDT: Account for GTDTv3 size when walking the platform timer descriptors
Date: Thu, 14 May 2026 16:09:29 +0100
Message-ID: <20260514150945.3917510-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514150945.3917510-1-maz@kernel.org>
References: <20260514150945.3917510-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
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
the base table.

Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index ffc867bac2d60..b9d9b8edf2df7 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -32,6 +32,12 @@ struct acpi_gtdt_descriptor {
 	struct acpi_table_gtdt *gtdt;
 	void *gtdt_end;
 	void *platform_timer;
+	bool v3;
+};
+
+struct gtdt_v3 {
+	struct acpi_table_gtdt	gtdt_v2;
+	struct acpi_gtdt_el2	el2_vtimer;
 };
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
@@ -39,8 +45,14 @@ static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 static __init bool platform_timer_valid(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
+	void *platform_timer_begin;
+
+	if (acpi_gtdt_desc.v3)
+		platform_timer_begin = container_of(acpi_gtdt_desc.gtdt, struct gtdt_v3, gtdt_v2) + 1;
+	else
+		platform_timer_begin = acpi_gtdt_desc.gtdt + 1;
 
-	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
+	return (platform_timer >= platform_timer_begin &&
 		platform_timer < acpi_gtdt_desc.gtdt_end &&
 		gh->length != 0 &&
 		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
@@ -169,6 +181,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 	acpi_gtdt_desc.gtdt = gtdt;
 	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
 	acpi_gtdt_desc.platform_timer = NULL;
+	acpi_gtdt_desc.v3 = gtdt->header.revision >= 3 && gtdt->header.length >= sizeof(struct gtdt_v3);
 	if (platform_timer_count)
 		*platform_timer_count = 0;
 
-- 
2.47.3

