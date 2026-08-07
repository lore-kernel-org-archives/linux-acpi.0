Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B1368D5E;
	Fri,  7 Aug 2026 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143561; cv=none; b=BQ+Z9SuiRopbH0GXJXPLLx4uhKCP2PBaB+J8qiX4ZYLY4YQpp3ePKlNfIzgSfU3PqR+nRvUBpu5mpMwiSZFqTTOD+fO3hn8UNxKUFK9JFc+VMhiwIfp2MGjHX17/kv0SEIqfqBhUGkbBcJ4YJNpKyZjjOEQERGxCzvWP0rmXGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143561; c=relaxed/simple;
	bh=3ozXfcX1bg7kU4ZrmBvykS6h0SYRnbBaarB8r7umXBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mstRrjrLb19U6NKqQ9wp19BTXN4E+0K1NDGxVFE0jZjtLOixs+wtX/V3p32I3o7UR5/MHV0k0/OikgfCFjzav6ZE6FLva1j9u53OeuMdZLyWYRKmbDbotIdZ8xdDBzWjx3U4sWIOQ8+pdnQo4WugXfbsM/+eSB0M5Ee51y6NWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPzpUmgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPzpUmgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2D81F000E9;
	Fri,  7 Aug 2026 22:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143560;
	bh=YlLDYMvlrjDq4x7wME6iiLL3lLKOG8GUhUotAJ8Ukxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jPzpUmgjMNShpUhesX+Evfn4FUbm00ImqUAacj/SX9WZIR+zKrh0fbDLx4KGq2ZiV
	 DgnAWf1uqLmEKrpbv3IrUTkYeNptNq0kw0KQ7VLvveofW8zwb0sKbX6wM/sHri+uQ6
	 JW239kThVGiVCrbVCsEzxkxMWD8jImLv12UM2Z2VkUFPvgyXE1z4vnq4CvBWnKGRja
	 ShDNElG5I3UisQzQfW6smwPSg2XZoC4GM/D+gwCmP6w1TrpANspP1UK3DLJaseVmoP
	 U4GogZo34mVZN3UGBkhO1cAaPoZGJainNeADNE0mrgz7pkYFR/Hfcj3AQ2epah5I3Y
	 5jVPoXhaxPPag==
From: Danilo Krummrich <dakr@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	brgl@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ACPI: arm64: use platform_device_set_fwnode()
Date: Sat,  8 Aug 2026 00:59:15 +0200
Message-ID: <20260807225915.122789-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
References: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 16:07:15 +0200, Bartosz Golaszewski wrote:
> [PATCH 0/2] ACPI: arm64: use platform_device_set_fwnode()

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/2] ACPI/APMT: use platform_device_set_fwnode()
      commit: 5ab289f5eabc
[2/2] ACPI/IORT: use platform_device_set_fwnode()
      commit: 67b1e7245bd6

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
