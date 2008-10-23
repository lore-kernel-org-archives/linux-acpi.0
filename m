From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] i7300_idle driver v1.55
Date: Thu, 23 Oct 2008 14:26:45 +0200
Message-ID: <49006D85.1050709@linux.intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com> <e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com> <20081011083347.GA31918@elte.hu> <alpine.LFD.1.10.0810161805360.3026@localhost.localdomain> <48FE07AE.4010203@linux.intel.com> <7E82351C108FA840AB1866AC776AEC4637CD27F3@orsmsx505.amr.corp.intel.com> <48FED3FA.6040703@linux.intel.com> <20081022234006.GB28775@linux-os.sc.intel.com> <48FFCF28.3070604@linux.intel.com> <7E82351C108FA840AB1866AC776AEC4637D389DB@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45053 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbYJWM0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2008 08:26:36 -0400
In-Reply-To: <7E82351C108FA840AB1866AC776AEC4637D389DB@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Henroid, Andrew D" <andrew.d.henroid@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "paulmck@us.ibm.com" <paulmck@us.ibm.com>


> This should not matter as we can safely remove the module even when
> one or more CPUs are idle. As long as one CPU is running, we are sure
> that throttling is not in effect. And as long as we make sure no one
> is executing the notifier that is going to be rmmoded, we should
> be OK. Say one CPU comes out of the idle later, it wont see the notifier
> in the notifier list anymore, because of RCU in atomic notifier
> and things will work fine. I mean we are not rmmoding the routine
> that enters the idle state. We are just rmmoding the routine that
> Can get called before and after idle routine.

That means there is a ordering dependency between the RCU idle
state getting updated and your code running. That is what I meant with
"very careful with idle". Even if it worked right now would
seem fragile to me.

-Andi
