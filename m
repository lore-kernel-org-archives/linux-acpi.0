From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Speedstep-centrino problems
Date: Thu, 10 Feb 2005 20:28:14 +0100
Message-ID: <20050210192814.GG1145@poupinou.org>
References: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117D810@alaska.condis.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117D810-0IKPNnIBiwz73juT6mD8XA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Simon Moore <Simon_Moore-HnN13UdsTkzz1n+OaKNE4w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 10, 2005 at 10:38:31AM +0100, Simon Moore wrote:
> Hi,
> 
> I'm trying to get acpi cpu throttling working for my Dell Inspiron 510m
> with a Pentium M Centrino 1.6 Ghz cpu.
> 

I need the full acpi dump (not just dsdt) to debug this.

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out 

Then mail me (privately) the acpidmp.out.bz2

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
