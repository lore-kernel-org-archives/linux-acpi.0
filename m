From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Syntax errors in SSDT1 table of HP 2510p laptop
Date: Tue, 07 Oct 2008 13:33:06 +0800
Message-ID: <1223357586.22227.2.camel@minggr.sh.intel.com>
References: <3515468CA27A0F49917112E2ECF61E2108A535697F@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7428 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbYJGFew (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Oct 2008 01:34:52 -0400
In-Reply-To: <3515468CA27A0F49917112E2ECF61E2108A535697F@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: elendil@planet.nl
Cc: linux-acpi <linux-acpi@vger.kernel.org>


> Hi,
> 
> I'm having problems with resume from suspend with this laptop. A lot of
> the time it resumes perfectly, but sometimes it fails early.
> 
> During good resumes I see the following in my log:
> ACPI Exception (exoparg2-0444): AE_AML_PACKAGE_LIMIT,
>    Index (000000005) is beyond end of object [20080609]
> ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.C2C3]
>    (Node ffff88007e335e80), AE_AML_PACKAGE_LIMIT
> ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.C003.C0F6.C3F3._STM]
>    (Node ffff88007e33bdc0), AE_AML_PACKAGE_LIMIT
> ata1: ACPI set timing mode failed (status=0x300d)
> 
> I have disassembled the ACPI tables using 'iasl' and found five obvious
> syntax errors in the SSDT1 table (dump attached), of which one is in the
> _GTM and two are in the _STM method. So that looks like an obvious cause.
> I'm wondering if this could explain the resume problems.
> 
> If you cannot help me I'd appreciate some suggestions where to take this.
> 

Could you attach the DSDT table?

Lin Ming



