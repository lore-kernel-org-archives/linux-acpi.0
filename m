From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: 2.6.29-rc7 does not power off on halt
Date: Tue, 10 Mar 2009 09:36:04 +0100
Message-ID: <871vt5ai6j.fsf@tac.ki.iif.hu>
References: <87vdqishgp.fsf@tac.ki.iif.hu>
	<1236646085.7060.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:51744 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbZCJIgN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 04:36:13 -0400
In-Reply-To: <1236646085.7060.20.camel@localhost.localdomain> (yakui zhao's
	message of "Tue, 10 Mar 2009 08:48:05 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

yakui_zhao <yakui.zhao@intel.com> writes:

> On Tue, 2009-03-10 at 02:01 +0800, Ferenc Wagner wrote:
> 
>> The current git kernel doesn't switch off power as the last step of
>> system halt (-p) on our Atom systems.  Everything seems to be all
>> right, just the power remains on.  Is this a known issue perhaps?
>
> Do you mean that the previous kernel can switch off the power when using
> the halt(-p)? 

No, I haven't yet found a kernel which could switch off this mobo.
2.6.24 and 2.6.29-rc7 can't, at least.  I'll test 2.6.28.7 shortly.

> How about this issue when using the command of "poweroff" on the current
> git tree?

I always thought that halt -p and poweroff are exactly the same.  The
userspace on these machines is pretty old, if that matters (Debian
Sarge, that is, oldstable).  Does it?
-- 
Thanks,
Feri.
