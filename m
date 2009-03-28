From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 12:00:09 +0000
Message-ID: <20090328120008.GA22470@srcf.ucam.org>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain> <20090328013832.GA4778@srcf.ucam.org> <20090328083315.GF9057@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39498 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbZC1MAU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 08:00:20 -0400
Content-Disposition: inline
In-Reply-To: <20090328083315.GF9057@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Len Brown <lenb@kernel.org>, sony-vaio-z-series@lists.launchpad.net, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sat, Mar 28, 2009 at 09:33:15AM +0100, Norbert Preining wrote:

> I am testing that, but we are far from having a working thingy,
> currently on the sony z11 the nvidia (the second, the speed card) is not
> working without acpi/dsdt tricks (but Matthias might correct me).

The short version is that you're not going to get support for the 
external chip until nouveau is able to cold boot it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
