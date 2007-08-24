From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] sony-laptop: old Vaio models contain 2 IO port entries
Date: Fri, 24 Aug 2007 01:00:50 -0400
Message-ID: <200708240100.50208.lenb@kernel.org>
References: <11869032283795-git-send-email-malattia@linux.it> <1186903229276-git-send-email-malattia@linux.it> <20070813121042.GA15835@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49527 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbXHXFRs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 01:17:48 -0400
In-Reply-To: <20070813121042.GA15835@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

On Monday 13 August 2007 08:10, Mattia Dongili wrote:
> On Sun, Aug 12, 2007 at 04:20:28PM +0900, Mattia Dongili wrote:
> > Make the driver aware of this case and manage the existence of a
> > second separate IO port.
> 
> definitely too late for this now, sorry for the bad timing.
> Could you push it to acpi-test?

sure, the previous version of this was in acpi test on a 2.6.24 bound branch,
and i've refreshed it with this one.

1 and 2 in this series are in a 2.6.23-bound branch.

thanks,
Len

> would you want me to resentd two separate series?
> 
> cheers
