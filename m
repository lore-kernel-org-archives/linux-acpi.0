Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AF37756A;
	Tue, 12 May 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599029; cv=none; b=ZjgbJK7KVbph2ja2dh5Kcncv7cddsJszkq9PvvKugMAj25vUdxqchCN4xOVvhgjzOnLCV33S/4Ayfawgdna08o/aiWXRaMHrR+DzH0RhCTa13ojLB3ac4IkXjSD9Q1UwxL57ows50xfMuwYeWikCdZ5BVqOdbkiVMAEprOJMH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599029; c=relaxed/simple;
	bh=vwfgL5zvwV2wGTNtZAe18eQy5moRZJzohFndJQsPqnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QoWJxjHd5tieDE/oYwLfdxisZscpBAFVpDj+JGTBCt8K5nayLmEatHchP9R35hfKuDFYsx7GtZ5D1tqpO0qS3iDjuZzJkMIxrzovDJHPeqXIuSkYDquVIrWjkBB4WghxiO8eMgzzUz3xDHWNEaVW3/T1oXZW0nPUr8k6jdv0s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGr3zWo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGr3zWo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C24C2BCFC;
	Tue, 12 May 2026 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599028;
	bh=vwfgL5zvwV2wGTNtZAe18eQy5moRZJzohFndJQsPqnI=;
	h=From:To:Cc:Subject:Date:From;
	b=LGr3zWo8KSrTl7rPu/F+bhSzKUS77fSEDKRjHf9Pi5Tl+MAkQ+BeCJAd2/jxzs33w
	 4ZTD3/z85CBGuHbxmb4EISahW3v9XPVMCqPFsffqIkvVjkXJuY7QUf2YvGUNEUKD55
	 cE3JsGwpeE7k6J/FLan1Wjjvc4pCwnhnDd/sKajbZ8om1FSbPh8UolO64hFoLPI7om
	 uEC1sy3vMPAbd55ovpXyxblaOC+go4f5p+AYJuG7SJj+RhtZf2rHR8XK25oZsF35KQ
	 FP5UZgwtmMqFKPCJrL55Q3cw2ak6zMG2C543e7UopuUNIMKUiD1nhtVQPO180Wucev
	 uLiieQLYJm+Ag==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or ACPI_HANDLE() against
 NULL
Date: Tue, 12 May 2026 17:10:35 +0200
Message-ID: <6007701.DvuYhMxLoT@rafael.j.wysocki>
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

This series replaces

https://lore.kernel.org/linux-acpi/4731840.LvFx2qVVIh@rafael.j.wysocki/

and as a whole it makes exactly the same code changes.

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
against NULL to 5 platform/x86 drivers where they are missing.

Thanks!



