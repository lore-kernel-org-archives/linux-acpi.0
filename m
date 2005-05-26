From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.12-rc2-mm2
Date: Wed, 25 May 2005 22:07:56 -0700
Message-ID: <20050525220756.17545763.akpm@osdl.org>
References: <20050408030835.4941cd98.akpm@osdl.org>
	<1113054188.2364.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1113054188.2364.23.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org> wrote:
>
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> >
> > Changes since 2.6.12-rc2-mm1:
> > 
> > 
> >  bk-acpi.patch
> 
> [acpi-devel up on cc]
> 
> 
> One of my boxen takes about 5 minutes to reboot now, hitting sysrq-p a
> few times shows it mostly sits in in acpi_ut_find_allocation+0x2b/0x37.
> Reverting bk-acpi.patch makes it reboot like normal, config attached.

did this get fixed?

> 
> (gdb) disass acpi_ut_find_allocation
> Dump of assembler code for function acpi_ut_find_allocation:
> 0xc01daa2d <acpi_ut_find_allocation+0>: push   %ebp
> 0xc01daa2e <acpi_ut_find_allocation+1>: mov    %esp,%ebp
> 0xc01daa30 <acpi_ut_find_allocation+3>: push   %esi
> 0xc01daa31 <acpi_ut_find_allocation+4>: mov    %edx,%esi
> 0xc01daa33 <acpi_ut_find_allocation+6>: push   %ebx
> 0xc01daa34 <acpi_ut_find_allocation+7>: mov    %eax,%ebx
> 0xc01daa36 <acpi_ut_find_allocation+9>: call   0xc01dae66 <acpi_ut_track_stack_ptr>
> 0xc01daa3b <acpi_ut_find_allocation+14>:        xor    %edx,%edx
> 0xc01daa3d <acpi_ut_find_allocation+16>:        cmp    $0x6,%ebx
> 0xc01daa40 <acpi_ut_find_allocation+19>:        ja     0xc01daa5e <acpi_ut_find_allocation+49>
> 0xc01daa42 <acpi_ut_find_allocation+21>:        imul   $0x24,%ebx,%eax
> 0xc01daa45 <acpi_ut_find_allocation+24>:        mov    0xc03c1040(%eax),%eax
> 0xc01daa4b <acpi_ut_find_allocation+30>:        test   %eax,%eax
> 0xc01daa4d <acpi_ut_find_allocation+32>:        je     0xc01daa5c <acpi_ut_find_allocation+47>
> 0xc01daa4f <acpi_ut_find_allocation+34>:        cmp    %esi,%eax
> 0xc01daa51 <acpi_ut_find_allocation+36>:        mov    %eax,%edx
> 0xc01daa53 <acpi_ut_find_allocation+38>:        je     0xc01daa5e <acpi_ut_find_allocation+49>
> 0xc01daa55 <acpi_ut_find_allocation+40>:        mov    0x4(%eax),%eax
> 0xc01daa58 <acpi_ut_find_allocation+43>:        test   %eax,%eax
> 0xc01daa5a <acpi_ut_find_allocation+45>:        jne    0xc01daa4f <acpi_ut_find_allocation+34>
> 0xc01daa5c <acpi_ut_find_allocation+47>:        xor    %edx,%edx
> 0xc01daa5e <acpi_ut_find_allocation+49>:        pop    %ebx
> 0xc01daa5f <acpi_ut_find_allocation+50>:        pop    %esi
> 0xc01daa60 <acpi_ut_find_allocation+51>:        mov    %edx,%eax
> 0xc01daa62 <acpi_ut_find_allocation+53>:        leave
> 0xc01daa63 <acpi_ut_find_allocation+54>:        ret
> End of assembler dump.
> 
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
