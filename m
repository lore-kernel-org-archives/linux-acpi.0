From: venkatesh.pallipadi@intel.com
Subject: [patch 0/2] Support for IA32_ENERGY_PERF_BIAS MSR
Date: Tue, 02 Mar 2010 16:06:49 -0800
Message-ID: <20100303000649.757684000@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20201 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab0CCASj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Mar 2010 19:18:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

There is a new hardware feature, which lets system software to set
Energy Performance Preference. This is a opaque knob in the form of
IA32_ENERGY_PERF_BIAS MSR, which has a 4 bit Energy Performance
Preference Hint.

The support for this feature is indicated by CPUID.06H.ECX.bit3. Refer to
Intel Architectures Software Developer's Manual for more info.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

-- 

