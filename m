Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA336C0B7;
	Wed, 18 Mar 2026 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836607; cv=none; b=c8G2uYFhhXyZJN+Bh5SQRdJvxMex8F2LTa9ZiQiqRvRwar/VES8yGvuxidnV8TVwXRYmK+kqTCoo6DH9Cwy+/lyv7KDdI1OGXGOc+nLZo1MSmFk8K38NkrfeBs7488WN/W9zqSGbC3bK72bHWfQIeZkU15SLxRbr6FjOKG9Npe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836607; c=relaxed/simple;
	bh=7jJWu/4HECELyPxQeSfNrU3tYlPhmHg7YwnSL1LakY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aeult/06vCEd8kOlXC7yWcbFQWEZC+oEfnFs2xJ6Ld/EGyPLBcDQOVZFg1UT8Gpuva3LkkzLME2C6ExWrHQG86TbUfirz4yVUHwezI5BMAdswcPJOovjRwO8nwU6XatF/oEJTeP4RGf5nQMciZSdE5HBBEgZE8I/F+aRS+kleoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTIYpzlu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTIYpzlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773836606; x=1805372606;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=7jJWu/4HECELyPxQeSfNrU3tYlPhmHg7YwnSL1LakY0=;
  b=RTIYpzluDRolHc9jb4ekbtoEHsTqt7jhII46KbEZTPiTIMqjKyv8UzWc
   CC6oZsir1ew2mIOJt5PDA5/uVEAFFNy46Qk47e4aytyVCQoYY65ciMTSM
   Y28huVkRojRFzEjKuFI1vxddt669A6fCLXj5CvODY3uQOaGGmU2FqwN19
   0c7Wi9yON6IU7Hai9zw9ahy4FnqYTR8rMiSRum18/9qmzvIUxQuzhKy4G
   1SVZD+siH1v9PgsJKWg8f3ofpdF2j3lA1RLtPv5MxfyF8E3e6d9PLdHS6
   KqPmaZ2/7ybc+Dww3dSpqrgtNIA4awPEXIAUYJ8HgauyELjvuzrrzCAsk
   w==;
X-CSE-ConnectionGUID: bBp78S3FTk+IgbQtDRIeUA==
X-CSE-MsgGUID: ohvV9NU8Qlm4r8I+lGAPTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85517961"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85517961"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:23:26 -0700
X-CSE-ConnectionGUID: BHGtDwnWRRqSXKArIk744g==
X-CSE-MsgGUID: tCXpIvCMTQuMOzy8IUZQAw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:23:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
In-Reply-To: <5085647.31r3eYUQgx@rafael.j.wysocki>
References: <5085647.31r3eYUQgx@rafael.j.wysocki>
Subject: Re: [PATCH v3 0/5] platform/x86: fujitsu: Bind drivers to platform
 devices instead of ACPI ones
Message-Id: <177383659905.7416.12056868465212089784.b4-ty@linux.intel.com>
Date: Wed, 18 Mar 2026 14:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 17 Mar 2026 20:38:06 +0100, Rafael J. Wysocki wrote:

> This is an update of
> 
> https://lore.kernel.org/linux-acpi/12863082.O9o76ZdvQC@rafael.j.wysocki/
> 
> that updates an error code path issue in patch [3/5].  That change also
> requires patch [5/5] to be modified, but the other patches are the same
> as in v2 (and v1).
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: fujitsu-tablet: Convert ACPI driver to a platform one
      commit: bd13b265d386afb15d9ee5feb4f2cb605a5770db
[2/5] platform/x86: fujitsu: Reorder code to avoid forward declarations
      commit: c256927c62475f222bd9fc913538dd484f88fed6
[3/5] platform/x86: fujitsu: Register ACPI notify handlers directly
      commit: 9b9271ac2a25f427dd38a3f486e8b4d7afe7e0ec
[4/5] platform/x86: fujitsu: Convert backlight driver to a platform one
      commit: d5c9212ccfaa7bd453bf4b198eb19937f5deb58b
[5/5] platform/x86: fujitsu: Convert laptop driver to a platform one
      commit: 6da22b031a3cf995d6488500a5edae07cae3df2d

--
 i.

