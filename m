From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
Date: Fri, 10 Jan 2014 17:14:33 +0800
Message-ID: <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
References: <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
 <20140109162427.GF25897@redhat.com>
 <1389288265.1792.108.camel@misato.fc.hp.com>
 <20140109182310.GG25897@redhat.com>
 <1389292470.1792.109.camel@misato.fc.hp.com>
 <20140109212705.GC12111@redhat.com>
 <1389304583.1792.139.camel@misato.fc.hp.com>
 <20140110071124.GA6464@dhcp-16-105.nay.redhat.com>
 <52CFAA20.2010109@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52CFAA20.2010109-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yasuaki Ishimatsu <isimatu.yasuaki-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tangchen-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhangyanfei-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


 >In ns
> >object tree, they are not treated as hotplug memory.
> 
> wrong.
> They are treated as hotplug memory. But the memory cannot hot removed
> because the memory has kernel memory.
> 
> >Otherwise, any hotplug memory which is not reserved for 2nd kernel can
> >be parsed and need be added as hotplug memory, and add them into movable
> >zone.
> 
> wrong.
> The memory is allocated as normal zone and it is offline.

Hi,

Thanks for answering.

I am confused. Now the fact is in 1st kernel memory is reserved for
crashkernel and passed to 2nd kernel by exactmap. Then in 2nd kernel,
reserved memory regions are added into e820. Later hotplug memory still
trigger add_memory, and cause bug I reported.


> 
> >
> >Am I right?
> >
> 
> >The other question, e820 reserve is done earlier than acpi
> >initialization, because acpi_early_init() invocation is very late in
> >start_kernel(). Does that means at the very beginning all memorys are in
> >e820, later when acpi_early_init is called, hotplug memory is detected,
> >they will be moved to different place or need be marked with a specific
> >flag?
> 
> No.
> 
> Thanks,
> Yasuaki Ishimatsu
> 
