From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [RFC] Using per_cpu(processor) information to pipe it up the hypervisor. v1
Date: Tue, 31 Jan 2012 10:32:03 -0500
Message-ID: <1328023924-6858-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:21285 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab2AaPer (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2012 10:34:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, lenb@kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org
Cc: xen-devel@lists.xensource.com

I was wondering if you could advise me ontwo questions:
 - How to "get" ACPI PM information for processors that are down (either b/c of
   maxcpus=X or they are hot-plugged). The per_cpu(processor) is a great location
   to get all of this - but sadly it is not filled with information for dead CPUs.
   Is there another way to get this data?

 - Where should such a driver (see the patch please) live? I was thinking drivers/acpi/
   but since the "processor" is an exported symbol it could live in drivers/xen as well?
   What is your feeling about it?

Short description of the patch: It simple parses the "per_cpu(processor)" data and 
pipes it up the hypervisor and then unloads itself. It is a much shorter version
of https://lkml.org/lkml/2011/11/30/245, but it does have the caveat that it does
not work with 'maxcpus' or with hot-plugged CPUs or with limiting the amount of
CPUs a guest can see.

P.S.
Also the name of it stinks. 'Sink' or 'plumber' initially came to my mind. Any
thoughts of a better name?

Thanks!

 drivers/xen/Kconfig         |    5 +
 drivers/xen/Makefile        |    2 +-
 drivers/xen/acpi_xen_sink.c |  265 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+), 1 deletions(-)

