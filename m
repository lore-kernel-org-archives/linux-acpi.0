From: Eric Cooper <ecc@cmu.edu>
Subject: ACPI module for Asus Eee PC
Date: Sat, 26 Jan 2008 09:48:24 -0500
Message-ID: <20080126144824.GD16281@stratocaster.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from CHOKECHERRY.SRV.CS.CMU.EDU ([128.2.185.41]:55399 "EHLO
	chokecherry.srv.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727AbYAZO6c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Jan 2008 09:58:32 -0500
Received: from stratocaster.home (c-24-3-147-134.hsd1.pa.comcast.net [24.3.147.134])
	(authenticated bits=0)
	by chokecherry.srv.cs.cmu.edu (8.13.6/8.13.6) with ESMTP id m0QEmPch029728
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 26 Jan 2008 09:48:25 -0500 (EST)
Received: from ecc by stratocaster.home with local (Exim 4.68)
	(envelope-from <ecc@cmu.edu>)
	id 1JImKW-0004T1-T4
	for linux-acpi@vger.kernel.org; Sat, 26 Jan 2008 09:48:24 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I happened to look at the patched asus_acpi.c module that was posted
by Asus for the Eee PC and noticed that it's 75% dead code -- the Eee
PC support is just stuck on at the end.  And of course it conflicts
with the real asus_acpi.ko in any kernel package.

So I cleaned it up, renamed it eeepc_acpi, and packaged it as a
separate out-of-kernel Debian package that can be built with
module-assistant.

Here's the wc comparison:
 1907  6180 50911 asus_acpi.c
  453  1434 13037 eeepc_acpi.c

When I proposed to add this package to Debian, it was also suggested
that I contact this list to see about including it in the mainline.
If I can help with that in any way, please let me know.  I'm not
subscribed, so please CC me on any replies.

The source is at http://www.cs.cmu.edu/~ecc/eeepc-acpi_1.0.tar.gz,
and the Debian package is at
    http://www.cs.cmu.edu/~ecc/eeepc-acpi_1.0-1.{dsc,diff.gz}

Cheers,
Eric

-- 
Eric Cooper             e c c @ c m u . e d u
