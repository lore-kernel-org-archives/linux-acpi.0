From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Mon, 14 Feb 2005 11:07:39 +0100
Message-ID: <20050214100738.GC3233@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr> <20050211113636.GI3263@crusoe.alcove-fr> <20050212142103.5e1a79f9.khali@linux-fr.org>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212142103.5e1a79f9.khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pekka Enberg <penberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Feb 12, 2005 at 02:21:03PM +0100, Jean Delvare wrote:

> > Based on feedback from Jean Delvare and Pekka Enberg, here is an
> > updated version.
> 
> Works for me (Vaio PCG-GR214EP). Tested with 2.6.11-rc3-bk8.
> 
> I then enabled the debug mode. I couldn't find anything relevant WRT
> what each additional file is supposed to do, but I still have noticed a
> number of things you might be interested in.
[...]

I have some interesting information from one user, who noticed that:

* pbr is the power-on brightness. It's the brightness that the
  laptop uses at power-on time.

* cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
  order to save a bit of power consumption.

I'll add this information in the docs.

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
