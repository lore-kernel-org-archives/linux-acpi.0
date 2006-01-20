From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Gentoo on Acer Aspire 3502WLCi with bugged DSDT (Phoenix BIOS)
Date: Fri, 20 Jan 2006 00:57:49 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF2@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:10394 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030330AbWATF7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 00:59:36 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio <fabio.venturi@studenti.unipr.it>, linux-acpi@vger.kernel.org

Note that in most cases when Linux doesn't digest the DSDT
that the vendor shipped, it is a Linux bug that needs to
be filed and fixed.  We're not taking the moral high ground here,
in most cases we're trying to be resilient to the bugs
in DSDTs that Windows allows.

That said, if you want to run a custom DSDT and you're
building a custom kernel for the box, then simply
use the CONFIG_ACPI_CUSTOM_DSDT option.

cheers,
-Len
