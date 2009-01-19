From: Norbert Preining <preining@logic.at>
Subject: Re: Sony backlight regression from 2.6.28 to 29-rc
Date: Mon, 19 Jan 2009 15:19:41 +0100
Message-ID: <20090119141941.GA28372@gamma.logic.tuwien.ac.at>
References: <20090119081423.GA25297@gamma.logic.tuwien.ac.at> <20090119125808.GB21586@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:43069 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759303AbZASOTo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jan 2009 09:19:44 -0500
Content-Disposition: inline
In-Reply-To: <20090119125808.GB21586@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Mo, 19 Jan 2009, Mattia Dongili wrote:
> You probably required and still require
>   [sony-laptop] detect the ICH9 chipset as Type3
> and
>   [sony-laptop] call the extra enable function for SNC on Vaio Z
> at least.

I have that one, I have all from the series
	[PATCH 0/7] sony-laptop for acpi-test
plus the one from Ishikawa-san fixing the spic_types[4] ->
spic_types[2].

Still no success.

> what were you using before? the acpi_video0 entry or the sony-laptop
> one?

Both, and both were working.

> well, there as been no change to the sony-laptop driver from 2.6.28 to
> .29-rc2 except for moving it to drivers/platform/x86.

Hmmm, actually I had 2.6.28-rc9, but I guess there was no important
difference to 2.6.28-final.

Strange.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
QUEENZIEBURN (n.)
Something that happens when people make it up after an agglethorpe
(q.v.)
			--- Douglas Adams, The Meaning of Liff
