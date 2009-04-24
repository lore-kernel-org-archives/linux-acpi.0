From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: sony-laptop: support for turning off and on the builtin cd/dvd
Date: Fri, 24 Apr 2009 21:25:00 +0100
Message-ID: <20090424202500.GB17983@srcf.ucam.org>
References: <20090424200946.GB16494@gamma.logic.tuwien.ac.at> <20090424201514.GA17983@srcf.ucam.org> <20090424201926.GB18393@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45986 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbZDXUZJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 16:25:09 -0400
Content-Disposition: inline
In-Reply-To: <20090424201926.GB18393@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Fri, Apr 24, 2009 at 10:19:26PM +0200, Norbert Preining wrote:
> On Fr, 24 Apr 2009, Matthew Garrett wrote:
> > I don't believe that we have any idea how to on the newer machines.
> 
> Blind shooting at some of the ACPI methods, would that help? (loading
> sony_laptop with debug=1 etc)

It's certainly a possibility. One of the SN methods may do something 
useful here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
