From: Matthew Garrett <mjg@redhat.com>
Subject: Re: regression since 2.6.36: backlight in sony-laptop not working
Date: Fri, 12 Nov 2010 03:57:32 +0000
Message-ID: <20101112035732.GB7574@srcf.ucam.org>
References: <20101104142915.GC7650@gamma.logic.tuwien.ac.at> <20101110035833.GB3029@kamineko.org> <20101111235000.GA6651@gamma.logic.tuwien.ac.at> <20101112034423.GA7407@srcf.ucam.org> <20101112035027.GD26742@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54157 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab0KLD5h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Nov 2010 22:57:37 -0500
Content-Disposition: inline
In-Reply-To: <20101112035027.GD26742@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Fri, Nov 12, 2010 at 12:50:27PM +0900, Norbert Preining wrote:
> THen the problem is simply that the acpi events are not coming through
> when pressing the respective keys.

Then yes, that's probably related to sony-laptop. If you run evtest 
against the /dev/input/event device that corresponds to sony-laptop, 
what events do you get when you hit the brightness keys?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
