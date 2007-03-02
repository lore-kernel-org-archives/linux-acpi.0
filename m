From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Fri, 2 Mar 2007 22:41:55 +0100
Message-ID: <20070302224155.143b8643.khali@linux-fr.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<20070218183805.5a4fd813.khali@linux-fr.org>
	<20070228213803.GA4877@ucw.cz>
	<20070301152655.f232db64.khali@linux-fr.org>
	<20070302114023.GD2163@elf.ucw.cz>
	<20070302150313.198b6053.khali@linux-fr.org>
	<20070302145709.GA3710@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:3207 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030185AbXCBVoR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Mar 2007 16:44:17 -0500
In-Reply-To: <20070302145709.GA3710@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Matthew,

On Fri, 2 Mar 2007 14:57:09 +0000, Matthew Garrett wrote:
> How about this? It's informational only, but ought to result in 
> complaints whenever ACPI tries to touch something that other hardware 
> has reserved. We can't fail these accesses, but in theory we could 
> consider some sort of locking layer that made it possible to interact 
> anyway. I haven't even checked if this builds, but I think the concept 
> is reasonable.

I like the patch, after adding some casts to the printf args it
compiles fine. However you print warnings each time a resource has been
reserved... without checking if it hasn't been reserved by ACPI itself!
My machine looks like this:

1000-107f : 0000:00:1f.0
  1000-1003 : ACPI PM1a_EVT_BLK
  1004-1005 : ACPI PM1a_CNT_BLK
  1008-100b : ACPI PM_TMR
  1010-1015 : ACPI CPU throttle
  1020-1020 : ACPI PM2_CNT_BLK
  1028-102b : ACPI GPE0_BLK
  102c-102f : ACPI GPE1_BLK

Given that these ports were reserved by ACPI it is perfectly legitimate
that ACPI accesses it, so we must not print a warning in this case. We
need to exclude from the test the regions those "name" starts with
"ACPI", but I'm not sure how we can do that.

Thanks,
-- 
Jean Delvare
