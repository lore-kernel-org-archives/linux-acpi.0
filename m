Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AA348C5C;
	Sun,  6 Sep 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710071; cv=none; b=NyDqqEYNTqWb6Y38B3ycArXKB4P5nM+SYzUw3yOVFDqtnwH1HJkglFARvOh2vPwQgnhjs+NUwCMsEh4VSFccVeJZr+Tege4C3PIGXyQa2KT2XSByoElQavUzNI8RIKcm3PnyB1Vk7UqkqGxhnOv/AXEZsM+AfqtrCBfBLpfiK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710071; c=relaxed/simple;
	bh=DJv4iSd+HkOU90P/LJMkxFHBuGFxr8xbKPXa+/IBD84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LL/2NuAOKLHENW0tWbMDsFDY17715cnO7grbXZunQ5vIQL+V/waWkF06FjXQQDvQfM/rskT6kzw5rT3ioiFulIBXndB5dTrOTDeUoocXTRXHVc207s5Lt4L+AUDdKNf5NTlumZnsRqmNXCxNlH6A++Q7qPTlP73vu8KvPzXDP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRCBjm0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRCBjm0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922BE1F00A3A;
	Sun,  6 Sep 2026 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710070;
	bh=DJv4iSd+HkOU90P/LJMkxFHBuGFxr8xbKPXa+/IBD84=;
	h=From:To:Cc:Subject:Date;
	b=oRCBjm0frp8JwQwcA7jZTLHoY9+PMOEb7m27ku5yVIEBPgW5pRUFUIU0vctysk7kI
	 ZFBsg/I0EyGbmtArVbzy+jty8I7m6qFf+X+ozFiU8ZaAhp3ZDjLT5DA+Pd8D5MEHzc
	 K8TUr1lnFsbOFTcc8ZRK3G6HDARJJx9sCm64BSSsE9qnVkUiSm1njRvo5Oej10yvoh
	 ryVdC6QVLCg2PuGKiZMLv8ttvu+vYCa/4kfmqEWN1kKsf+Hp4G+JRBLScK5XM+nDIk
	 IXiKs08A22YGOdmwXKqoJSPvC/UGkjevsSww0dcTMyxp5ScR15z6lcs7hXKRm82BJx
	 PKZjx6sMbDOTA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v4 1/2] ACPI: glue: Reduce debug noise from acpi_device_notify()
Date: Sun, 06 Sep 2026 17:50:09 +0200
Message-ID: <12989369.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

This is an update of

https://lore.kernel.org/linux-acpi/6048536.DvuYhMxLoT@rafael.j.wysocki/

that makes fewer changes in the first patch and add a follow-up one.

The second patch takes care of the message printed by acpi_device_notify()
in the success case.

Please see the patch changelogs for more details.

Thanks!



