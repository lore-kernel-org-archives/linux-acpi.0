From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Tue, 5 Apr 2005 20:08:26 +0200
Message-ID: <20050405180826.GU2298@poupinou.org>
References: <200504042214.15648.jfrey@gmx.de> <200504051638.22705.stefandoesinger@gmx.at> <200504051813.28983.jfrey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504051813.28983.jfrey-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Frey <jfrey-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 05, 2005 at 06:13:28PM +0200, Jan Frey wrote:
> Really astonishing: CPU temperature seems to go up to roughly 70 degrees 
> quite quickly and then it stays there nearly forever: it does not matter 
> whether CPU load is 0 or 1.. And: throttling also does not lower CPU temp, 
> I thought this would be main reason...

BTW, are you sure throttling work OK?
In order to test this, you may try something like 'openssl speed md5' for
each levels.  The results given should be roughly linear.

Also I'm wondering what is actually the output of ACPI tables.  Would
help if you do something like that:

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out 

Then mail me the acpidmp.out.bz2

I'm in fact more interrested with FADT and DSDT, but other tables
wont hurt.

I'm still wondering if I'm right to think that its not an intel
chipset.  If its an Intel one, then something is wrong.  Intel chipset
support 8 throttling levels, not 16.  Could you please do a lspci -v?

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
