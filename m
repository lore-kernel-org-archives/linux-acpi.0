From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Tue, 6 Mar 2007 16:26:34 +0100
Message-ID: <20070306162634.bcaaf0c7.khali@linux-fr.org>
References: <20070218183805.5a4fd813.khali@linux-fr.org>
	<20070228213803.GA4877@ucw.cz>
	<20070301152655.f232db64.khali@linux-fr.org>
	<20070302114023.GD2163@elf.ucw.cz>
	<20070302114747.GB1212@srcf.ucam.org>
	<20070302151055.d2665d66.khali@linux-fr.org>
	<20070302141840.GA3441@srcf.ucam.org>
	<20070302220454.a0c66d04.khali@linux-fr.org>
	<20070302211251.GA10035@srcf.ucam.org>
	<20070303105316.d51e032d.khali@linux-fr.org>
	<20070305222548.GA4946@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:1640 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965929AbXCFP12 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 10:27:28 -0500
In-Reply-To: <20070305222548.GA4946@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Pavel,

On Mon, 5 Mar 2007 22:25:48 +0000, Pavel Machek wrote:
> > Is there anything preventing us from doing such a walk and pre-allocate
> > all the I/O ranges? I am not familiar with the ACPI code at all, would
> > you possibly propose a patch doing that?
> 
> ACPI AML is probably turing-complete: I'm afraid you are trying to
> solve the halting problem (-> impossible).

Can you please translate this into something mere humans like myself
have a chance to understand?

Thanks,
-- 
Jean Delvare
