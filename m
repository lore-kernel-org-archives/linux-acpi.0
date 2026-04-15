Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B23093A6;
	Wed, 15 Apr 2026 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218213; cv=none; b=mB7JEYMvWVDikJXR41+DFQxz5Prz/JDBUZWuFv5GsD5m0spqfUWVroqdHWrMNocsJmJeD1MdOKFP84E16WeAteYYFNH0PscuMdNilbXnsV+DzFAJxNnOLu4cZi0oIXuf4TcpOHqgdRL4LleUvIhw8WaAGHaXw0EZrh5qyocTo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218213; c=relaxed/simple;
	bh=OH+E1Lq9K6nERDXX094GRUFNVA/21b6qouU/nKLS0D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIfDYua4f5+qRZmdcWkrGTIKclViQWtOHChoCWKXUoeTiSKFusmU/QMcBQ0WJys3Gg44tPq3u1o3xfDAxkrT5mbP18rpVCPIDj5Bw5jxaD9iMI2W7vnMpga79vw1cZqEMYjK6vs+092knnsvS+k070RCBAxHI5aQ7NbS7xV/Rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8DUR98k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8DUR98k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099CC2BCB6;
	Wed, 15 Apr 2026 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218212;
	bh=OH+E1Lq9K6nERDXX094GRUFNVA/21b6qouU/nKLS0D0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H8DUR98kYpt3WarxzAOT92vqW3+CYh7DUM/Q/UPulhWfbdhzkkq3vdtqrqe25wdSx
	 Zj8FhFYAu8fPTb0HtWJKAJTlmiY4vhpXiUgeV8prXpQJcXizqco8e1dOEn5hSHpXfu
	 aPYo5pz/cAZQuow18VjKwKxbf/rdLLvA4jmobglo6V6c53hfFgW16zmc4v7+aoNrM/
	 kbwAKxTbCe8nF0wKDutXeHrpdycKS9IWv25vuPQ7DYW9P/HcF0j3RIinZerUXZ/OYa
	 X4rW1fqE5KJqllFNofFMWkXdiGA5tv13WcVJYE+LIQqEKHywNOxwglr2F+f7Q7Ngws
	 W55cJm6rc/P1w==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:53:55 -0700
Subject: [PATCH RFC v3 01/11] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-1-b3b2e7e9847a@kernel.org>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
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
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=fustini@kernel.org;
 h=from:subject:message-id; bh=OH+E1Lq9K6nERDXX094GRUFNVA/21b6qouU/nKLS0D0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5AUvrq0da5gh5fy1/YjExqlm82UF1+LuiOhzKp+P
 i3gcF1oRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAiE/4zMnxN2rOB12PH3eOr
 H61OSg5Y6B5zJux68InlmTscujpZOtYy/K/uV3m//GZH4GKN9i51r8Brduu+LHaO29h9uqf21KP
 TjzkA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
extension v1.0.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index c6ec9290fe07..1f3853a68760 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -232,6 +232,12 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: ssqosid
+          description: |
+            The Ssqosid extension for Quality of Service ID is ratified
+            as v1.0 in commit 5059e0ca641c ("Merge pull request #7 from
+            ved-rivos/Ratified") of riscv-ssqosid.
+
         - const: ssstateen
           description: |
             The standard Ssstateen extension for supervisor-mode view of the

-- 
2.43.0

