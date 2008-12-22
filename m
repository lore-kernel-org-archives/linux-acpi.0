From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.28-rc9 regression: system fails to suspend
Date: Mon, 22 Dec 2008 21:22:51 +0100
Message-ID: <200812222122.52019.rjw@sisk.pl>
References: <200812220904.28780.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55628 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbYLVUWn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Dec 2008 15:22:43 -0500
In-Reply-To: <200812220904.28780.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, 22 of December 2008, Andrey Borzenkov wrote:
> I will bisect as time permits, but may be it rings the bell for someone. 
> 2.6.28-rc7 is OK; rc9 switches console off and never goes in suspend. 
> Power remains on, keyboard is non-functional and the only way out is 
> power button. I have not tried rc8.
> 
> If somebody has soggestions what to (try to) revert, it would be great 
> and save quite a bit of time for bisecting.

You can have a look at the list of regressions at
http://bugzilla.kernel.org/showdependencytree.cgi?id=11808
find the fixes applied between .28-rc7 and .28-rc9 and check those commits.

Thanks,
Rafael
