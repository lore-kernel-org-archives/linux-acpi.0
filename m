From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Wed, 29 Apr 2009 14:43:12 -0700
Message-ID: <20090429214312.GX7917@plum>
References: <20090415225348.GW8311@plum> <200904201113.31371.trenn@suse.de> <20090420104529.GB6670@elte.hu> <200904291519.29683.trenn@suse.de>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:45523 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356AbZD2VnP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2009 17:43:15 -0400
Content-Disposition: inline
In-Reply-To: <200904291519.29683.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Apr 29, 2009 at 03:19:28PM +0200, Thomas Renninger wrote:

> Ingo, did you do a BIOS update in between?
> The DSDT and SSDTs you added do not contain a _PPC function.
> These ACPI tables definitely do not suffer from an initial _PPC
> evaluation.

P-state tables are probably loaded from separate SSDT tables "CPU0IST" and
"CPU1IST".  You can download 'em with something like this:

# dmesg | grep IST
ACPI: SSDT BFD30566, 01FB (r1  PmRef    CPU0IST   3000 INTL 20030224)
           ^addr     ^length

# acpidump --addr 0xBFD30566 --length 0x1FB > cpu0ist
# iasl -d cpu0ist

Then paste cpu0ist.dsl somewhere.

--D
