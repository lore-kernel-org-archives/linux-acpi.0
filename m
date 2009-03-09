From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29-rc7 does not power off on halt
Date: Mon, 9 Mar 2009 22:22:18 +0100
Message-ID: <200903092222.18562.rjw@sisk.pl>
References: <87vdqishgp.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41161 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbZCIVWM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2009 17:22:12 -0400
In-Reply-To: <87vdqishgp.fsf@tac.ki.iif.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org

On Monday 09 March 2009, Ferenc Wagner wrote:
> Hi!
> 
> The current git kernel doesn't switch off power as the last step of
> system halt (-p) on our Atom systems.  Everything seems to be all
> right, just the power remains on.  Is this a known issue perhaps?

Not really.  Does it happen with 2.6.28 too?

Rafael
