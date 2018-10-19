From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/1] ACPI / scan: Create platform device for INT33FE ACPI nodes
Date: Fri, 19 Oct 2018 12:24:14 +0200
Message-ID: <2477276.ZfWzuKp1JK@aspire.rjw.lan>
References: <20181017085928.13406-1-hdegoede@redhat.com> <CAHp75VcxnGzKbOwEDu_MSKQ1D28=pESTVm+YSHQTjrMXUaKMoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcxnGzKbOwEDu_MSKQ1D28=pESTVm+YSHQTjrMXUaKMoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 17, 2018 1:39:54 PM CEST Andy Shevchenko wrote:
> On Wed, Oct 17, 2018 at 11:59 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Rafael, Andy,
> >
> > For the why and what of this patch see the (somewhat long) commit message.
> >
> > The single patch in this set both touches drivers/acpi/scan.c and
> > drivers/platform/x86/intel_cht_int33fe.c, this is done this way to avoid
> > regressions when bisecting.
> >
> > The main change here really is to ACPI change and intel_cht_int33fe.c is
> > modified to follow suit. Also I do not expect intel_cht_int33fe.c to see
> > much changes this cycle. As such I believe it would be best to merge this
> > patch through Rafael's tree (after review).
> >
> > Andy is that ok with you and we have your ack for this?
> 
> I love this patch!
> 
> Definitely,
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied, thanks!
