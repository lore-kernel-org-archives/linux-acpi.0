From: Steven Cole <elenstev-dIRlkrwy3vBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Date: Tue, 05 Apr 2005 14:09:52 -0600
Message-ID: <4252F090.4040605@mesatop.com>
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no> <42524D83.1080104@reub.net> <20050405121444.GB6885@stusta.de> <6.2.3.0.2.20050406002812.04393a30@tornado.reub.net> <20050405132417.GD6885@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050405132417.GD6885-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Cc: Reuben Farrelly <reuben-lkml-MwA23MxOyI4@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Apr 06, 2005 at 12:32:52AM +1200, Reuben Farrelly wrote:
> 
>>Hi again
>>
>>At 12:14 a.m. 6/04/2005, Adrian Bunk wrote:
>>
>>>On Tue, Apr 05, 2005 at 08:34:11PM +1200, Reuben Farrelly wrote:
>>>
>>>
>>>>Hi,
>>>
>>>Hi Reuben,
>>>
>>>
>>>>...
>>>>Hrm. Something changed between the last -mm release which compiled
>>>>through, and this one..
>>>>...
>>>>  LD      .tmp_vmlinux1
>>>>arch/i386/kernel/built-in.o(.init.text+0x1823): In function `setup_arch':
>>>>: undefined reference to `acpi_boot_table_init'
>>>>arch/i386/kernel/built-in.o(.init.text+0x1828): In function `setup_arch':
>>>>: undefined reference to `acpi_boot_init'
>>>>make: *** [.tmp_vmlinux1] Error 1
>>>>[root@tornado linux-2.6]#
>>>>
>>>>Backing out bk-acpi.patch works around it..
>>>
>>>Please send your .config .
>>
>>Have just figured out that it seems to be caused by having ACPI 
>>disabled in .config, once I re-enabled ACPI the build problem went away.
>>
>>Config attached anyway, I imagine the problem is quite reproduceable..
> 
> 
> Ah, this was the working .config .
> fter setting CONFIG_ACPI=n I started seeing different but most likely 
> related problems.
> 
> 
> @Len:
> ACPI=y and ACPI_BOOT=n seems to be a legal configuration (with 
> X86_HT=y), but it breaks into pieces if you try the compilation.
> 

Here is some additional and hopefully helpful information.
Without CONFIG_ACPI=y, I first got:

arch/i386/kernel/setup.c: In function 'setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function 'acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function 'acpi_boot_init'

and then at the end:

arch/i386/kernel/built-in.o(.init.text+0x1b81): In function `setup_arch':
: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x1b86): In function `setup_arch':
: undefined reference to `acpi_boot_init'
make: *** [.tmp_vmlinux1] Error 1

With these set linux-2.6.12-rc2-mm1 built OK.

[steven@spc1 linux-2.6.12-rc2-mm1]$ grep ^CONFIG_ACPI .config
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

Steven


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
