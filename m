From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Mon, 16 Jun 2014 23:37:49 -0400
Message-ID: <20140616233749.472272c0@gandalf.local.home>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
	<1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
	<20140612092808.5f7bec5e@gandalf.local.home>
	<20140613021956.GA17509@gchen.bj.intel.com>
	<20140612230117.46758e3c@gandalf.local.home>
	<20140612230833.3c0f41b2@gandalf.local.home>
	<20140613070928.GA29351@gchen.bj.intel.com>
	<20140617020937.GA14404@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:29048 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755087AbaFQDh6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2014 23:37:58 -0400
In-Reply-To: <20140617020937.GA14404@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Mon, 16 Jun 2014 22:09:37 -0400
"Chen, Gong" <gong.chen@linux.intel.com> wrote:

> 
> Any update, Steven?

Sorry I missed this. Claws-mail has an annoying tendency when I have
something selected and I get new mail, it turns all my mail to read
except the mail that just came in. I need to figure out that bug and
fix it :-(

Anyway, I know what your issue is. It's the check for signed type. It
doesn't work for structures. I'm working on a way to fix that.

-- Steve
