From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/5] acpi: remove interpreter lock
Date: Fri, 08 Aug 2008 04:40:45 +0200
Message-ID: <489BB22D.2040001@linux.intel.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com> <1218121178-13779-2-git-send-email-dwalker@mvista.com> <1218121178-13779-3-git-send-email-dwalker@mvista.com> <1218121178-13779-4-git-send-email-dwalker@mvista.com> <1218121178-13779-5-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33681 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbYHHCkj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Aug 2008 22:40:39 -0400
In-Reply-To: <1218121178-13779-5-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

Daniel Walker wrote:
> Lockdep has identified this lock as a source of potential deadlock in
> acpi. After reviewing the lock it's not clear what it's protecting. I
> invite anyone who might know what the point of the lock is to describe it.
> 
> In the mean time I removed the lock completely which, so far, hasn't had
> any ill effects on my test machines.

As Bob pointed out this lock is required by the ACPI specification. So I'm
not going to apply this patch.

However of course we still have to do something about the lockdep warnings
when the lock is dropped/reaquired.

The big question is if deadlocks can happen really or not. AFAIK we didn't
have a clear answer on that yet.

-Andi
