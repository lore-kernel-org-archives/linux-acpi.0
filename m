From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ACPI: eliminate useless bay events
Date: Wed, 14 Mar 2007 11:25:42 -0700
Message-ID: <20070314112542.3d28f659.kristen.c.accardi@intel.com>
References: <20070306154046.942b0706.kristen.c.accardi@intel.com>
	<20070307021649.GA1448@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1789 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932446AbXCNS2g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Mar 2007 14:28:36 -0400
In-Reply-To: <20070307021649.GA1448@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Mar 2007 23:16:49 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Tue, 06 Mar 2007, Kristen Carlson Accardi wrote:
> > Eliminate bay events on resume if nothing has changed.
> 
> Are these *really* useless?  What if the *contents* of the bay changed?

Humm... good point.  I will play with this some more to solve the bug
I'm trying to fix a different way.

Please ignore the patch.

Kristen
