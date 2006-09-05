From: Ben B <kernel@bb.cactii.net>
Subject: Re: Hang on S3 resume with Acer TravelMate 222X
Date: Tue, 5 Sep 2006 08:16:08 +0200
Message-ID: <20060905061608.GA16903@cactii.net>
References: <1157066944.1826.62.camel@timaeus.sophrosune.org> <1157424745.19942.2.camel@timaeus.sophrosune.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from us.cactii.net ([66.160.141.151]:59656 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S965174AbWIEGQr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 02:16:47 -0400
Content-Disposition: inline
In-Reply-To: <1157424745.19942.2.camel@timaeus.sophrosune.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Todd Pytel <tppytel@sophrosune.org>
Cc: linux-acpi@vger.kernel.org

Todd Pytel <tppytel@sophrosune.org> uttered the following thing:
> Please? Anybody? Just some Google fodder or pointers on how to generate
> better debugging information for the list would be greatly appreciated.

Try unloading various modules before suspend. On many machines, at least
the usb host drivers need to be unloaded.

Video's another possibility. Look at vbetool, it might be able to
restore video and get things on track again.

Also, do your suspend from a shell script, and have this script log
debugging info after resume (remembering to sync in case you have to
hard boot).

Ben

