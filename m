Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792958049;
	b=gesDmDOqe99H6u5W40g9CxP4cw6RV91qE9QEhlKdUL9y++LlL2AXcGUi/IQdao1Z0Fc6
	 x+7pjcryjacSnJvArtnJzWlR5n2Rjt3rkb5i6eUlzsdKmzboJLfQjedIliWDkDo+mZVVr
	 XZqSXidT9f93aApAeYsYVeQZ83PoKeRXqWC7iPdJGV0TjKZ8uJs0yTbxxPqxN/jzVhWBC
	 oOs3ZK7M2HIEBudr/NSAyAfdJTQhtAaPTJgYT3eAeB7XUMXqm17Kqt8VEPHdRCbEi4FsY
	 JFLyOyjW0w15MFrv5/TvNWnENxNKTZ3hpWZCQ9F+vUYOJnUNzfSLO9Xe3AzPBorOQ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792958049;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=JU9XuTbVic00aX2XIYpUTfMhF3r9H+uOivOo8/f6ovU=;
	b=SpzTUtIZfQD25TRw8S0OM4Nkmx6yqZdTEjoaQfN+gI/XMBCp3fwzBCeaLLcMFd82bsUY
	 J4PRpWWfA1nz9AL6krn5gsZGBSw7D9SpW1DWhLQuK2VnqXLeU4j5hQ9P6SV1Qx0WEWx/l
	 bdYzokuriqT9Fuu3LDWEnnbnbUYVcvXcEzLT+j6KIwvbfcxxxpS5kcrfX4H+pS06J77Uc
	 3idf+yUR+IvmWoXyWAbseHgXb+J5F58WRclZwpm4NHFcAzYG4nC+lu9t9CcpHAhYiF//7
	 zI9whR1IKa9myIF+ntplL69S/PIktvTIfwu1jzF83/Oxt9fyV2Df9YbkA/SEMkdNWrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mkqSJuU6;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53261606A31A
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 19:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53261606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mkqSJuU6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792958048; x=1824494048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xi/Qru03N7sawIn+L94p5x2lIbXKvduBotLLrTEFsx0=;
  b=mkqSJuU6LLWR1wi/Yb89NNzaMYQSUZOF4mSMY/ie2/gD4YCXqIaTPxBW
   87zVJLNpXivF9kp7+GDTZYzsAsjg0iKg1MA4RXnDugIjSpBad4rWWv0N5
   SkThStbIXe1zxB0M2nBV1UrIC8mHUzKt17CMPXSY1v2yh8LPSx/YwHv0Z
   qZIc7novReMpG2XQ5FYzQN/s0s+M1h7tQoGvVw2d147dASillYSkBBYwP
   mdkNpgpCynZULfEglRv7BENzapqEoBDGnn3iE9aINb4CrUjehNo8fa6Gh
   znwJAQxaaUnu19mGr7L3msFTfhu1dx+oTL4cbKhvy/UfDeQ5IcdcI2fgo
   g==;
X-CSE-ConnectionGUID: JZeTV1cwSy6VWr/JVNd/7Q==
X-CSE-MsgGUID: m5KkcZZsSuCftu+HhbKCdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1733351"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1733351"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:54:08 -0700
X-CSE-ConnectionGUID: lipcAlBQQTCVUjF1tZ205g==
X-CSE-MsgGUID: ZFB7McbBRWa3fSZFN+bcIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4037557"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:54:03 -0700
Date: Sun, 25 Oct 2026 21:54:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Sebasti=E1n?= Luna <sl140998@gmail.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com,
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
	lpieralisi@kernel.org, sudeep.holla@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, sunilvl@ventanamicro.com,
	andy@kernel.org, westeri@kernel.org
Subject: Re: [PATCH] ACPI: resource: Add AIR SRL CX307XX to
 irq1_edge_low_force_override[]
Message-ID: <at5eWf7xv55vzrmk@ashevche-desk.local>
References: <CABB517Jjts2i7vEeVQE714c1CWhQiBEnwWQwUd+KzBz_B1HTEA@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABB517Jjts2i7vEeVQE714c1CWhQiBEnwWQwUd+KzBz_B1HTEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 02:01:05PM -0300, Sebastián Luna wrote:
> The AIR SRL CX307XX (board name CX30000, BIOS 1.09, Ryzen 3 3200U)
> describes the PS/2 keyboard IRQ in its DSDT as:
> 
>     IRQ (Edge, ActiveLow, Shared, ) {1}
> 
> and the MADT has no Interrupt Source Override for IRQ 1. Since the
> kernel ignores the DSDT IRQ description for IRQ 1 on AMD Zen systems,
> the keyboard ends up with the default ISA settings (edge, active high)
> and receives no interrupts: the i8042 counter in /proc/interrupts stays
> at 0 and atkbd logs "Failed to deactivate keyboard on isa0060/serio0".
> 
> Booting with acpi=noirq works around it, but then the internal touchpad
> (I2C-HID behind pinctrl_amd) stops working.
> 
> Add the machine to the irq1_edge_low_force_override[] DMI table. With
> this entry the keyboard and touchpad both work without any kernel
> parameters and the i8042 interrupt counter increments normally.
> 
> Tested on the CachyOS 7.3.0-4 kernel (drivers/acpi/resource.c is the
> same table as in mainline).

Your patch is mangled. Use proper tools and/or fix yours.

-- 
With Best Regards,
Andy Shevchenko


