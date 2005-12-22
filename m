From: Voluspa <lista1-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: Re: 2.6.15-rc5-mm1
Date: Thu, 22 Dec 2005 16:07:53 +0100
Message-ID: <20051222160753.67437695.lista1@telia.com>
References: <20051210111557.18ba5fc8.lista1@telia.com>
	<200512101320.18779.rik@osrc.info>
	<20051214050428.21d3f224.lista1@telia.com>
	<43AAABA7.7080303@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43AAABA7.7080303-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 22 Dec 2005 14:35:35 +0100 Thomas Renninger wrote:
> Voluspa wrote:
> > On Sat, 10 Dec 2005 13:20:15 +0300 Roman I Khimov wrote:
> >> | Voluspa:
> >>> Nope, neither "nocst" nor "acpi=nocst" gave me back the C1
> >>> functionality...
> >> Yep, same here, just tried.
> > 
> > Sorry about the red herring. I've patched 2.6.14 with the two acpi
[...]
> Maybe it is this little patch that also has been applied in rc5?
> http://bugzilla.kernel.org/show_bug.cgi?id=5452
> 
> If you have ACPI_DEBUG=y compiled in you should have seen:
> "BIOS reporting wrong ACPI idfor the processor", then it might be this one.

Thanx Thomas, but no, I tripped on a bug totally unrelated to Roman's. Found
the culprit and reported + opened a bugzilla:

http://bugzilla.kernel.org/show_bug.cgi?id=5767

Mvh
Mats Johannesson
--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
