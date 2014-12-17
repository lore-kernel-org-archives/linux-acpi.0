From: Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH 3/3] acpi:lpss:Refine lpss codes to fit acpi soc.
Date: Wed, 17 Dec 2014 17:26:37 +0800
Message-ID: <1418808397.2582.34.camel@kxue-X58A-UD3R>
References: <1418267151-5650-1-git-send-email-Ken.Xue@amd.com>
	 <CAHp75VfoMs-A-6UQurcNsNOCcpgtGL9BjhEPK6j9CET+v=CgGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfoMs-A-6UQurcNsNOCcpgtGL9BjhEPK6j9CET+v=CgGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2014-12-16 at 12:27 +0200, Andy Shevchenko wrote:
> On Thu, Dec 11, 2014 at 5:05 AM, Ken Xue <Ken.Xue@amd.com> wrote:
> 
> Make a commit message not empty.
> 
[ken]got it.

> > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> > ---
> >  drivers/acpi/acpi_lpss.c | 566 ++++++++++++++++++-----------------------------
> >  1 file changed, 221 insertions(+), 345 deletions(-)
> >
> > -static int acpi_lpss_platform_notify(struct notifier_block *nb,
> > -                                    unsigned long action, void *data)
> 
> Could it be just a part of this file? It seems for me that AMD doesn't
> have anything specific which requires to have a dedicated power
> domain. Am I wrong?
> 
[Ken] AMD does not have any specific PM domain now. But i believe it is
a good and necessary feature for low power management. and AMD will have
similar HW design. so, can you share a reason to keep it as a part of
this file?
