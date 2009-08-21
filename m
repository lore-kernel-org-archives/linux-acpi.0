From: Eric Paris <eparis@redhat.com>
Subject: Re: BUG: scheduling while atomic in acpi_ps_complete_op
Date: Fri, 21 Aug 2009 16:25:52 -0400
Message-ID: <1250886352.2168.83.camel@dhcp231-106.rdu.redhat.com>
References: <1250873707.2168.38.camel@dhcp231-106.rdu.redhat.com>
	 <4A8EFFB2.4040100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25763 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200AbZHUUZz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2009 16:25:55 -0400
In-Reply-To: <4A8EFFB2.4040100@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Sat, 2009-08-22 at 00:12 +0400, Alexey Starikovskiy wrote:
> Hi,
> This should be handled by abe1dfab60e1839d115930286cb421f5a5b193f3.

And yet I'm getting it from linux-next today.

So you are apparently failing the in_atomic_preempt_off() test but
succeeding in your !irqs_disabled() test.

Something isn't right since I'm hitting it hundreds of times on boot.

-Eric

