From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: DSDT in Dell i8200-- does acpi have the correct address?
Date: 16 Dec 2002 14:38:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1040067486.2060.27.camel@sirius.strandboge.cxm>
References: <1040066279.2070.18.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1040066279.2070.18.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-12-16 at 14:17, James D Strandboge wrote:

> 
> Now, if I read my dsdt from /proc/acpi/dsdt, nd decompile it with iasl,
> it shows a version from 1998.  I looked at dmesg and found:
> 
> ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
> ACPI: BIOS passes blacklist
> 

I meant to also include from dmesg:

ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 DELL                       ) @ 0x000fde50
ACPI: RSDT (v001 DELL    CPi R   10194.01801) @ 0x000fde64
ACPI: FADT (v001 DELL    CPi R   10194.01801) @ 0x000fde90
ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
ACPI: BIOS passes blacklist

>From what I can tell, all the tables other than DSDT are falling within
the range of what Dell has listed on their site.  The (I assume) dates
and vendor also correspond-- but the DSDT is different here too.

Jamie

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
