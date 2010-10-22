From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Make Embedded Controller command timeout delay configurable
Date: Sat, 23 Oct 2010 00:46:05 +0200
Message-ID: <201010230046.06637.trenn@suse.de>
References: <201010211824.57893.trenn@suse.de> <alpine.LFD.2.00.1010220122090.7016@localhost.localdomain> <201010222322.00618.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59337 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab0JVWqG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Oct 2010 18:46:06 -0400
In-Reply-To: <201010222322.00618.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Friday 22 October 2010 11:22:00 pm Rafael J. Wysocki wrote:
> On Friday, October 22, 2010, Len Brown wrote:
> > applied
> 
> OK
> 
> What if I do ec_delay=0 ?
Same as with quite some other boot params:
Your machine won't boot.

Why should this be a problem?

     Thomas
