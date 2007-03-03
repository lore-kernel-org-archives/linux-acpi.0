From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Sat, 3 Mar 2007 15:50:49 +0000
Message-ID: <20070303155048.GA22755@srcf.ucam.org>
References: <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org> <20070302141840.GA3441@srcf.ucam.org> <20070302220454.a0c66d04.khali@linux-fr.org> <20070302211251.GA10035@srcf.ucam.org> <20070303105316.d51e032d.khali@linux-fr.org> <4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:37462 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030320AbXCCPvP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Mar 2007 10:51:15 -0500
Content-Disposition: inline
In-Reply-To: <4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Hubbard <david.c.hubbard@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

On Sat, Mar 03, 2007 at 08:47:21AM -0700, David Hubbard wrote:

> For I/O and memory that ACPI accesses and has not reserved, the AML
> interpreter could allocate at run-time.

Not ideal. ACPI's already fiddling with ranges that have been reserved 
by other drivers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
