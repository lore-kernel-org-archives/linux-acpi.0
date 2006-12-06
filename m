From: Andrew Morton <akpm@osdl.org>
Subject: Re: Possible bug in ACPI
Date: Wed, 6 Dec 2006 07:54:49 -0800
Message-ID: <20061206075449.22a1ded4.akpm@osdl.org>
References: <20060919214724.GB2073@panelnet.cz>
	<20061109140416.db12bcbe.akpm@osdl.org>
	<20061202205140.GA12447@panelnet.cz>
	<20061202192632.d1815e5f.akpm@osdl.org>
	<457293AE.2060701@linux.intel.com>
	<20061203021216.e15b1d5d.akpm@osdl.org>
	<4572994C.6020603@linux.intel.com>
	<20061203122731.c9a514aa.akpm@osdl.org>
	<45734070.6040305@linux.intel.com>
	<4576E364.3090800@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:36156 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936116AbWLFPy5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Dec 2006 10:54:57 -0500
In-Reply-To: <4576E364.3090800@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 06 Dec 2006 18:36:04 +0300
Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:

> Would it be better to replace sys_sched_yield() with cond_resched()?

I don't know, because I don't understand the dynamics of the proposed
change at all.

Again:

- How does it relate to http://lkml.org/lkml/2006/8/8/336

- Can we please have a *full* description of the problem and of the proposed
  solution?
