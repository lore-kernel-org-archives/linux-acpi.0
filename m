From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI: Remove the use of
 CONFIG_ACPI_HOTPLUG_MEMORY_MODULE
Date: Wed, 19 Jun 2013 08:47:17 -0600
Message-ID: <1371653237.22206.12.camel@misato.fc.hp.com>
References: <1371589605-15638-1-git-send-email-toshi.kani@hp.com>
	 <51C13703.8040909@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:5440 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637Ab3FSOrj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2013 10:47:39 -0400
In-Reply-To: <51C13703.8040909@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2013-06-19 at 13:43 +0900, Yasuaki Ishimatsu wrote:
> 2013/06/19 6:06, Toshi Kani wrote:
> > config ACPI_HOTPLUG_MEMORY has been changed to bool (y/n), and
> > its module option is no longer valid.  So, remove the use of
> > CONFIG_ACPI_HOTPLUG_MEMORY_MODULE.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >   include/linux/acpi.h |    3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 17b5b59..353ba25 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -352,8 +352,7 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
> >   
> >   /* Enable _OST when all relevant hotplug operations are enabled */
> >   #if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
> > -	(defined(CONFIG_ACPI_HOTPLUG_MEMORY) ||		\
> > -	 defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) &&	\
> > +	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
> >   	defined(CONFIG_ACPI_CONTAINER)
> >   #define ACPI_HOTPLUG_OST
> >   #endif
> > --
> Good catch!!
> 
> Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks Yasuaki!
-Toshi


