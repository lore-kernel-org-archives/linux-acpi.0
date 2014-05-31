From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7 v6] trace, RAS: Add eMCA trace event interface
Date: Fri, 30 May 2014 21:07:59 -0400
Message-ID: <20140530210759.267a854e@gandalf.local.home>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
	<1401247938-22125-1-git-send-email-gong.chen@linux.intel.com>
	<1401247938-22125-2-git-send-email-gong.chen@linux.intel.com>
	<20140528112832.5f83c66b@gandalf.local.home>
	<20140528163452.GF17196@pd.tnic>
	<20140528125625.6f6dcf7f@gandalf.local.home>
	<20140530092232.GA13495@gchen.bj.intel.com>
	<20140530100716.GE28131@pd.tnic>
	<3908561D78D1C84285E8C5FCA982C28F32823D2B@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:10036 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754575AbaEaBID (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 May 2014 21:08:03 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32823D2B@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Chen, Gong" <gong.chen@linux.intel.com>, "m.chehab@samsung.com" <m.chehab@samsung.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, 30 May 2014 23:03:27 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

 
> All of this stuff only applies to server systems - so quibbling over
> a handful of *bytes* in an error record on a system that has tens,
> hundreds or even thousands of *gigabytes* of memory seems
> a bit pointless.

But there's still only a limited number of bytes in the ring buffer no
matter what the system, thus we still need to quibble over it.

-- Steve
