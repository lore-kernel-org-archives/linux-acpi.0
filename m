From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.31] NFS + suspend to ram hang...
Date: Thu, 24 Sep 2009 19:59:39 +0200
Message-ID: <200909241959.39497.rjw@sisk.pl>
References: <6278d2220909231545x217e1100k496bbdd44d0704de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48208 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbZIXR6V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Sep 2009 13:58:21 -0400
In-Reply-To: <6278d2220909231545x217e1100k496bbdd44d0704de@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Thursday 24 September 2009, Daniel J Blueman wrote:
> Without the NFS4 homedir mount, suspend to ram works perfectly. With
> NFS4 homedir, suspend is started, but doesn't complete. Invoking
> kernel crashdump, all messages and backtrace looks entirely expected
> [1].
> 
> Anyone else find the same? Expected to work or not? What information
> would help with this?

Can you try this with 2.6.30?

Best,
Rafael
