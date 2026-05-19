Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DC33123F;
	Tue, 19 May 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193513; cv=none; b=TxOWSkTf/y8i8jPduCiJCzHeMe+PAim+e7DnUZN3Frwg3OCvRxIlrTspkaAzsUsl+B8hYxPvkxSOvzdCdnmK9xWS16530axaTLJWCPK2CdYFpfeM0oLCnYcqBhMwQnKGh7oCaSljmjxb3JkPhIu1Grayi/MkNmrGLof6Jam6QY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193513; c=relaxed/simple;
	bh=atG068PdaO6s+MBMfiRQ45AcgAYUP3H7VFufpmhnCKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YiIlU/jkxMSqn2pEChucuFLK8Otmv5qpBYe1DJNPROEJRjvm4XsNXy7zk+B4o5g6aatHd+BOrf7wtwWr2En/zM0P08W0SHg0zQPSeMyBO9nH8IOlNwmdGm4ahocQkdUazHvdJbHX2KoubeRW809PtAWf1zkxn6h/fI/2+lKPw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnAUc2g8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnAUc2g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779193513; x=1810729513;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=atG068PdaO6s+MBMfiRQ45AcgAYUP3H7VFufpmhnCKk=;
  b=lnAUc2g8bpWHzas/8ntpWNnYjsrY40jh0DzTiDVIkxbpwOa7w1yJvdff
   Ix0b6zd4lPWU0wfQSYErtR/i3j0J7lbxAMU8i0DUQ7/yJZFFg+A0a3Ctl
   NFOl0r45bMrvDTW+RjvUh7LdmnN3xy8noOjFsKA/7CQYazIJnlAlwvX+e
   mY5IRBfKnuUAbLQHGR+kFvBVgQYoQ2hFrBeF76fNXyiz/HHwowu+jAojF
   Db9151Fkx2jt95a9z8H5RjFbSZw8hWsGUJGBYhZRY/FkZ1bFTxiT6mQ+Q
   Yw3L56YSFgMD+x9F6KK63vUVW1CWPu0GIReKs5JTZurY6AGZ+dSEQKehM
   Q==;
X-CSE-ConnectionGUID: 4SnYRrrZTPirwAqiQxWfUg==
X-CSE-MsgGUID: VItUCGusQQq1YWjMXEoO1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79970158"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79970158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:25:12 -0700
X-CSE-ConnectionGUID: xhsu9kCzS3qvUveOjr7gOQ==
X-CSE-MsgGUID: MMKGiVOrQFOYaazshOr75Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235500957"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:25:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>, 
 Matan Ziv-Av <matan@svgalib.org>, Kenneth Chan <kenneth.t.chan@gmail.com>, 
 Mattia Dongili <malattia@linux.it>, Jeremy Soller <jeremy@system76.com>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <12904885.O9o76ZdvQC@rafael.j.wysocki>
References: <12904885.O9o76ZdvQC@rafael.j.wysocki>
Subject: Re: [PATCH v2 00/16] platform/x86: Check ACPI_COMPANION() against
 NULL during probe
Message-Id: <177919349712.8561.1526069342986461066.b4-ty@linux.intel.com>
Date: Tue, 19 May 2026 15:24:57 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 12 May 2026 16:01:43 +0200, Rafael J. Wysocki wrote:

> This series replaces
> 
> https://lore.kernel.org/linux-acpi/5990022.DvuYhMxLoT@rafael.j.wysocki/
> 
> and, as a whole, it makes exactly the same code changes.
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[01/16] platform/x86: acer-wireless: Check ACPI_COMPANION() against NULL
        commit: 227e86af748bd804813b2200b6ae73ceaacaa383
[02/16] platform/x86: asus-laptop: Check ACPI_COMPANION() against NULL
        commit: 75d47068603646439930d6db1794fa363c2819da
[03/16] platform/x86: dell/dell-rbtn: Check ACPI_COMPANION() against NULL
        commit: 948d2ee19da7f886a3c4f9954a42c3c77facb8e0
[04/16] platform/x86: eeepc-laptop: Check ACPI_COMPANION() against NULL
        commit: a0e070895d849e2e73d56a1f95c9093c10da2741
[05/16] platform/x86: fujitsu: Check ACPI_COMPANION() against NULL
        commit: 493c2f4ca878a843ae0f7efb695b0ac4bcf628eb
[06/16] platform/x86: fujitsu-tablet: Check ACPI_COMPANION() against NULL
        commit: 7de479068fdcf34e64807324e794c76675776740
[07/16] platform/x86: intel/rst: Check ACPI_COMPANION() against NULL
        commit: 4f47c9d8b97b6c1e2534fec7f28b6b6e5daa30b6
[08/16] platform/x86: intel/smartconnect: Check ACPI_HANDLE() against NULL
        commit: c37b59d57cb373e70156bbe1978cea9846d2f0ec
[09/16] platform/x86: lg-laptop: Check ACPI_COMPANION() against NULL
        commit: fea5ef6f3265e6a0202f8b27e4a648c800e3b9a9
[10/16] platform/x86: panasonic-laptop: Check ACPI_COMPANION() against NULL
        commit: 2c49165dc1a4e9187dc39599ae286518feac99be
[11/16] platform/x86: sony-laptop: Check ACPI_COMPANION() against NULL
        commit: 93ecc19cbb7830d0f9d33756f4c19414f61622d2
[12/16] platform/x86: system76: Check ACPI_COMPANION() against NULL
        commit: 3dceea280d76c674bd36f1928115ba4e8f6b7a5e
[13/16] platform/x86: toshiba_acpi: Check ACPI_COMPANION() against NULL
        commit: 9742234cb913394746b45279ec0c25f906d0924b
[14/16] platform/x86: toshiba_bluetooth: Check ACPI_COMPANION() against NULL
        commit: aab866f5d75e4720d3a4ef7dac1d3ab84432205c
[15/16] platform/x86: toshiba_haps: Check ACPI_COMPANION() against NULL
        commit: 74fc85c475f3886bd4804d92f372be73e7dfac98
[16/16] platform/x86: wireless-hotkey: Check ACPI_COMPANION() against NULL
        commit: ad893c008d568dccf89e3bcaadfc4dd3797183c7

--
 i.

