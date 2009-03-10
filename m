From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: 2.6.29-rc7 does not power off on halt
Date: Tue, 10 Mar 2009 08:48:05 +0800
Message-ID: <1236646085.7060.20.camel@localhost.localdomain>
References: <87vdqishgp.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60414 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbZCJArE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2009 20:47:04 -0400
In-Reply-To: <87vdqishgp.fsf@tac.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-03-10 at 02:01 +0800, Ferenc Wagner wrote:
> Hi!
> 
> The current git kernel doesn't switch off power as the last step of
> system halt (-p) on our Atom systems.  Everything seems to be all
> right, just the power remains on.  Is this a known issue perhaps?
Do you mean that the previous kernel can switch off the power when using
the halt(-p)? 
How about this issue when using the command of "poweroff" on the current
git tree?
    
Thanks.
> 
> Thanks,
> Feri.
> 

