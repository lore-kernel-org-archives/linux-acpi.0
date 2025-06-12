Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C446299A83
	for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748432; cv=none; b=aJiZww2jfxqVRLwzeaLt4kAtOygALBxAfFEygUn2Q8e8rkHYx/omizN1BDMrvKocZ9AcGgeVtlnz/WHyJAbQefdL/Ebd6RsPoqzf0uwALucDkcNwSQq3mt+GhoLmvEBtwKauJFkjDpxmlJl79dKFqMZAi5WAX+pmFyeQNpAjFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748432; c=relaxed/simple;
	bh=MDdJmT3aJARqZCByjj1RNzrwhBQ0TiY4BOHGera+ORE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uv/00yKti56ZllhcGAV/kKFvsfiCwP1hgiisqw6Kzpf0QaOH/LYpyjAypKS5r5Tz5xS067oUKtRiXxI4ipA8YJf6Him3aJmJLjhOjuGkMNP6dWbG8ZWnJmOcc1i1XZr5Sq3M5//d37fU2SAsf7qTo4zIBmUxw7bxgTW0FDD8Zig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67CC3153B;
	Thu, 12 Jun 2025 10:13:28 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3CD3F59E;
	Thu, 12 Jun 2025 10:13:47 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	sudeep.holla@arm.com,
	jeremy.linton@arm.com,
	James Morse <james.morse@arm.com>
Subject: [PATCH 0/4] ACPI / PPTT: Add helpers to fill cpumask from PPTT
Date: Thu, 12 Jun 2025 17:13:32 +0000
Message-Id: <20250612171336.4858-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a few helper functions that are needed by the MPAM
driver. The MPAM ACPI tables identifies the caches that MPAM can control
by cache-id. The properties of the cache, such as the CPUs it is
associated with are then found in the PPTT.

Cacheinfo has most of this information, but only once a CPU has come
online. Cacheinfo has to be this way because while the cache properties
are fixed on arm64, they are not fixed for other architectures. (I think
its PowerPC where this stuff can change for offline CPUs)
This is unfortunate as it means MPAM can't be used predictably
on platforms where CPUs are brought online late by user-space.
Adding these PPTT helpers solves this.

This series is based on v6.16-rc1, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ mpam/pptt/v1

The MPAM driver that makes use of these can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.16-rc1

What is MPAM? Set your time-machine to 2020:
https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/


If you prefer, I can glom these onto the beginning of the MPAM driver
series - but in its worst case, that is an ~80 patch series. (and who
wants that!)


Bugs welcome,
Thanks,

James

James Morse (4):
  ACPI / PPTT: Add a helper to fill a cpumask from a processor container
  ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear
    levels
  ACPI / PPTT: Find cache level by cache-id
  ACPI / PPTT: Add a helper to fill a cpumask from a cache_id

 drivers/acpi/pptt.c  | 238 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h |  17 ++++
 2 files changed, 254 insertions(+), 1 deletion(-)

-- 
2.39.5

