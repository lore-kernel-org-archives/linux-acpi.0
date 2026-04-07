Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2D3A7F73;
	Tue,  7 Apr 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557272; cv=none; b=jDVIm6cF9FA4pjdsf6HPhMf5mOSa8DyWKlQqLDmVXGJoA2ndhc94+cFEnfBzoy6Vjt2CLemIqbPUmF7JQMkP44AVOqqCMbdICJ78sxKJz8/FJ8pJGvBmzLV1h9jI3C2U3sQfSle3FTIsc2fqAffB34ettrynxCMct6RzSoyDSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557272; c=relaxed/simple;
	bh=lWEKuMDUirtY8W6D67nhHs6CO4IyDOIsCGg7DHJjIy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RABiPx9xL3FMi21j4pkKaSYOLTtOKKFdYP2l1LnHdpubEoSc+AFMaS9pNf8FP+/lQfSHpy3PRS7lUM0PBlZlGVv/YXKXVZRZoUCBA4BQVwbqUgP7djmf1hzhuX0MOQiZbtKlVvCZo2Tlxie4e8XPACAT1LOWGoPlHgGOXoJ7bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuO8X9Ev; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuO8X9Ev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775557271; x=1807093271;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=lWEKuMDUirtY8W6D67nhHs6CO4IyDOIsCGg7DHJjIy4=;
  b=AuO8X9EvWyucD+fdDHZvqQffMnsk9mKXdVNPdxVX7J2ABM7q8TU3/NbJ
   D+aJEZZZ36wWX0tClCWI35PwKYrhE3v3lQukX3ZfM2R+S2Fzo+w8oUfdk
   t+o+VNoM8BaRSOa+ML71/cY2H7Uyio0WaiaUq1TkalSRyVcdmVHxvJ1Ko
   EsT3K8wQ+eqKUbtamrqDv3O/SXzqg+wTW6RwKqzfA1fZSks54H/Ozr9Z1
   I7tNvIR7AAPjiWdS1pQgMMH6ZsCr/jqQ3dRHzpi98f+BBwIKAM9Jo+OOZ
   /76VrkgxMjDuarjiUxRCi2YZ9NcbbHPrSPlTg4lxNaedga1oFStqUA0PX
   A==;
X-CSE-ConnectionGUID: holXHKW/Qti0jiECpl6Z6w==
X-CSE-MsgGUID: GLFrcUHPTjmisLFJNqD7Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76234250"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76234250"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 03:21:10 -0700
X-CSE-ConnectionGUID: fZvG8Da2TgikQD0xbG8imQ==
X-CSE-MsgGUID: IChbp1q3RKWvDus9ALgTCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="229804585"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 03:21:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 ibm-acpi-devel@lists.sourceforge.net
In-Reply-To: <3949487.kQq0lBPeGt@rafael.j.wysocki>
References: <3949487.kQq0lBPeGt@rafael.j.wysocki>
Subject: Re: [PATCH v1] platform/x86: thinkpad_acpi: Drop ACPI driver
 registration
Message-Id: <177555726172.8162.3791830877649176236.b4-ty@linux.intel.com>
Date: Tue, 07 Apr 2026 13:21:01 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 24 Mar 2026 21:08:01 +0100, Rafael J. Wysocki wrote:

> There is no point in registering an ACPI driver that only has an empty
> .add() callback, which is done by the thinkpad_acpi driver, since
> after binding to an ACPI device it only sits there and does nothing.
> 
> That binding only effectively causes the ACPI device's reference count
> to increase, but that can be achieved by using acpi_get_acpi_dev()
> instead of acpi_fetch_acpi_dev() in setup_acpi_notify(), and doing
> the corresponding cleanup in ibm_exit().
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: Drop ACPI driver registration
      commit: 955165c3e537668b9a5a6eb26397281b88143002

--
 i.

