From: tim+vger.kernel.org@coote.org
Subject: toshiba_acpi degeneration
Date: Sat, 28 Jul 2007 11:00:29 +0100
Message-ID: <20070728100029.GB1512@fw.coote.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [213.232.80.169] ([213.232.80.169]:25497 "EHLO mail.coote.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbXG1Kcn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Jul 2007 06:32:43 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hullo
Pls point me somewhere else if this is the wrong list for this posting - I've tried to find a more appropriate place,
but cannot.

Toshiba laptops have a silly switch that needs to be flipped to enable bluetooth on them. Prior to acpi, Jonathan
Buzzard wrote a driver to enable access to this switch through /dev/toshiba. Unfortunately, the ACPI driver was 
incompatible with that code, so you could either have bluetooth or ACPI. On 2005-06-12 14:12:49, John Belmonte posted
his plans for getting toshib_acpi to support access to the toshiba switch. There have been several patches that
didn't make the kernel (unsurprisingly) as they put bluetooth drivers directly into toshiba_acpi,  and JB has
provided a series of patches to his original toshiba_acpi to enable direct access to the toshiba switch.

While toshiba_acpi was reasonably stable, it was practical to patch a stock kernel, either from JB's patches or
one of the bluetooth changes.  However, recently, there's been more activity on toshiba_acpi and the patches
don't keep up.

This leads me to the question: "How do I get bluetooth enabled on Toshiba laptops"?

Is it code that belongs in toshiba_acpi - and if not, where does it belong? In either case how do I get it in?

If nothing else, I'm intrigued how such a decision is made.

Sorry for wasting bandwidth if this is off-topic, but pls point me to where it would be on-topic.

cheers

Tim
