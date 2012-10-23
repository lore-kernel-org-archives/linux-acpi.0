From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: some potential doc fixes
Date: Tue, 23 Oct 2012 05:15:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210230512180.9789@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:47745 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab2JWJPo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Oct 2012 05:15:44 -0400
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([174.115.5.73]:34553 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1TQaaN-0001p5-8Z
	for linux-acpi@vger.kernel.org; Tue, 23 Oct 2012 05:15:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


  couple observations.  first, a number of the white paper links here:

https://lesswatts.org/documentation/

are broken.

  second, from the MAINTAINERS file:

ACPI
... snip ...
F:      drivers/acpi/
F:      drivers/pnp/pnpacpi/
F:      include/linux/acpi.h
F:      include/acpi/

  but a quick "find" shows:

$ find . -name acpi
./Documentation/acpi
./tools/power/acpi
./drivers/acpi
./include/acpi
./arch/x86/kernel/acpi
$

i would think, at the very least, that last directory should be
mentioned in the MAINTAINERS file, and perhaps the Documentation/ as
well.

  i will leave this in someone else's capable hands.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
