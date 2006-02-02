From: Simon Waters <simon@technocool.net>
Subject: Getting started: Acer Travelmate 200DX and Debian Sid
Date: Thu, 02 Feb 2006 22:25:37 +0000
Message-ID: <43E286E1.7010807@technocool.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h3.zynet2.co.uk ([212.24.80.3]:23768 "EHLO mail.technocool.net")
	by vger.kernel.org with ESMTP id S932354AbWBBWZi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 17:25:38 -0500
Received: from [10.254.239.1] (84-45-158-52.no-dns-yet.enta.net [84.45.158.52])
	by mail.technocool.net (Postfix) with ESMTP id 1825C189B0
	for <linux-acpi@vger.kernel.org>; Thu,  2 Feb 2006 22:25:38 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

My trusty, if rather old laptop, developed a problem with recent Debian
Sid stock kernels, which doesn't occur if I pass the newer kernels the
option "acpi = off".

http://bugzilla.kernel.org/show_bug.cgi?id=5938

Looking at the dsdt, it appears to have a selection of the normal
errors, and I've made a stab at fixing them, and now iasl doesn't report
any errors, and even the remaining warnings don't look too bad to my
untutored eye.

Is there a lazy way for someone who prefers Debian stock kernels to
update the ACPI table without building a new kernel? Otherwise I'll
brave the initrd method described in the Gentoo forums.

Anyone guess if fixing the "obvious" errors in the DSDT is likely to
help with this issue?

Is there a guide to testing a new DSDT, or comparitive testing, as at
this point my interest is proving it is a hardware specific thing (i.e.
fixing the DSDT fixes the problems), but presumably if it works others
will want to know the fixes are properly tested.

Is it likely that future kernels will include a customer DSDT feature by
default, as it seems a lot of laptops need this sort of tender loving care?
