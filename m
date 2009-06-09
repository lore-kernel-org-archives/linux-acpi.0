From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
 Rearrange core suspend code)
Date: Tue, 9 Jun 2009 10:33:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906091032260.28447-100000@netrider.rowland.org>
References: <200906090925.18866.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:46395 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750995AbZFIOdK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 10:33:10 -0400
In-Reply-To: <200906090925.18866.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, 9 Jun 2009, Oliver Neukum wrote:

> But the problem here is STR or STD. How do you notify drivers that the BIOS
> has resumed their device instead of autoresume() being called? A driver
> has to know that its device has become active without its knowledge.

That would be a wonderful contradiction in terms.  :-)

Alan Stern

