From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compaq Deskpro EN SFF P500 DSDT Compile Error 1022
Date: Tue, 19 Jul 2005 16:44:25 +0200
Message-ID: <20050719144425.GG2715@poupinou.org>
References: <971FCB6690CD0E4898387DBF7552B90E021CB55A@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E021CB55A-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 18, 2005 at 09:15:52AM -0700, Moore, Robert wrote:
> MLEN is probably in another table (an SSDT)
> 
> An external declaration for MLEN will allow the file to compile:
> 
> External (MLEN)

It is probably a field in a system memory region I think, and probably
in a SSDT as Bob said.

The best way the OP can check is to get those SSDT(s) via

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out

Then
./acpixtract SSDT < acpidmp.out > ssdt

and decompile them using iasl -d.

The only trouble though is that acpixtract is only able to retrieve the
first SSDT.

Anyway, if there is no kernel message about a MLEN not found or so, it
is very likely harmless.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
