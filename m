From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 1/5 -v2] acpi, IO memory pre-mapping and atomic accessing
Date: Fri, 18 Dec 2009 19:11:44 +0100
Message-ID: <20091218181144.GB1470@ucw.cz>
References: <1260429413.15264.393.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37259 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbZLRSMK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 13:12:10 -0500
Content-Disposition: inline
In-Reply-To: <1260429413.15264.393.camel@yhuang-dev.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: lenb@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi!

> Some ACPI IO accessing need to be done in atomic context. For example,

Does it? Maybe better fix would be to make sure acpi interpretter
can't be ran from interrupt context -- just create threads for it...?

It would solve a lot of uglyness with acpi trying to guess if it can
sleep etc...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
