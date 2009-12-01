From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.32-rc8 - T500 fails to suspend to RAM
Date: Tue, 1 Dec 2009 22:46:58 +0100
Message-ID: <200912012246.58383.rjw@sisk.pl>
References: <4B151FE2.3090807@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46689 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbZLAVqM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Dec 2009 16:46:12 -0500
In-Reply-To: <4B151FE2.3090807@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lior Dotan <liodot@gmail.com>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tuesday 01 December 2009, Lior Dotan wrote:
> Hi,
> 
> Ever since I've upgraded to rc8, my T500 fails to suspend to RAM for the
> second time. Suspending for the first time works ok but when I resume and
> later try to suspend again the screen gets blank and the moon LED blinks
> forever. rc6 & rc7 as well as 2.6.31 worked great with out a problem.

Well, I don't see any particular change that might cause the symptoms you
describe between -rc7 and -rc8.  If this is 100% reproducible, I guess
bisecting is the only option at the moment.

Thanks,
Rafael
