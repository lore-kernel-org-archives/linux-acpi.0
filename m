From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Thu, 2 Jul 2009 12:15:38 +0200
Message-ID: <200907021215.39663.trenn@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <1246516045.3326.0.camel@minggr.sh.intel.com> <4911F71203A09E4D9981D27F9D8308582EA5E7E2@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54407 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbZGBKPh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jul 2009 06:15:37 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D8308582EA5E7E2@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thursday 02 July 2009 08:42:38 Moore, Robert wrote:
> Before we start extending the existing mechanisms, I think we need to really
> think about a better solution.
Yes, but we still need a fix for older stable kernels which are the ones in
production.

   Thomas
