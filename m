From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend-to-ram/disk signal
Date: Tue, 27 Nov 2007 00:36:21 +0100
Message-ID: <200711270036.21884.rjw@sisk.pl>
References: <474B4B35.6030800@tipisoft.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40857 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757509AbXKZXSg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2007 18:18:36 -0500
In-Reply-To: <474B4B35.6030800@tipisoft.dk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pascal d'Hermilly <pascal@tipisoft.dk>
Cc: linux-acpi@vger.kernel.org

On Monday, 26 of November 2007, Pascal d'Hermilly wrote:
> When the computer suspends and comes back does it send a signal to the 
> running applications?

No, it doesn't.  Applications aren't supposed to notice the suspend.

> Specifically I would like to use it so a IM client will reconnect to the 
> server instead of saying there is a timeout.
> 
> Hope someone can help me out with a tip.

Your distribution surely uses some scripts that activate the kernel's suspend
code.  You can modify these scripts to notify your application.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
