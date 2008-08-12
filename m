From: Matthew Garrett <mjg@redhat.com>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Tue, 12 Aug 2008 16:32:05 +0100
Message-ID: <20080812153205.GA19070@srcf.ucam.org>
References: <20080806090246.GA1572@elf.ucw.cz> <48A1779B.5020303@redhat.com> <20080812115530.GB8806@elf.ucw.cz> <200808121634.34634.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56566 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYHLPcT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 11:32:19 -0400
Content-Disposition: inline
In-Reply-To: <200808121634.34634.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Milan Broz <mbroz@redhat.com>, Andi Kleen <andi@firstfloor.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Tue, Aug 12, 2008 at 04:34:33PM +0200, Rafael J. Wysocki wrote:

> Pavel, can you check if the state of the fan(s) change while the thermal trip
> points are being passed?

Thinkpads don't expose fans as ACPI devices, so there's no active trip 
points.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
