From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 06/10] fujitsu-laptop: use .notify method instead of
Date: Tue, 31 Mar 2009 16:15:20 +0930 (CST)
Message-ID: <200903310645.n2V6jKu8014279@turbo.physics.adelaide.edu.au>
References: <20090330174839.20905.63966.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:42324 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753468AbZCaHCz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Mar 2009 03:02:55 -0400
In-Reply-To: <20090330174839.20905.63966.stgit@bob.kio> from "Bjorn Helgaas" at Mar 30, 2009 11:48:39 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

> This patch adds a .notify() method.  The presence of .notify() causes
> Linux/ACPI to manage event handlers and notify handlers on our behalf,
> so we don't have to install and remove them ourselves.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> CC: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> CC: Tony Vroon <tony@linx.net>

I will check this out overnight and comment tomorrow.

Regards
  jonathan
