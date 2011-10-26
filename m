From: Stefan Bader <stefan.bader@canonical.com>
Subject: Regression in 3.1 causes Xen to use wrong idle routine
Date: Wed, 26 Oct 2011 12:24:17 +0200
Message-ID: <4EA7DFD1.9060608@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37517 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603Ab1JZKYU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2011 06:24:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

The following commit changes calls to pm_idle into first trying
cpuidle_call_idle() and if that returns non-zero to fall back to
call pm_idle().

commit a0bfa1373859e9d11dc92561a8667588803e42d8
Author: Len Brown <len.brown@intel.com>
Date:   Fri Apr 1 19:34:59 2011 -0400

    cpuidle: stop depending on pm_idle

However cpuidle_call_idle() will return -ENODEV if it is supposed to be disabled
by cpuidle.off. Which then causes pm_idle() to be called.

This has some bad interaction with the following change that tries to
make use of disabling cpuidle in Xen to fall back to hlt.

commit d91ee5863b71e8c90eaf6035bff3078a85e2e7b5
Author: Len Brown <len.brown@intel.com>
Date:   Fri Apr 1 18:28:35 2011 -0400

    cpuidle: replace xen access to x86 pm_idle and default_idle

The problem I see is that select_idle_routine() is called from
arch/x86/kernel/cpu/common.c and since Xen setup does not set pm_idle
anymore, it can cause mwait_idle or amd_e400_idle functions to be selected.
In testing it seem amd_e400_idle in PVM domU at least does not immediately cause
problems, but mwait_idle just causes crashes. From the reports I have
this may be related to older hypervisors (3.1 and older) not clearing the mwait
capability. But overall there seems something wrong in the interaction.

I am not really sure whether the logic of calling pm_idle() on all errors from
cpuidle_call_idle() is already flawed or the assumption in the Xen patch about
being able to prevent the wrong idle function by turning cpuidle off is incorrect.
One quick fix could be to add some Xen case into select_idle_routine() which
picks default_idle...

-Stefan
