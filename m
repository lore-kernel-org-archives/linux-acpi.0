From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving
 this functionality
Date: Thu, 27 Nov 2008 00:19:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
References: <200811081637.45099.arvidjaar@mail.ru>
 <20081115184900.GA10685@srcf.ucam.org>
 <20081116125114.GB29981@khazad-dum.debian.net>
 <200811161544.56367.trenn@suse.de>
 <20081117020754.GC22260@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:63959 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYK0FUF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 00:20:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ004S285CA994@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 26 Nov 2008 23:20:01 -0600 (CST)
In-reply-to: <20081117020754.GC22260@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, rpurdie@rpsys.net


I'm running FC10 on my toshiba, and pressing the hot-keys
gives me 8 levels, so somehow Fedora chooses the toshiba
levels instead of the ACPI video levels.  I too would view it
as a regression if this went down to 3 levels, even if it
is working by pure luck today.  Unfortunately, Andrey
is using a distro or window system that is less lucky?:-)

I like Henrique's suggestion of having the drivers register
a quality with the backlight sub-system and somehow having
the highest quality driver win.  In the case of a tie,
however, I'd want the ACPI video driver to win:-)

cheers,
-Len



