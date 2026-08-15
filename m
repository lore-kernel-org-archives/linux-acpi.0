Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A730D3EF;
	Sat, 15 Aug 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801131; cv=none; b=H/ULIx9y9OZpF0eGaeKdWyZcYOMLS9znEUt4LLCyncMloW8XLueX6V27BjnpHr5Gffv0OAX6Mn2xKDJavOc9hDyFOjvubQf7nWsO+G0Hcx05GrGDskUSuVt/CtmLECk3YXuZ3TP8ZyO/wwoniPyhHAYYMZf+hOubTv+dJyy0F3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801131; c=relaxed/simple;
	bh=N+EX6UKxzB91uj5xUaxkFJRP5idnMID/y7ALRRe8iWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Txej6Om1bHPc1kvvPYy2HUYd/J4Y0avU5bJXk+0js+x4xshf1aK/9fhMpH1tZyc5ujc/ox8s/KjfcP/3adyDeS6OC4LafCGK7f6jMnQCJXzqP4emaRkjEWbNX4APRAApq5NLCRlFyLVGOJkwmoPQjKe9XGwkC0nbwDla+m5S7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAC3JUDea4Bq+CvRBQ--.16851S2;
	Sat, 15 Aug 2026 21:38:38 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rafael@kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] efi/cper: bound processor record walks
Date: Sat, 15 Aug 2026 21:38:37 +0800
Message-ID: <20260815133837.42466-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3JUDea4Bq+CvRBQ--.16851S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4kWFy8AFW8Wr13ury8Xwb_yoW8Xr47pF
	sxKw1Yvw4DGr13A3sxCa13ZFy5X3yrAFZrGr9Fkw1DZ3Z5ZF1Utr1DKw1Y93y7Cr4rKw1S
	qr47X3W5CFy0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ARM and IA32/X64 processor CPER sections use different record layouts,
so each patch now gives one layout a self-contained length proof.

The ARM parser already receives the section length, but narrows its
remaining-byte calculation to int and reads a context record's size before
proving that its fixed header remains. The IA32/X64 printer receives no
section length at all, so neither its fixed error-info records nor its
variable context records are bounded by the section.

Patch 1 fixes the ARM walk.  Patch 2 passes the IA32/X64 section length
to its printer and consumes every fixed and variable record from an
explicit remaining-byte count.

Changes since v1:
https://lore.kernel.org/all/20260706093158.80364-1-pengpeng@iscas.ac.cn/
- split ARM and IA32/X64 handling as requested by Ard Biesheuvel
- explain each record layout and the first unchecked read
- make the aligned variable-size calculations overflow-safe

Pengpeng Hou (2):
  efi/cper: validate ARM context headers before reading their size
  efi/cper: bound IA32/X64 processor record walks

 drivers/firmware/efi/cper-arm.c | 53 ++++++++++++++++++++++++++-------
 drivers/firmware/efi/cper-x86.c | 51 +++++++++++++++++++++++++++++++++++++--
 drivers/firmware/efi/cper.c     |  3 ++-
 include/linux/cper.h            |  3 ++-
 4 files changed, 93 insertions(+), 15 deletions(-)

base-commit: dac3e89a2c90c2feeb471e1f22a2512ad424b792
-- 
2.50.1 (Apple Git-155)

