From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Remove the use of CONFIG_ACPI_HOTPLUG_MEMORY_MODULE
Date: Thu, 20 Jun 2013 01:19:21 +0200
Message-ID: <5242333.nvhyS5L0VS@vostro.rjw.lan>
References: <1371589605-15638-1-git-send-email-toshi.kani@hp.com> <51C13703.8040909@jp.fujitsu.com> <1371653237.22206.12.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371653237.22206.12.camel@misato.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 19, 2013 08:47:17 AM Toshi Kani wrote:
> On Wed, 2013-06-19 at 13:43 +0900, Yasuaki Ishimatsu wrote:
> > 2013/06/19 6:06, Toshi Kani wrote:
> > > config ACPI_HOTPLUG_MEMORY has been changed to bool (y/n), and
> > > its module option is no longer valid.  So, remove the use of
> > > CONFIG_ACPI_HOTPLUG_MEMORY_MODULE.
> > > 
> > > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > > ---
> > >   include/linux/acpi.h |    3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > index 17b5b59..353ba25 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -352,8 +352,7 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
> > >   
> > >   /* Enable _OST when all relevant hotplug operations are enabled */
> > >   #if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
> > > -	(defined(CONFIG_ACPI_HOTPLUG_MEMORY) ||		\
> > > -	 defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) &&	\
> > > +	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
> > >   	defined(CONFIG_ACPI_CONTAINER)
> > >   #define ACPI_HOTPLUG_OST
> > >   #endif
> > > --
> > Good catch!!
> > 
> > Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> Thanks Yasuaki!

Queued up for 3.11.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
