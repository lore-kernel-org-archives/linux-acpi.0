From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 7/7] Who controls brightness functionality: vendor
	specific or generic video driver
Date: Wed, 16 Apr 2008 21:08:35 +0200
Message-ID: <1208372915.1784.356.camel@queen.suse.de>
References: <1208372572.1784.352.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45019 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbYDPTIg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 15:08:36 -0400
In-Reply-To: <1208372572.1784.352.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

On Wed, 2008-04-16 at 21:02 +0200, Thomas Renninger wrote:
> Who controls brightness functionality: vendor specific or generic video driver
> 
> Depending on the capablity of ACPI graphics devices and whether they implement
> all necessary functions so that the generic ACPI video driver can control
> them, decide at driver load time whether a vendor specific device driver or
> the ACPI video driver should control the brighntess functionality.

This probably clashes with other patches.
I also forgot the eepc driver (and others?) which might also interfere
with the video driver?

Please review and if you like it tell me how this could get integrated
in the easiest way...

   Thomas

