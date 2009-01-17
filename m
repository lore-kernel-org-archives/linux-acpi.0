From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: WARNING: at kernel/trace/ftrace.c:434 ftrace_bug+0xdb/0x2b1()
 in 2.6.29-rc1-next-20090116
Date: Fri, 16 Jan 2009 22:01:45 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901162201120.9232@gandalf.stny.rr.com>
References: <1232144843.6614.14.camel@localhost.localdomain>  <alpine.DEB.1.10.0901161939320.9232@gandalf.stny.rr.com> <1232158716.6614.20.camel@localhost.localdomain> <alpine.DEB.1.10.0901162138410.9232@gandalf.stny.rr.com>
 <alpine.DEB.1.10.0901162200220.9232@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:54504 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZAQDBr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 22:01:47 -0500
In-Reply-To: <alpine.DEB.1.10.0901162200220.9232@gandalf.stny.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>


On Fri, 16 Jan 2009, Steven Rostedt wrote:
> > 
> > $ objdump -Dr -j __mcount_loc drivers/acpi/thermal.o 
> > 
> > and perhaps we can find a duplicate there?
> > 
> 
> Actually, if you can post that file, that might help too.

The drivers/acpi/thermal.o file, just in case I was too ambiguous ;-)

-- Steve

