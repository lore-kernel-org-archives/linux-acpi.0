From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq governor
Date: Tue, 02 Mar 2010 16:30:49 -0800
Message-ID: <4B8DADB9.1040302@xenotime.net>
References: <20100303000649.757684000@intel.com> <20100303000849.278509000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:35380 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754365Ab0CCAav (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Mar 2010 19:30:51 -0500
Received: from chimera.site ([71.245.98.113]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 2 Mar 2010 16:30:49 -0800
In-Reply-To: <20100303000849.278509000@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 03/02/10 16:06, venkatesh.pallipadi@intel.com wrote:

{bah, more difficult to review an attachment, so no leading '>'}


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 8c666d8..4945add 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -749,6 +749,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			Default value is 0.
 			Value can be changed at runtime via /selinux/enforce.
 
+	epb		[X86] Control IA32_ENERGY_PERF_BIAS setting
+			"disable" - Kernel will not modify this MSR
+			<0..15> - Kernel will set this MSR to i/p static value
+


Should be more like:

	epb=		[X86] Control IA32_ENERGY_PERF_BIAS setting
			Format: { disable | <0...15> }
			"disable" - Kernel will not modify this MSR
			<0..15> - Kernel will set this MSR to i/p static value


But what is "i/p"?  Use whatever word it should be, please.
What do the values mean?
And what does IA32 have to do with this?  does it not apply to x86_64?

thanks,
-- 
~Randy
