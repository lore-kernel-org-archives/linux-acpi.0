From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
Date: Tue, 26 Jan 2016 08:31:39 +0000
Message-ID: <56A72EEB.5040205@arm.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
 <1453335459-3617-2-git-send-email-lho@apm.com>
 <CAPw-ZTnm5F3Kt+_J6HoNCYbx8R7JVkME5yA9V-hAwRtr8ge9ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPw-ZTnm5F3Kt+_J6HoNCYbx8R7JVkME5yA9V-hAwRtr8ge9ZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Doug Thompson <dougthompson-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Tomasz Nowicki <tomasz.nowicki-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-edac <linux-edac-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "patches-qTEPVZfXA3Y@public.gmane.org" <patches-qTEPVZfXA3Y@public.gmane.org>, Tuan Phan <tphan-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Loc,

On 25/01/16 21:23, Loc Ho wrote:
> Hi,
> 
> On Wed, Jan 20, 2016 at 4:17 PM, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org> wrote:
>>
>> The function acpi_gsi_to_irq must return 0 on success as the caller
>> ghes_probe expects an 0 for success. This change also matches x86
>> implementation.
>>
>> Signed-off-by: Tuan Phan <tphan-qTEPVZfXA3Y@public.gmane.org>
>> Signed-off-by: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
> 
> 
> Any issue with this version? If not, can this be pulled into 4.5?

How is that 4.5 material? Does it fix an observable bug or a regression
from a previous? If not, then this is probably to be postponed until
4.6, together with the code that makes use of it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
