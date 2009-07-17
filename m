From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2/8] introduce the device async action mechanism
Date: Thu, 16 Jul 2009 21:31:06 -0700
Message-ID: <20090716213106.32d61d53@infradead.org>
References: <1247643516.26272.77.camel@rzhang-dt>
	<20090715060006.71c2e2b6@infradead.org>
	<1247709910.26272.159.camel@rzhang-dt>
	<200907170312.00006.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752157AbZGQE3h@vger.kernel.org>
In-Reply-To: <200907170312.00006.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 17 Jul 2009 03:11:59 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> 
> Well, first, I'm not really sure that using the async _boot_
> infrastructure for that is a good choice. 

the async function call mechanism is for more than boot.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
