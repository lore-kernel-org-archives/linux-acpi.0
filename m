From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI/SRAT: fix SRAT order parsing when both LAPIC and X2APIC present
Date: Wed, 27 Apr 2016 23:23:24 +0200
Message-ID: <32506564.fbJE22l67l@vostro.rjw.lan>
References: <5650804.Bpcz1v4kAC@vostro.rjw.lan> <1461230940-5037-1-git-send-email-lukasz.anaczkowski@intel.com> <1461230940-5037-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42752 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752286AbcD0VUX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Apr 2016 17:20:23 -0400
In-Reply-To: <1461230940-5037-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: len.brown@intel.com, mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, April 21, 2016 11:29:00 AM Lukasz Anaczkowski wrote:
> SRAT maps APIC ID to proximity domains ids (PXM). Mapping from PXM to
> NUMA node ids is based on order of entries in SRAT table.
> SRAT table has just LAPIC entires or mix of LAPIC and X2APIC entries.
> As long as there are only LAPIC entires, mapping from proximity domain
> id to NUMA node id is as assumed by BIOS. However, once APIC entries are
> mixed, X2APIC entries would be first mapped which causes unexpected NUMA
> node mapping.
> To fix that, change parsing to check each entry against both LAPIC and
> X2APIC so mapping is in the SRAT/PXM order.
> This is supplemental change to the fix made by d81056b5278 (thus
> "Fixes:" tag) and using same mechanism introduced by 9b3fedd (ACPI / tables:
> Add acpi_subtable_proc to ACPI table parsers).
> 
> Fixes: d81056b5278 (Handle apic/x2apic entries in MADT in correct order)
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

Applied, thanks!

