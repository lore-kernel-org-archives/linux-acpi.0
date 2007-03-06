From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Tue, 6 Mar 2007 16:10:02 +0100
Message-ID: <20070306161002.2a7d5c74.khali@linux-fr.org>
References: <20070228213803.GA4877@ucw.cz>
	<20070302141840.GA3441@srcf.ucam.org>
	<20070302220454.a0c66d04.khali@linux-fr.org>
	<20070302211251.GA10035@srcf.ucam.org>
	<20070303105316.d51e032d.khali@linux-fr.org>
	<4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
	<20070303155048.GA22755@srcf.ucam.org>
	<45E9AB8B.1070804@assembler.cz>
	<45EB01E8.5080003@assembler.cz>
	<20070305221635.8b20eab5.khali@linux-fr.org>
	<4dfa50520703051335j34e7d92bl982705adcfd8b1d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:1216 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965921AbXCFPKv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 10:10:51 -0500
In-Reply-To: <4dfa50520703051335j34e7d92bl982705adcfd8b1d5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Hubbard <david.c.hubbard@gmail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Ebbert <cebbert@redhat.com>, Chuck@atrpms.net, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Machek <pavel@ucw.cz>, Pavel@atrpms.net, lm-sensors@lm-sensors.org

Hi David,

On Mon, 5 Mar 2007 13:35:20 -0800, David Hubbard wrote:
> > 2* It seems to incur a signficant performance penalty.
> > ____request_resource isn't cheap as far as I know. And in the
> > absence of conflict, you are even allocating and releasing the resource
> > on _each_ I/O operation, which certainly isn't cheap either. Again, it
> > is not a blocker point, after all this is a workaround for an improper
> > behavior of the acpi subsystem, this performance penalty is the price to
> > pay. But there is also a performance penalty for legitimate I/O access,
> > which worries me more.
> 
> I thought Rudolf's patch allocated the resource in the driver
> (w83627ehf) and ACPI contacted the driver when it could not allocate
> the resource. Since ACPI never *really* wants to allocate the
> resource, is there a fast-path check it could do? This would help
> performance.

Alas, I don't think it can work safely. If ACPI doesn't actually
allocate the resource, there is a risk that another driver does so
between the conflict check and the I/O access. I believe this is the
reason why Rudolf used ____request_resource and not __check_region.

> I like the virtualized driver method (if it wasn't obvious!) but the
> global AML lock works also. It will be interesting to see profiling of
> both solutions.

In fact Rudolf's solution is nice for LPC chips, however I don't think
it can work with SMBus chips. It might intercept the accesses to the
SMBus master and be able to emulate it, even though this will be more
complex that the W83627EHF case, and I'm not sure about the PCI config
space. But ultimately we need to emulate all the chips behind the
SMBus, too. The drivers for these chips won't know if they are accessed
for real of through the emulation layer, so there is no way they'll
remember states, while they might have to (e.g. the W83781D has a bank
register too.)

The AML lock approach, OTOH, should work fine in all cases as long as
the context doesn't need to be remembered across AML "sections".

-- 
Jean Delvare
