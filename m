From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/3] PM: Suspend and hibernate error paths fixes
Date: Sun, 4 Jul 2010 00:17:19 +0200
Message-ID: <201007040017.19084.rjw@sisk.pl>
References: <201007012356.44690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49082 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0GCWSl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Jul 2010 18:18:41 -0400
In-Reply-To: <201007012356.44690.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, July 01, 2010, Rafael J. Wysocki wrote:
> Hi,
> 
> The following three patches are intended to fix a few bugs spotted recently
> in the suspend/hibernation core code.
> 
> Since they are located in error paths, hopefully they have no chance to trigger
> to often. ;-)

So, I assume the lack of responses implies the lack of objections. :-)

Rafael
