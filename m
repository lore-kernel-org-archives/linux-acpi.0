Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606C37E2E1;
	Mon, 13 Jul 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941430; cv=none; b=pAFbwoMpF+Dux2WbCM3ltXXXY1W+37iRg12abN139FKwb9oXMw2/Hu1I8gEF9LK0lbz9jkAdwh9QP4y5xYIPwAmSpgxBb/goN1ZboyBMTUjmN9cRD2PbDdSh4WmilFeAXoUXUZN2rwvCXat/I3XXyfXN+j686e0eEuD/9k5tQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941430; c=relaxed/simple;
	bh=tQUMiHl3ZKsrx0k/trDSAtIDXR9krNv/MOFdqU/HB10=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c1UYNd6mTMhDReshLloCqk+D6/Cbc7u1EmldryLnuGNZ3UMhI48ZWQWUQp7Iqc3hpd52O82fdrlvXSDW079hKxmYCLvIz79jtdvjbQGDjOh7kP3kyxfrg3I3gihNTTRavPfkYxkz4gtaalZOcQEEaow7BQfIkNCNq1qmSLyfGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0945RVV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0945RVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783941428; x=1815477428;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tQUMiHl3ZKsrx0k/trDSAtIDXR9krNv/MOFdqU/HB10=;
  b=O0945RVVQbJLKTS5bcc0nnm8d6C2aDbJbGOv8Es0r3JaqoAkhVkpDZ6n
   MocXxSt2kzwl4RcTTfeshXGAq4es7Reblkfw1OTEiLJ7A8Tl5AtiLmqsW
   lE1gK9U1F2F5aCOo5oFQZS075J9V6PKG7LsQZmQVe1/aAUA0zXxHxbe/+
   A7Pa84zrzvFp9wJpTSmzPPoYjzPARlvKcJnzbGHrnsxEeB0byrdqaDNhh
   l31leBJHbkld32c/nNhq8C974bK/ZXmaJb9fFPevLFeYHBfVcdPjrwwPm
   CjydK5pB7ovrvrzR4wmKUb8+adZGCnM62ozMbO1td8JCmLRFqNUY4xQts
   w==;
X-CSE-ConnectionGUID: 8VxuiZ31RWuwuJRfISUniQ==
X-CSE-MsgGUID: rpJoGHr7TvaISn5DYLGBXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72070986"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72070986"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:17:07 -0700
X-CSE-ConnectionGUID: W/5nthkGQ4OOPyr/ha2fsQ==
X-CSE-MsgGUID: NbhIuxJeSg+xVTj7niQOxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260416371"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:17:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Jul 2026 14:17:00 +0300 (EEST)
To: Oliver Lin <oliver@liuxiaozhen.dev>
cc: Vishnu Sankar <vishnuocv@gmail.com>, platform-driver-x86@vger.kernel.org, 
    linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, vsankar@lenovo.com, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix USB-C Security probe
 failure on unsupported platforms
In-Reply-To: <142193d8-3860-4d9d-acc8-5b6a0569321a@liuxiaozhen.dev>
Message-ID: <960dff77-b5da-59c5-bc61-c1a72b2748e7@linux.intel.com>
References: <20260711062249.503264-1-vishnuocv@gmail.com> <142193d8-3860-4d9d-acc8-5b6a0569321a@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-557944583-1783941337=:1171"
Content-ID: <28524baf-0585-e19b-92e1-1248bb6c0d77@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-557944583-1783941337=:1171
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <cdce1ff9-f567-e014-13e7-8dd9e8a65411@linux.intel.com>

On Sun, 12 Jul 2026, Oliver Lin wrote:

> Hello Vishnu,
>=20
> It looks like my email address was recorded incorrectly. My address is:
>=20
>  =A0 =A0 oliver@liuxiaozhen.dev
>=20
> I'm currently testing this patch and will report back once the testing=20
> is complete.

Hi Vishnu,

To make things easier for me (and me less likely to forget while=20
applying), could you please send v2 with corrected email + the tested by=20
from the other email.

--=20
 i.
--8323328-557944583-1783941337=:1171--
