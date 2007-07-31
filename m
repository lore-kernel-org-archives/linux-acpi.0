From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [-mm] ACPI: use GFP_KERNEL instead of GFP_ATOMIC
Date: Tue, 31 Jul 2007 15:33:57 +0200
Message-ID: <200707311533.57599.rjw@sisk.pl>
References: <1185922802.3993.4.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57973 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763316AbXGaNZN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jul 2007 09:25:13 -0400
In-Reply-To: <1185922802.3993.4.camel@rzhang-asus.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Wednesday, 1 August 2007 01:00, Zhang Rui wrote:
> Use GFP_KERNEL instead of GFP_ATOMIC.

Hmm, if any of these things can happen during a suspend, GFP_NOFS would be
safer (or even GFP_NOIO).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
