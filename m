From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] x86, acpi memory hotplug, add parameter to disable
 memory hotplug
Date: Mon, 13 Jan 2014 18:41:29 -0700
Message-ID: <1389663689.1792.268.camel@misato.fc.hp.com>
References: <1389650161-13292-1-git-send-email-prarit@redhat.com>
	 <CAHGf_=pX303E6VAhL+gApSQ1OsEQHqTuCN8ZSdD3E54YAcFQKA@mail.gmail.com>
	 <52D47999.5080905@redhat.com> <52D48EC4.5070400@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <52D48EC4.5070400@jp.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: Prarit Bhargava <prarit@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linn Crosetto <linn@hp.com>, Pekka Enberg <penberg@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Tang Chen <tangchen@cn.fujitsu.com>, Wen Congyang <wency@cn.fujitsu.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2014-01-14 at 10:11 +0900, Yasuaki Ishimatsu wrote:
 :
> >> I think we need a knob manually enable mem-hotplug when specify memmap. But
> >> it is another story.
> >>
> >> Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> >
> > As mentioned, self-NAK.  I have seen a system that I needed to specify
> > memmap=exactmap & had hotplug memory.  I will only keep the acpi_no_memhotplug
> > option in the next version of the patch.
> 
> 
> Your following first patch is simply and makes sense.
> 
> http://marc.info/?l=linux-acpi&m=138922019607796&w=2
> 

In this option, it also requires changing kexec-tools to specify the new
option for kdump.  It won't be simpler.

Thanks,
-Toshi

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
