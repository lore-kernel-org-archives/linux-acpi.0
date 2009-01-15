From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Fan running continuously after kernel switch
Date: Thu, 15 Jan 2009 17:29:36 +0800
Message-ID: <1232011776.3989.25.camel@yakui_zhao.sh.intel.com>
References: <1232008941.24218.6.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22362 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbZAOJST (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2009 04:18:19 -0500
In-Reply-To: <1232008941.24218.6.camel@pancake>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-01-15 at 16:42 +0800, Florian Echtler wrote:
> Hello everyone,
> 
> yesterday, I switched from kernel 2.6.25-gentoo-r8 to 2.6.27-gentoo-r7
Please attach the output of acpidump so that we can confirm whether the
fan device is controlled by thinkpad acpi driver or generic fan driver.

Will you please check the kernel version of 2.6.27-gentoo-r7?
How about this issue if you only update the kernel?

Of course you can file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
output of acpidump, dmesg, /proc/acpi/fan/*/state
thanks.
> on my Thinkpad T60. Since then, the fan has been running continuously. I
> have loaded the thinkpad_acpi module and could, of course, switch to
> some userspace fan controller, but I'm always a bit reluctant about
> those. I've reviewed the Gentoo patches, and none of them seem to have
> to do anything with ACPI. So now I'm looking for suggestions on how to
> debug this..
> 
> Many thanks, Yours, Florian

