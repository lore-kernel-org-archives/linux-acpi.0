Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2F38C426;
	Mon, 20 Jul 2026 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517824; cv=none; b=OQar4eqyvxG1XXXhm7qiIW5UHcxUKmvcAhJgsn56SGJz4yKEfhx/bPFYO+KtKKgdtEqvTp4kzOqE4EWjrvoG23pI4NJHjAgJ6R95UG6q3I3RVlEXoypSTZW6g7qr+ZpLKqR/b+Yyt8ZZjB75PQClwGLnrrAZHNdp9LfClqqvvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517824; c=relaxed/simple;
	bh=YZW/JYdMwm8w6dPoHN7pSAVh4k1gOtwqibHrdJ/586k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlcK/+n6h5pVcbM36zHozgnce7/FGvfjFoLtgPHmwYPmylvgz+82WtbKvw/ZyAM3MDeCF8aTqEHo/Jom0oc+b7kubmZvSNLVKpIFkkaR6n03ftXkxucpHmMtTl7Qc7RNYaxmfNF7Ki9AqO1ZhJ2FFvf3g1e2GE228wZhro3QvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PpVZbhSW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PpVZbhSW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uuJl5O1m7jy6ATDWbZcYZjMDEJLLaLvfEK70WM4zYYE=; b=PpVZbhSWHHarE5UaHkQQ6kbVou
	MlYPJkoWzQ6BbMhEc07uvbqDN7GvGsdP87KH414tShNcOZuhmcOXpDlzb7CPsubW79hxvbBjNLFHO
	HU6Q9HbBa2ZuZtCAgGO0ZHu+89wgTzZ67Fy7QXYsdGKOgsMF2Uz5ADwF8XtqTFoqkBMrNRjdJEk0z
	KP/IunFjEHLKNEVAz2sTvrAcfhbhBbqpj7sGgEYtZcSfaV9/rt9kgmjv4F/U5WWHXheOozxKxS/BQ
	m07vF3qG02BESxPGrYMFQuuP383Ja8UIrhGanPxh35KBHny6RptVMYNtsreATyk/czM9bL/DJemsA
	WKpTNYtQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlebW-00000005kwY-06hA;
	Mon, 20 Jul 2026 03:23:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] ACPI: bus: Use correct struct member names
Date: Sun, 19 Jul 2026 20:23:40 -0700
Message-ID: <20260720032341.3087008-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720032341.3087008-1-rdunlap@infradead.org>
References: <20260720032341.3087008-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid kernel-doc warnings by using the correct struct member names:

Warning: ./include/acpi/acpi_bus.h:429 struct member 'crs_csi2_local' not described in 'acpi_device_software_node_port'
Warning: ./include/acpi/acpi_bus.h:429 Excess struct member 'crs_crs2_local' description in 'acpi_device_software_node_port'
Warning: ./include/acpi/acpi_bus.h:445 struct member 'nodeptrs' not described in 'acpi_device_software_nodes'
Warning: ./include/acpi/acpi_bus.h:445 Excess struct member 'nodeprts' description in 'acpi_device_software_nodes'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

 include/acpi/acpi_bus.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260717.orig/include/acpi/acpi_bus.h
+++ linux-next-20260717/include/acpi/acpi_bus.h
@@ -410,7 +410,7 @@ enum acpi_device_swnode_ep_props {
  * @lane_polarities: "lane-polarities" property values.
  * @link_frequencies: "link_frequencies" property values.
  * @port_nr: Port number.
- * @crs_crs2_local: _CRS CSI2 record present (i.e. this is a transmitter one).
+ * @crs_csi2_local: _CRS CSI2 record present (i.e. this is a transmitter one).
  * @port_props: Port properties.
  * @ep_props: Endpoint properties.
  * @remote_ep: Reference to the remote endpoint.
@@ -433,7 +433,7 @@ struct acpi_device_software_node_port {
  * struct acpi_device_software_nodes - Software nodes for an ACPI device
  * @dev_props: Device properties.
  * @nodes: Software nodes for root as well as ports and endpoints.
- * @nodeprts: Array of software node pointers, for (un)registering them.
+ * @nodeptrs: Array of software node pointers, for (un)registering them.
  * @ports: Information related to each port and endpoint within a port.
  * @num_ports: The number of ports.
  */
