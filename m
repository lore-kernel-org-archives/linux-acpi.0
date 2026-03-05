Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FE33A9C4;
	Thu,  5 Mar 2026 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742583; cv=none; b=YPXDNb5LMajp7OCxL2GHpz8KpcIr0r8aFDRqC+V6+qUgAx8M+QEUXGBUIa0j0LE6n1p240N5SdjzWAs93Kja4p0g2kBz/Ad7Ka8+caWX0bYzct8H2iCliIjWp7qVw+Nyp8rfKq3qiN7U9FeR1ME7RWAqJKo5BkAawBSEaRbnnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742583; c=relaxed/simple;
	bh=nQcYCvZsqZtHFoA3zy5Q1JglIrlIyozYK4Gh4bACLJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E90W3BMycqmcoqUOHyKJ0jPU7HS21AUkPAe+kvFOJR5m5IgYsHMePah7Hj4iRe4CSu2r15NXWEgHc5DM6Z6jiI9j9n5gvk2pR5MLEw/KMJsG5ywqzOK9kxTEp5ojyJ1zfk7nJjo7/FTWrV8CzhAKcOger2hG2F5D67/XWefzPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+hnQCNI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+hnQCNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF9BC19422;
	Thu,  5 Mar 2026 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742582;
	bh=nQcYCvZsqZtHFoA3zy5Q1JglIrlIyozYK4Gh4bACLJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=X+hnQCNIyOKRLyEFTRlxtxdCR79MI+wYcce/y49RI9xBcY6wwQQzqoyToFpiLs5ol
	 M4f7TPzBMjeBMRb3CBI0GzTw6WWb3rb2uFONVLxux8QkWO/Mk7cXy9Tcq/fRFV6aq2
	 Mx+mlIsnN5UVPMGuzxInnaRr1fFYqFDg1LOfFGIAuwc2cg5RzIRg2W+zVNKewP13Z9
	 6d/+y4gi5SrSN7cGtozQjmInBvu6b9Q8XZhdVrv9wHg+QIbbU65TxuB2gNTBvqynRD
	 +sGMeRQYrTUQ12rYwicHsCB5NRdpxND+A3GKmh8Xfq7f8vuUct8mum7zbvv3PNNX2N
	 oJkHcE2pZ4cvA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 0/9] ACPI: driver: Cleanups and fixes,
 mostly related to acpi_device_name/class()
Date: Thu, 05 Mar 2026 21:09:43 +0100
Message-ID: <4505861.ejJDZkT8p0@rafael.j.wysocki>
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

This series 

 * Cleans up a few wonky things in the core ACPI drivers (patches [1-4/9])
 * Updates several drivers to stop setting acpi_device_name(), which
   is not used anywhere later (patch [5/9])
 * Adjusts notification APIs to be more consistent and in preparation for
   the next change (patch [6-7/9])
 * Updates several drivers to stop setting acpi_device_class(), which is not
   used anywhere later, and one driver still using it (button) to clear it
   on remove (patch [8/9])
 * Consolidates the ACPI_AC_CLASS definitions (patch [9/9]).

Thanks!



