From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [PATCH] acpi: acpica: add acpi status check prior walking
 through namespace
Date: Thu, 14 Dec 2017 01:36:00 -0800
Message-ID: <20171214093600.GB10734@localhost.localdomain>
References: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1513094360-1414-2-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FBD84@ORSMSX110.amr.corp.intel.com>
 <20171213145201.GA6692@localhost.localdomain>
 <CAJZ5v0iTzJ-=8SWcS6Hu1rP4d-EeOHz2yDjTPMAq8BdW8smSPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com ([104.47.32.66]:52640
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbdLNJgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 04:36:05 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iTzJ-=8SWcS6Hu1rP4d-EeOHz2yDjTPMAq8BdW8smSPg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vadim.lomovtsev@cavium.com" <vadim.lomovtsev@cavium.com>, "Schmauss, Erik" <erik.schmauss@intel.com>

On Wed, Dec 13, 2017 at 05:48:49PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2017 at 3:52 PM, Vadim Lomovtsev
> <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> > On Tue, Dec 12, 2017 at 09:52:21PM +0000, Moore, Robert wrote:
> >> Another way to look at this is that the kernel should not be calling ACPI interfaces if ACPI is disabled.
> >
> > Yes, I agree. So in this case the ltp_acpi test case has to be updated with such checking
> > before calling ACPI interfaces. However, it seems that such calls was put there intentionally,
> > without ACPI state check, as part of kernel testing strategy.
> 
> Not really.

Ok, see your point.
Thank you for your time.

WBR,
Vadim

> 
> Thanks,
> Rafael
