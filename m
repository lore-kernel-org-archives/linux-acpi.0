From: Romano Giannetti <romanol-qvIf60buks8@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Wed, 16 Feb 2005 16:40:07 +0100
Message-ID: <20050216154007.GA2142@pern.dea.icai.upco.es>
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr> <20050214203211.GA8007@ucw.cz> <20050215161412.GC20951@pern.dea.icai.upco.es> <20050216144156.GA4372@crusoe.alcove-fr>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050216144156.GA4372-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Matthew Garrett <mgarrett-QGMSyCZBOSwv4zxTlrOuLwNdhmdF6hFW@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 16, 2005 at 03:41:59PM +0100, Stelian Pop wrote:
> On Tue, Feb 15, 2005 at 05:14:12PM +0100, Romano Giannetti wrote:

> > http://bugme.osdl.org/show_bug.cgi?id=4124
> 
> Strange indeed.
> 
> First thing to test is to disable sonypi (either rebuild a kernel
> without it or rename the module so it will not get loaded again),
> then reboot and see if you still have problems.
>

I have it compiled in, but it is not loaded: on a freshly booted kernel, 
dmesg | grep sonypi results in nothing, and if I try to load it manually:

# modprobe sonypi
FATAL: Error inserting sonypi (/lib/modules/2.6.11-rc1/kernel/drivers/char/sonypi.ko): No such device

and in syslog:

sonypi: request_region failed

which is correct, because this laptop doesn't have a sonypi devive, it is
a PCG-FX701. I will nuke the module and try to reboot, but I do not think it
will make any difference.

> If you do, the problem is ACPI/input related.
> 
> If you don't, the strangeness comes from some interraction with
> sonypi.

It's happened between 2.6.7 and 2.6.9; the only differences I can see in the
.config are the following: 

+CONFIG_ACPI_BLACKLIST_YEAR=0
+CONFIG_SERIO_RAW=m

... but I do not think they could make any difference. I will compile a
2.6.11-rc4 and try, but... 

Anyway, I have put the dsdt from cat /proc/acpi/dsdt in

http://www.dea.icai.upco.es/romano/linux/mydsdt.bin

Thank you for the help. 

          Romano
          
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
