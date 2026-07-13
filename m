Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906223E5EEA;
	Mon, 13 Jul 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937643; cv=none; b=H127ZcO/xtVhgiBuYmHskOcFqHEE9LstqkwZk1HLlLpldxBvQ4mlcExx5nF2UllB/97ce+JkFBooETxtHjPcegjWJDQT8I82yG/R05fJq1ZFos/aBO1+NK9VdtEWQaFFqoa4IvhrEs/8wD33lSPlPTB+0c+WkN+Y+hr+6Fck06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937643; c=relaxed/simple;
	bh=MGnbOfYmkJ6Rn5mwzIMCDHGvnNJ82HKjflE86fPGRvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxtxfVEJAimFiwmbAYi7DcwA7B3MFGzBtVFlaQ4pK7amRWL7d9sUEr2IGq3bS5YCtApJpuNDXmrlMwBMws6YPl/bZG6d0WGU3/hUKf4VvWzTTs40AVjPiw+j5skZyqZkJwJFpUZXcY2B62yFSvTRlepT5E5dvLpXgLdYm4RF67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxeetfulRqBwMDAA--.11893S3;
	Mon, 13 Jul 2026 18:13:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxvMZbulRqcd0LAA--.37576S2;
	Mon, 13 Jul 2026 18:13:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: maobibo@loongson.cn
Cc: acpica-devel@lists.linux.dev,
	chenhuacai@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn,
	loongarch@lists.linux.dev,
	rafael@kernel.org,
	saket.dumbre@intel.com
Subject: RE: [PATCH 0/8] ACPI: LoongArch: Add IOVT table support
Date: Mon, 13 Jul 2026 18:06:33 +0800
Message-Id: <20260713100633.2102708-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260617074829.2396638-1-maobibo@loongson.cn>
References: <20260617074829.2396638-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvMZbulRqcd0LAA--.37576S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

slightly ping.

>I/O Virtualization Table is ACPI table for LoongArch IOMMU devices, it
>is merged on ACPI Spec 6.6, and it can be located at
>  https://www.loongson.cn/uploads/images/2024110517404135188.LoongArch-IO-Virtualization-Table-Specification.pdf
>
>Here add IOVT table parsing on LoongArch system, it is for use about
>LoongArch IOMMU driver in future.

