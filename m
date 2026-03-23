Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C4390999;
	Mon, 23 Mar 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262799; cv=none; b=pAiXNMyPNASRmbZli6zJvo0jjym8RzX1l9EHRMYqY0Vnf3EjvBOGSXULO0SKuVDTYwyeOW8mU29y1UtxMZjH9HWEGB7J7t3TrpPl54+QXJcSOd6HBmWIq3lUlgRKPNj7RWSZgFTrGFw21ByopfOmlVViVu+CYo2lIGvigguRaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262799; c=relaxed/simple;
	bh=MporbxhHtp79tG8SQcBr7biQCODJN7ATT7++lCKV0rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ARX5wOMoDG0E3Vjt9IjaKNNKS5LBzeeWChS1DLDRUIjDTsFCCm35PR53LnnrG4uFcDvL8DYJ/yr8fHZtbgHb5H+5DbsjbqlIqqAICtj2F0YqaXcuB3kWSz8fdGRoToRFtB5FiZ8QEGaNrKjtdVav2YXc2DCbI0bz/5Gx3GAlQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBPqeJ6a; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBPqeJ6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774262799; x=1805798799;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=MporbxhHtp79tG8SQcBr7biQCODJN7ATT7++lCKV0rE=;
  b=aBPqeJ6aX7DKqfBSmiY6rsfkjQWcZLH7LOv86e49ZthXUJNLZlbgyL8C
   39gTdwR1G5pEUQSYyQv7/aErKUl9cOHzYDvrHFHJ51J33ohhnnll3Hdyk
   xR1msXISBh4ELe5aGRP7QV4lAZhsGnSUC4aSv29f35Xh1Uygb4TsbRtXM
   TY0BlcHS3egSNsJj99Lssd3TNqUluuRJQpkk3l8yNLPQhQQgPJqC1Z5qF
   +RtNmwZqrvK/xWwZUlwktgxX3kCtULA/yczVGi/5TQazKiCJIfKzyXqeF
   7ABQywvSj54v3QKJmNtxcTBLii96oEEOm5IkMVNtGxf5KcF7QmcRtvLYa
   g==;
X-CSE-ConnectionGUID: 0VgXsFi5T+C8HGu8iOGk+g==
X-CSE-MsgGUID: rKIvcMpkR86zTbzSgPPVGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75226695"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75226695"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:46:29 -0700
X-CSE-ConnectionGUID: 8SGX+4o1TOecjMHacIyfHw==
X-CSE-MsgGUID: TvuaNbktRH+Vz3B1j/bVMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="261901727"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:46:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Kenneth Chan <kenneth.t.chan@gmail.com>
In-Reply-To: <5983583.DvuYhMxLoT@rafael.j.wysocki>
References: <5983583.DvuYhMxLoT@rafael.j.wysocki>
Subject: Re: [PATCH v4 0/5] platform/x86: panasonic-laptop: Bind to a
 platform device instead of an ACPI one
Message-Id: <177426278123.8512.11646057098581105846.b4-ty@linux.intel.com>
Date: Mon, 23 Mar 2026 12:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 20 Mar 2026 11:29:16 +0100, Rafael J. Wysocki wrote:

> This is an update of
> 
> https://lore.kernel.org/linux-acpi/12863246.O9o76ZdvQC@rafael.j.wysocki/
> 
> addressing a driver_data pointer leak in the last patch.  The other patches
> in the series remain unchanged.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: panasonic-laptop: Make pcc_register_optd_notifier() void
      commit: e2b0cd5c265f01977ed4e7f04bd989cdb0b9eaed
[2/5] platform/x86: panasonic-laptop: Fix OPTD notifier registration and cleanup
      commit: 8baeff2c1d33dad8572216c6ad3a7425852507d4
[3/5] platform/x86: panasonic-laptop: Remove redundant checks from 3 functions
      commit: a347e11252c60bfce1bf15f2f86484cdb9bf6468
[4/5] platform/x86: panasonic-laptop: Register ACPI notify handler directly
      commit: 0381b6a65716dae778fb4b5ee4ee42aca62402e9
[5/5] platform/x86: panasonic-laptop: Convert ACPI driver to a platform one
      commit: de6837243af00dc22b5117f45a35ec20adbf62c5

--
 i.

