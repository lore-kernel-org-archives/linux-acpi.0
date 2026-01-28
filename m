Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2464374720;
	Wed, 28 Jan 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632092; cv=none; b=gMzFys2yvVN39joFI6MXWpjCCCT1tcfQkj4/fVKAKckmot/sCJCsJq1kyy2iHj+ln+WmpLWGUAIm/t4M130q+V5PGYDUX8IoWIjMUkco+ObhzfKX1d4WbSbqlC+i6rbZoDG4H4rMZJ+S4ocOXa6G+wRkFvw4K3c1P8dtfgophsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632092; c=relaxed/simple;
	bh=4o0KFAigHCtXfQSjAvAOAbc0aP+19v9iIO4nX66XDCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTYLQHLB2sWhg5yl3yk1teieKWXKB87varSiZQn1H63Jo22Qn6doxKFwCMA/8wauuxyoX0ER0Re9z+eL3hhkCgs7iyHhk/BEXetyjQ1Fbmng2rui0WmX4ldhiSO5EjtHfg510M4ICuQ30YO3FMS4+5Rw7bfg0skEHJgBVV5pLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJq1dOMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJq1dOMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4242EC19421;
	Wed, 28 Jan 2026 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632091;
	bh=4o0KFAigHCtXfQSjAvAOAbc0aP+19v9iIO4nX66XDCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJq1dOMePTouoidO/P2tv+4dKpxFdEC2aSVyZi0wNFbc6ZsUxexPgDwcQi96Ht9E3
	 pxTjJFsUzUNZiAbloJoMLqK2b6OyYUFBESwWfzSZUdhu9rQa2ZS+hoKUY6Kmvtwkwm
	 wBVOuHKRAGZZthnQHbjcESTZIazXMrj7KBvoFCxBYAyn05MPA4pUnGno7CFafh3H/S
	 Y/EMMUO3C+beVB6aNfLRIo7XkNbmIZqgvmkyOl7IyU7uQP/I1c/32WrRl/aOyS3CK0
	 YN2gEB5ZkokGY20mtw0zFTfD7i91rj6M+Nq0muzJA6k/z4bsNtJMUIqXsWFflTX7tY
	 Rsmrpn5quQUdg==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:36 -0800
Subject: [PATCH RFC v2 15/17] RISC-V: QoS: add Cache ID and Prox Dom to
 CBQRI controllers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-15-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, Rob Herring <robh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=fustini@kernel.org;
 h=from:subject:message-id; bh=4o0KFAigHCtXfQSjAvAOAbc0aP+19v9iIO4nX66XDCM=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQYKivn8UZhwb8bOXbu6v8tnpR05HvQsufNYFt+j1
 afM6u6od5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmsqae4X94zqLaLyYnUleZ
 KwvYv8uQ8nPp4djz44G1stUU3YVf4m8w/C/18GCrmGqa9rfnLzOP2282w/m9/VW2p9ee41n83XB
 /Py8A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Expand cbqri_controller_info to contain:

 - Cache ID from the PPTT table's Cache Type Structure
 - Proximity Domain from SRAT table Memory Affifinty Controller

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 include/linux/riscv_qos.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
index 0c551ed85fe1..4812b6811327 100644
--- a/include/linux/riscv_qos.h
+++ b/include/linux/riscv_qos.h
@@ -27,7 +27,14 @@ struct cbqri_controller_info {
 		u32 cache_level;
 		u32 cache_size; /* in bytes */
 		struct cpumask cpu_mask;
+		// Unique Cache ID from the PPTT table's Cache Type Structure
+		u32 cache_id;
 	} cache;
+
+	struct mem_controller {
+		// Proximity Domain from SRAT table Memory Affifinty Controller
+		u32 prox_dom;
+	} mem;
 };
 
 extern struct list_head cbqri_controllers;

-- 
2.43.0

