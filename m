Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5482727EB;
	Sun,  1 Mar 2026 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328273; cv=none; b=NqUz7PblLBU3v83tlES5B78oFcHbHob+6632tHZy2YpLBocBHwmaW+R3QUJlHLnev0woTcDoVpKKQm2P5bw4z5P3L0WCwz7nboTpqilG3VWz22JX2HaNvbm6F9t0ZylismocHROz9TLGELgx3FIzAeLZc93jt7aIWjO1YNNmwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328273; c=relaxed/simple;
	bh=33tf+UTlnYFWPRgWmuI27t1Jb1dMSbIMechrgXXTFBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCAkNfwqAb3leMf3ZSR3kH2mWBOz+dpHj1iq2iXpkzUPBIrdP/nlK2RidIRNk3uO43MF9UIs8+6MdwQzL1phGsOijg9nfpTUYloGtF1QInb7ZYqWvRdjjVzV2osr1eWLYb03K0Aj2THO/sz+NfE8zysyGyH2VOapk0wqIwvUwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+9aLqr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+9aLqr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6ECC19421;
	Sun,  1 Mar 2026 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328273;
	bh=33tf+UTlnYFWPRgWmuI27t1Jb1dMSbIMechrgXXTFBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=T+9aLqr2oZIrzOJtOzKIhhvvTFW50lqQxen5gB2jY8Hq5nue4mP7X+PhQDbpGvgBW
	 M9XsnkGzKLEv+ZFxsw/QF47qY1ZM3cTXoGENjLPJXGXAy3qA/wH6T2oMC/8SwYN1S7
	 e+KttncGrfqjTIN27YoeLCitkkRhfx8swvPvMXwqKHIT+aN25Tl1q6yhe2gNYG5JGb
	 20pZQQ554Csxc5SSTQlDeF1BdymyoJncVePMo/Luwy3gNI8gecTAItt/73gDb2Be62
	 uyOSreA/oiLAdJxZOQ7CERwS+GzkrcgA/NmfZWTUCSCCQgnV3ptHf5A4txD+/8xnF4
	 MEZddrlsLIl6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:31 -0500
Message-ID: <20260301012431.1681397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b584bfbd7ec417f257f651cc00a90c66e31dfbf1 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 14 Jan 2026 16:27:11 -0700
Subject: [PATCH] ACPI: APEI: GHES: Disable KASAN instrumentation when compile
 testing with clang < 18

After a recent innocuous change to drivers/acpi/apei/ghes.c, building
ARCH=arm64 allmodconfig with clang-17 or older (which has both
CONFIG_KASAN=y and CONFIG_WERROR=y) fails with:

  drivers/acpi/apei/ghes.c:902:13: error: stack frame size (2768) exceeds limit (2048) in 'ghes_do_proc' [-Werror,-Wframe-larger-than]
    902 | static void ghes_do_proc(struct ghes *ghes,
        |             ^

A KASAN pass that removes unneeded stack instrumentation, enabled by
default in clang-18 [1], drastically improves stack usage in this case.

To avoid the warning in the common allmodconfig case when it can break
the build, disable KASAN for ghes.o when compile testing with clang-17
and older. Disabling KASAN outright may hide legitimate runtime issues,
so live with the warning in that case; the user can either increase the
frame warning limit or disable -Werror, which they should probably do
when debugging with KASAN anyways.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2148
Link: https://github.com/llvm/llvm-project/commit/51fbab134560ece663517bf1e8c2a30300d08f1a [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260114-ghes-avoid-wflt-clang-older-than-18-v1-1-9c8248bfe4f4@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/apei/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 5db61dfb46915..1a0b85923cd42 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+# clang versions prior to 18 may blow out the stack with KASAN
+ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
+KASAN_SANITIZE_ghes.o := n
+endif
 obj-$(CONFIG_ACPI_APEI_PCIEAER)	+= ghes_helpers.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
-- 
2.51.0




