From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Tue, 30 Oct 2007 14:18:22 -0400
Message-ID: <200710301418.22639.lenb@kernel.org>
References: <200710300336.43696.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38570 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbXJ3SSk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 14:18:40 -0400
In-Reply-To: <200710300336.43696.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <cathectic@slackadelic.com>
Cc: linux-acpi@vger.kernel.org, "Nashif, Anas" <anas.nashif@intel.com>

When I consulted Anas about WMI, he recommended that Linux
expose WMI via CIMOM.  I think that this means we'd need
to invent a sysfs interface for this acpi->wmi driver
to expose the hooks to a user-space daemon, which
would then make sense of it in Linux's management framework.

Anas provided the references below.

thanks,
-Len


http://developer.novell.com/wiki/index.php/OMC

This is a Novell project with many providers dealing will many aspects
of the OS. They also provide RPMs for OpenSUSE and is the main source
for the OpenWBEM CIMOM binaries for SUSE.

http://sblim.wiki.sourceforge.net/

Is the IBM project dealing with instrumentation and home of the SFCB
CIMOM targeting embedded environments and only supports CMPI providers.

http://sblim.wiki.sourceforge.net/ProviderCmpiSysfs is a sysfs provider.
Seems to be old but is a good example.

http://openpegasus.org/

This is the home of the OpenPeagsus CIMOM, supported by multiple
vendors.

http://www.dmtf.org/standards/wbem/ is about the WBEM protocol. Also the
tutorial is good: http://www.wbemsolutions.com/tutorials/CIM/wbem.html

http://cimple.org/ tries to make writing providers easy.
