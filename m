From: Maciek Gorniak <mago-StWSBrfNG1XVItvQsEIGlw@public.gmane.org>
Subject: Re: acpi causes reboot
Date: 01 Sep 2002 14:14:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1030882441.689.14.camel@vabanque>
References: <20020703131246.GA1718@insomnia>
	<1025727109.825.4.camel@vabanque> <20020703221318.GA1272@insomnia>
	<1025864286.549.1.camel@vabanque> <20020705173852.GB543@insomnia>
	<1026241975.778.4.camel@vabanque> <20020801130511.GA490@insomnia>
	<1028230097.532.3.camel@vabanque>  <20020827113619.GA561@insomnia>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020827113619.GA561-qABvevMY06w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Filippo Panessa - Kalem <kalem-k2GhghHVRtY@public.gmane.org>
Cc: ACPI list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On wto, 2002-08-27 at 13:36, Filippo Panessa - Kalem wrote:
> Maciek Gorniak il 01 agosto 2002, alle 21:28 ha scritto:
> 
> > > But, it doesn't work with acpi-20020725 and acpi-20020726.
> > 
> > Yes. I can't run these either. But it doesn't seem to be related to the
> > patch. These versions seem to be rather buggy...
> 
> I'm so sorry... acpi-20020821-2.4.19 doesn't  work too. Have you got any
> idea ?

To make it run I had to comment out checksum checking in tables.c in
procedure acpi_table_get_sdt (first occurance)

/*
  if (acpi_table_compute_checksum(header, header->length)) {
	printk(KERN_WARNING PREFIX "Invalid RSDT checksum\n");
	return -ENODEV;
  }
*/

It seems to be still the same problem, something bad happens when rsdt
table is being mapped... I promised myself that I'll investigate it
closer, but unfortunately I don't have time for this now... :(

Hope that works for you too.

P.S. You have to apply my previous patch too

-- 
Maciek Gorniak




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
