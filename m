Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54737267E;
	Thu, 16 Apr 2026 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324994; cv=none; b=clkQfutwZ/Qih7ciZ/ue188d1taso4cCnYwLSpaOzgQq0TElnUqDXi8isjSPUiv9Z/8u+tuGrMrVQFRzUyxykHuE5LWM296KhaDobQ9Pu1/SXHDv8FRMz5yJ97fDoKryrzaYc5L5ai0jc0Tg+HAWLesXzePxDu5N/AXo3brP6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324994; c=relaxed/simple;
	bh=Nc2UQueJJpx5cEnw6QVS+cko2jCSmKFZTBhfxDS9FDE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i5rK0NKcyfqpsq9NbS7rr6mgGDZvlGDCudYfGp79lvFbALXHRYxM3akMT4+Yu6etfFy5UlnOqzHBWDlH+GZhglK/BCJ06o1OvxDW6VbSiBKoeD20Ez5t7U85qA2ukI9Yl7nKDW9jLd5XK6K/Y+NyfiJ4x9xlfiGrkpl/I1CRzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CzN6tHw0; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CzN6tHw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1776324991; x=1807860991;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Orn2LLlhCQ0KgjJvKbkCqKUkE5z35R+KTPfG1kMwGRY=;
  b=CzN6tHw0coFI+kaknEPJ4VrLeAI3W2ms9zU+muwMV0E0zuu5Po1B2HCC
   SsC9ao+XP9A6oVK/px+EBu3KH0vFc5jFYmjeyNz8k+rqp3EQwSblhBQxi
   3691KP8Ygw6GRrzDApgTZX56nR1LIFwoTD/6aJYrWhyq+vbVkjaM4OgOq
   +yJ/CTnHNnsHNvN/MqkPVemQseqNkTB3O4X1LYBVj0dQsy6QhvL36v60A
   r8zJkjzxI7ykC56ZJw2E5dKL73SNofV6P1M/YxV/jwkA87NbZg2AByGZA
   Y7ceiTR4TCvJwnb1i25jtcH8xzvme0Ynl9qSp38D/zcSuyI4NTsMSadvI
   A==;
X-CSE-ConnectionGUID: LEvRhGBPQYKrPXIbfssu1w==
X-CSE-MsgGUID: /rTGS3MDSBi5PUjf//sPbA==
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 16:26:21 +0900
X-CSE-ConnectionGUID: RuTO5Z8yRlKM0lZk2jlxEQ==
X-CSE-MsgGUID: lcFHQUBpTqCWChMP43wQAw==
X-IronPort-AV: E=Sophos;i="6.23,181,1770562800"; 
   d="scan'208";a="61013880"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 16 Apr 2026 16:26:20 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH] Enable sysfs module symlink for more built-in drivers
Date: Thu, 16 Apr 2026 16:26:15 +0900
Message-Id: <20260416-acpi_mod_name-v1-0-1a4d96fd86c9@sony.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABeP4GkC/yXM0QpAMBSA4VfRubZimPIqkmY7OMpoQ2rt3Q2X3
 8X/e3BoCR00iQeLFznaTESeJqBmaSZkpKOBZ1xkZS6YVDv166Z7I1dkoygrWQssinqA2OwWR7q
 /X9v9duewoDreCYTwAONSLcFxAAAA
X-Change-ID: 20260416-acpi_mod_name-f645a76e337b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, driver-core@lists.linux.dev, 
 Shashank Balaji <shashank.mahadasyam@sony.com>, 
 Rahul Bukte <rahul.bukte@sony.com>, Daniel Palmer <daniel.palmer@sony.com>, 
 Tim Bird <tim.bird@sony.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=Nc2UQueJJpx5cEnw6QVS+cko2jCSmKFZTBhfxDS9FDE=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhswH/dJL2D0a97jHreFLi2AxuqfrfuKb4/OQIKV/K/2/s
 UVujd/TUcrCIMbFICumyFKqVP1r74qgJT1nXivCzGFlAhnCwMUpABMJO83IsKQm+c3W2/MvOtXt
 XZ/smqqsHBfNcmgf37zr11xZrrtWPGD4ZyPDzfJSRTil/EDWh3XnYxKvhu882rK9ruvHustl4pW
 P+AA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

struct device_driver's mod_name is not set by a number of bus' driver registration
functions. Without that, built-in drivers don't have the module symlink in sysfs.
We want this to go from unbound driver name -> module name -> kernel config name.
This is useful on embedded platforms to minimize kernel config, reduce kernel size,
and reduce boot time.

In order to achieve this, mod_name has to be set to KBUILD_MODNAME, and this has
to be done for all buses which don't yet do this.

Here are some treewide stats after analysis by Claude:
- 110 registration functions across all bus types
- 20 of them set mod_name
- Remaining 90 do not set mod_name:
    1. 36 functions under pattern 1:
        They have a __register function + register macro. KBUILD_MODNAME needs to
        be passed and the function needs to take mod_name as input.
    2. 42 functions under pattern 2:
        These have no macro wrapper. They need a double-underscore rename + macro
        wrapper to make them similar to pattern 1.
    3. Remaining 12 do not have such a clean registration interface. More analysis
       is required.

We plan to start with pattern 1, since it's the easiest category of changes.
Within that, for now we're only sending the acpi patch. If we get the go-ahead
on that, we'll send the remaining ones.

Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Shashank Balaji (1):
      ACPI: bus: set mod_name in driver registration

 drivers/acpi/bus.c      | 5 ++++-
 include/acpi/acpi_bus.h | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 1d51b370a0f8f642f4fc84c795fbedac0fcdbbd2
change-id: 20260416-acpi_mod_name-f645a76e337b

Best regards,
--  
Shashank Balaji <shashank.mahadasyam@sony.com>

