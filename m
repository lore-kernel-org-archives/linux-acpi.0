Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3403D45C8;
	Thu, 21 May 2026 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372777; cv=none; b=OwYCmuP1ohM0+fi13N62zn8HEsv8Bl4njE7Y56E4/52Sp78EYdymOi//rAINfSKJAxH4jtB0DULIDm+ZKyjuXpLSyNHwQOdPs3oxWozXV1CKzooqPw1iEy9zL56UW9Z78UBmciiRkA2RRmgPIchpLjzwU8I18D7WjlQNl/SL6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372777; c=relaxed/simple;
	bh=Q8p5QQzXzd+Gl92bSImkVqXBhoG+2B15dQbamOJorow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbqfWlGNKZgr9wVAHHGVXIKfy9pvqqtFwSp2BBsrGt0jN+6l1rlWXA2Ge5Um5+Cb7dCI/9VhtF0+CcJEhtFAugWz8TvRpivO74iLBKHnFVKdqiYwWYwGyafs+fNRc+ua7zZMIgEbxw3o8DulSDUFUp8eJ8p16/bsEUi37GSK26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+XYTcIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+XYTcIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038F1F000E9;
	Thu, 21 May 2026 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372775;
	bh=Q8p5QQzXzd+Gl92bSImkVqXBhoG+2B15dQbamOJorow=;
	h=From:To:Cc:Subject:Date;
	b=P+XYTcILimr6vi1FGXS6RPcHHxX1Ep/mivy8lTsT1FJLA+8uUbJRuw1KjXuYuFLXY
	 eUCee9ZGNWHoqRnsfobMRXzJXjkDRb1hf7tX196sM2VQv8cG+eSqfV7LNZYrU4LccF
	 Yisvh6efXId+gFwqEqhBBM5tm7WzNR0EAQxX7nW7yl8P4RQW6SrXilRdClHb5EEATU
	 BdYWLQucXYvCu8kCqJIS+CGfSvyMzrHLYP+u2MQ87Borqqdf/NbC69bR7WEccGMZZO
	 J9wcfOapuXuIA4M91lMHxIRURJp/dpuQs4MGuBdDKw1+7T1bTnrsirlfiHa5a6LBRb
	 M7PNwbMGBgNcw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 00/17] ACPI: driver: Use devres-based resource management
Date: Thu, 21 May 2026 15:57:43 +0200
Message-ID: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series adds devm_acpi_install_notify_handler() for installing an
ACPI notify handler along with a devm action to remove it automatically
on driver removal and switches over a few core ACPI drivers using
acpi_dev_install_notify_handler() superseded by the above to using
devres-based resource management.

This allows some some hard to maintain and error prone driver code to
be shaved off.

Thanks!



