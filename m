From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Mon, 14 Feb 2005 19:42:35 +0100
Message-ID: <20050214194235.073f5850.khali@linux-fr.org>
References: <20050214100738.GC3233@crusoe.alcove-fr>
	<CKthPPXN.1108383209.9808960.khali@localhost>
	<20050214123822.GF3233@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050214123822.GF3233-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pekka Enberg <penberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

> > > * pbr is the power-on brightness. It's the brightness that the
> > >   laptop uses at power-on time.
> > 
> > Will test this evening.

I can confirm, that works for me too.

> > > * cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
> > >   order to save a bit of power consumption.
> > 
> > I don't seem to have cdp on my system. Is this something I need to
> > manually activate in the driver, or does it simply mean that my
> > laptop doesn't support that feature?
> 
> sony_acpi doesn't create this node. But if it is supported on your
> system you should see 'method: name: GCDP' and 'method: name: SCDP'
> in the logs because sony_acpi does enumerate all the methods it
> finds for the snc device.

I don't have this one. The logs say:

sony_acpi: method: name: GPID, args 0
sony_acpi: method: name: GBRT, args 0
sony_acpi: method: name: SBRT, args 1
sony_acpi: method: name: GPBR, args 0
sony_acpi: method: name: SPBR, args 1
sony_acpi: method: name: GCTR, args 0
sony_acpi: method: name: SCTR, args 1
sony_acpi: method: name: GPCR, args 0
sony_acpi: method: name: SPCR, args 1
sony_acpi: method: name: GCMI, args 1
sony_acpi: method: name: SCMI, args 1
sony_acpi: method: name: PWAK, args 0
sony_acpi: method: name: PWRN, args 0
sony_acpi: method: name: CSXB, args 1

So, let alone the ones the driver already exposes when loaded with
debug=1, I have:
GPID, GPCR/SPCR, PWAK and PWRN.

A few random comments:
* GPID could be "get product id"?
* I'll give a try to GPCR/SPCR, seems to be another get/set pair.
* Isn't is strange that GCMI takes one argument?
* CSXB is obviously not part of a standard get/set pair, which might
  (somewhat) explain why it crashed my system the other day.

I'll report if I can find more.

Thanks,
-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
