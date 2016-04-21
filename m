From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: Re: [PATCH] ACPI/SRAT: fix SRAT order parsing when both LAPIC and X2APIC present
Date: Thu, 21 Apr 2016 11:28:59 +0200
Message-ID: <1461230940-5037-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <5650804.Bpcz1v4kAC@vostro.rjw.lan>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10640 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbcDUJ3H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Apr 2016 05:29:07 -0400
In-Reply-To: <5650804.Bpcz1v4kAC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, mingo@redhat.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukasz.anaczkowski@intel.com

From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
Sent: Thursday, April 21, 2016 2:08 AM
> The changelog describes the problem (good), but it doesn't say anything
> about the mitigation (not good).  You should say something about what the
> patch does to address the issue, like "To address that problem, do X".

Thanks, Rafael. Sending v2 of the patch with extended commit message.

> Looking at the code, the idea is to check each entry against both LAPIC and
> X2APIC in table order so as to cause them to be mapped in that order too, right?

Yes, that is correct.

Thanks,
Lukasz

