From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] [PATCH 2/2] ACPI: introduce ACPI ALS device driver
Date: Wed, 23 Sep 2009 09:11:27 +0100
Message-ID: <4AB9D82F.3030706@cam.ac.uk>
References: <1253590777.15763.22.camel@rzhang-dt>	 <4AB8C945.8050309@cam.ac.uk> <1253669192.15763.39.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754387AbZIWILG@vger.kernel.org>
In-Reply-To: <1253669192.15763.39.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

>> Are there any plausible race conditions associated with doing the allocation this way?
> 
> well, theoretically, yes.
> simultaneous add calls may happen in hotplug case, but I don't think an
> ACPI ALS device supports hotplug.
That would make that point irrelevant!

Thinking further on this. What happens on a box that for some reason repeatedly inserts and
removes this module?

This is the sort of problem idr's are meant to overcome.  They will cost you a bit
in terms of complexity though.
