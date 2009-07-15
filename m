From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2/8] introduce the device async action mechanism
Date: Wed, 15 Jul 2009 06:00:06 -0700
Message-ID: <20090715060006.71c2e2b6@infradead.org>
References: <1247643516.26272.77.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754661AbZGOM6j@vger.kernel.org>
In-Reply-To: <1247643516.26272.77.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 15 Jul 2009 15:38:36 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> Introduce the device async action mechanism.
> 
> In order to speed up Linux suspend/resume/shutdown process,
> we introduce the device async action mechanism that allow devices
> to suspend/resume/shutdown asynchronously.
> 
> The basic idea is that,
> if the suspend/resume/shutdown process of a device set,
> including a root device and its child devices, are independent of
> other devices, we create an async domain for this device set,
> and make them suspend/resume/shutdown asynchronously.

Hi,

I have some concerns about having an async domain per device(group)
rather than having one async domain for all of this, I would
strongly suggest going to one global domain, so that it becomes
more practical to just wait for all async actions like this...
which you need to do during suspend for sure.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
