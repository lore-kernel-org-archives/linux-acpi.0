From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: WARNING: at kernel/trace/ftrace.c:434 ftrace_bug+0xdb/0x2b1()
	in 2.6.29-rc1-next-20090116
Date: Sat, 17 Jan 2009 00:40:49 -0200
Message-ID: <20090117024049.GI6562@ghostprotocols.net>
References: <1232144843.6614.14.camel@localhost.localdomain> <alpine.DEB.1.10.0901161939320.9232@gandalf.stny.rr.com> <1232158716.6614.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:58942 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZASNYS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jan 2009 08:24:18 -0500
Content-Disposition: inline
In-Reply-To: <1232158716.6614.20.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Em Fri, Jan 16, 2009 at 09:18:36PM -0500, Eric Paris escreveu:
> On Fri, 2009-01-16 at 19:47 -0500, Steven Rostedt wrote:
> > # mount -t debugfs none /sys/kernel/debug
> > # cat /sys/kernel/debug/tracing/dyn_ftrace_total_info
> 
> [root@unused ~]# cat /sys/kernel/debug/tracing/dyn_ftrace_total_info 
> 0 0 0

Rostedt, see?

/me now using /d/tracing/

;-)
 
- Arnaldo
