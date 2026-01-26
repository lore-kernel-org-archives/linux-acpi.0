Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90E330313;
	Mon, 26 Jan 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439413; cv=none; b=oTapVa6SjOpFYSajszqGOy5mKtKQqWBv1ExUUlDOCAr5J+AedrtN8i2aiDtqBfd3Yk2n5B0W0x+VRDosahHLDuoV5ZhahcLntQBEq5BYmEL/8+ZGuva9eL8gJ7Iyv/+6X8e7leaJwQCPzZFbDxQnRWCWsuZT8QKYTB8t6FI1vXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439413; c=relaxed/simple;
	bh=ViDvoSKBIkbfAUKoHW1qK5shbTOFpzr6T+Hzqn1qWuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KLuuaGdYkQB7QYwvDdivQMLNelCpDvXO1gmVn6qENfeFnxxIUEK4Beyuc/ANgFaRQ4sZZcqtYNASkrPTaE/UqmgCnTBg5SDCcPMvQDXDBmE7nJLQvbgm0CVdJFnlDBX3pS2fFMtaBRf1e62LPTnZie781Gqw4GK1BNA5Uc9aqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US/KU8Nz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US/KU8Nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769439412; x=1800975412;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ViDvoSKBIkbfAUKoHW1qK5shbTOFpzr6T+Hzqn1qWuU=;
  b=US/KU8Nztd7bkfLXVm5RrY8EEhks11u3/rWbNO4+0w3als2K7yQuo2ok
   RaseYGNvxqoUzxjCkQvh3ftUF31ob1QWLzWerT9hfubjRanqObuMMW5kn
   8p8m3pcKxECiVZ3DFiinZ+/HEb4TlGsRxviL+kiTscbIz1BsN5jOmhVTo
   XAUgygEHr/Z5hatELqqNBRpNfP3F/npvJ508Zm+oDomCYSz4kPUoOkYEW
   yVv4uRcEohhqopp6bzvQsX+nhrRX6hvYdHo/a3wK+A7dDXwB4S8tYoHW2
   9OARbadsD1rOmlucfvGV4ri30WDL8P7tSh9lxH/pkgtbAA5RuzxVQjIAI
   w==;
X-CSE-ConnectionGUID: Ys3ShUaxSfOJPAKehlBUtw==
X-CSE-MsgGUID: WZhq6GiCSV+q+bAz2r6y/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70584579"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70584579"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:56:51 -0800
X-CSE-ConnectionGUID: 2QVpeijcQ76X3ocWtBAd4w==
X-CSE-MsgGUID: e/mKuvoHQZuJYicVXSrlCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="212166191"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.150])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:56:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 Kenneth Chan <kenneth.t.chan@gmail.com>, 
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>, 
 Matthew Garrett <matthew.garrett@nebula.com>
In-Reply-To: <3026924.e9J7NaK4W3@rafael.j.wysocki>
References: <3026924.e9J7NaK4W3@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: Fixes for leaks in
 panasonic-laptop and toshiba-haps drivers
Message-Id: <176943940108.16098.4666901319744494904.b4-ty@linux.intel.com>
Date: Mon, 26 Jan 2026 16:56:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 20 Jan 2026 16:42:41 +0100, Rafael J. Wysocki wrote:

> These are two fixes for leaks in the panasonic-laptop and toshiba-haps drivers,
> in the "probe error" and "remove" paths.
> 
> Thanks!
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: panasonic-laptop: Fix sysfs group leak in error path
      commit: 43b0b7eff4b3fb684f257d5a24376782e9663465
[2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove routines
      commit: 128497456756e1b952bd5a912cd073836465109d

--
 i.

