Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5B3909A9;
	Mon, 23 Mar 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262801; cv=none; b=OIn0r6x/X8oJoYpFuOKAr8NzZLR6cOlgE1lrDeKKoJibDP9v+AB8USP9U9wMMDUPcbu7MyO7nQ81PHhN7WRnEfDnfaPO7RudoZ9ynAySgn+TDDeg/1s7XxmH3V5OJ7IPT+zyEZJikTKaRfj3IWJaflzgMuwzy4Hoyt0EMAAkXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262801; c=relaxed/simple;
	bh=oYuEJFs+lAwCStEmkw9q+hSEOEUstVyUJXFJ2jiFczE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o0B82FnA/0GU3Lau0D31m/EHvQ8bcHx2Y+woZcDh5EVBxVAXLcICfkGl1OePoLdEAYt7myzGcmw2bcgP43ynptfgMwifCmGvx8h/CTAVWkFvou53mxLBpHI2opGrEiwP0mry4S8TvOEeyJFDg4hoUEMEwT42jXFDqo2YjQ2nDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7sie2Hu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7sie2Hu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774262800; x=1805798800;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=oYuEJFs+lAwCStEmkw9q+hSEOEUstVyUJXFJ2jiFczE=;
  b=V7sie2HuDKcVe1GgR5W1TKKQc79D9BQ8qdUEuI7oT/cH0sbu5WzegV09
   /Wl35cwomi6aMmweoFRVrG7FkNpUHsh02S/L9WFpOeL4fxOT0B3BTVUsV
   dedXjhX8GJiaOaEwx3ERPTkr6fSmRvOvSbyKUXyCZgv0fWbUUjq4PQdYZ
   l9rIKL+ta9t34x7d/0zes9T9XLj12gynx0w3ATyX/DuzfkZKJ6xjKUeJ0
   rLsXLel71E9WkAcTwFSQQ6kR7mZ+gpDtO5JMucqIM0qEtp5wTi5RbUMdY
   KPKsslJOy1m8d6WRyViSuwFvrhtJkzsmb8AU2BGXewb0Xat2KmFudQuWf
   A==;
X-CSE-ConnectionGUID: 3VGMh294R+G+159RwDFHaA==
X-CSE-MsgGUID: ysiNKef/TRuqpLwWDTkhaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75226700"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75226700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:46:38 -0700
X-CSE-ConnectionGUID: TzEecQ63Rt2pvqR4LQ+vqw==
X-CSE-MsgGUID: P31iiRpUTO+OfLpDkshUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="261901737"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:46:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, Jeremy Soller <jeremy@system76.com>, 
 System76 Product Development <productdev@system76.com>
In-Reply-To: <4721148.LvFx2qVVIh@rafael.j.wysocki>
References: <4721148.LvFx2qVVIh@rafael.j.wysocki>
Subject: Re: [PATCH v2 0/3] platform/x86: system76: Bind to a platform
 device instead of an ACPI one
Message-Id: <177426278951.8512.17297700686593522021.b4-ty@linux.intel.com>
Date: Mon, 23 Mar 2026 12:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 18 Mar 2026 14:48:57 +0100, Rafael J. Wysocki wrote:

> This is an update of
> 
> https://lore.kernel.org/linux-acpi/2841136.mvXUDI8C0e@rafael.j.wysocki/
> 
> adding one preparatory patch and updating the other patches to implement
> the probe rollback code path slightly differently.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: system76: Drop redundant devm_led_classdev_unregister()
      commit: 5539165cae8e133275f0eed4cfa131cda974a1a3
[2/3] platform/x86: system76: Register ACPI notify handler directly
      commit: 89729c9c6c158259b8de14c57b5aac6a25dfac3d
[3/3] platform/x86: system76: Convert ACPI driver to a platform one
      commit: 80b8f68b94abcf6f2f8c71a685b2a70fd7c502b0

--
 i.

