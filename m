From: Andrew Morton <akpm@osdl.org>
Subject: Re: Possible bug in ACPI
Date: Sun, 3 Dec 2006 02:12:16 -0800
Message-ID: <20061203021216.e15b1d5d.akpm@osdl.org>
References: <20060919214724.GB2073@panelnet.cz>
	<20061109140416.db12bcbe.akpm@osdl.org>
	<20061202205140.GA12447@panelnet.cz>
	<20061202192632.d1815e5f.akpm@osdl.org>
	<457293AE.2060701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:59077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935706AbWLCJQ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Dec 2006 04:16:28 -0500
In-Reply-To: <457293AE.2060701@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Dalibor Straka <dast@panelnet.cz>, jikos@jikos.cz, linux-acpi@vger.kernel.org

On Sun, 03 Dec 2006 12:06:54 +0300
Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:

> This is a patch reverted by Linus from rc6-git2 because it broke his 
> Compaq n620c, it refers to #5534 bug. Basically, kacpid deadlocks on 
> some new HP notebooks, and all incoming requests would be queued until 
> memory is over if this patch is not applied. On a bright side -- it's 
> not a memory leak...
> Patch, which works for Linus laptop and "looks acceptable" to Linus is 
> the last in #5534 list.

hm, if you say so.  The description in that patch is nowhere near complete
enough for me to be able to work out what it does.

The sys_sched_yield() is particularly incomprehensible and needs good
commenting.  You are, I hope, aware of the severe problems which yield()
causes when the system is busy?  The process which calls it will get
practically no CPU at all.

Minor point: that patch has several unneded (and undesirable) casts of void*:

+static void acpi_os_execute_notify(void *context)
+{
+	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
	
please remove those.
