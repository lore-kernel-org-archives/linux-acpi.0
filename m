From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: ACPI source release updated (20020725)
Date: Fri, 26 Jul 2002 15:57:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020726135715.GJ11818@dutidad.twi.tudelft.nl>
References: <59885C5E3098D511AD690002A5072D3C07990D88@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C07990D88-OU+JdkIUtvcLll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear list,

On Thu, Jul 25, 2002 at 05:13:16PM -0700, Grover, Andrew wrote:
> Patches of this release are available now at http://sf.net/projects/acpi.
> The compiler and non-Linux source releases will be available at:
> http://developer.intel.com/technology/iapc/acpi/downloads.htm by tomorrow
> evening.

I have applied this patch (20020725) to a clean 2.4.18 kernel along with the
swsusp v10 patches for acpi.  In acenv.h, I had to add a "#define
ACPI_DISASSEMBLER" to avoid the various compilation errors in
/usr/src/linux/drivers/acpi, mostly to do with the use of a "name" member in
debug statements.  These compilation errors have been pointed out by Linus
and another user.

In anycase, immediately after booting up with this kernel, I get an oops and
the system cannot boot.  I have run this oops through ksymoops and it does
seem that this happens in the acpi code.  The output is attached.

Any ideas?

I will try to compile the kernel _without_ setting ACPI_DISASSEMBLER and
just comment out all the offending output statements to see if this makes a
difference.

Thanks for possible advice,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi-ksymoops.txt"

ksymoops 2.4.5 on i686 2.4.18.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00003d0b
c017ffbe
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c017ffbe>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: c023f4c0 ebx: cfee2428 ecx: 0000000f edx: 00000010
esi: 00003d0b edi: cfee243a ebp: cfee9ec8 esp: cfee9e80
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=cfee9000)
Stack: cfee2428 00000010 c02cf5d4 c018004f cfee2428 00000010 c02cf5d4 cfee9ef4
       02242f68 c017ff77 00000010 c017b3f5 0000003d cfee9ec8 00000000 cfee9ef4
       c02cf5d4 c02cf91c 00000010 c023e6c7 c024e6c0 c017b4f3 00000001 c02cf5d4
Call Trace: [<c018004f>] [<c017ff77>] [<c017b3f5>] [<c017b4f3>] [<c017b65a>]
   [<c017b776>] [<c017b8c7>] [<c018658c>] [<c0105037>] [<c0105478>]
Code: ac aa 84 c0 75 f7 f3 aa 5b 5e 5f c3 89 f6 83 ec 04 56 53 8b


>>EIP; c017ffbe <acpi_ps_init_op+32/40>   <=====

>>eax; c023f4c0 <acpi_gbl_aml_op_info+80/7e0>
>>ebx; cfee2428 <END_OF_CODE+fbf0fb4/????>
>>esi; 00003d0b Before first symbol
>>edi; cfee243a <END_OF_CODE+fbf0fc6/????>
>>ebp; cfee9ec8 <END_OF_CODE+fbf8a54/????>
>>esp; cfee9e80 <END_OF_CODE+fbf8a0c/????>

Trace; c018004f <acpi_ps_alloc_op+83/94>
Trace; c017ff77 <acpi_ps_create_scope_op+7/1c>
Trace; c017b3f5 <acpi_ns_one_complete_parse+35/fc>
Trace; c017b4f3 <acpi_ns_parse_table+37/90>
Trace; c017b65a <acpi_ns_load_table+10e/170>
Trace; c017b776 <acpi_ns_load_table_by_type+ba/19c>
Trace; c017b8c7 <acpi_ns_load_namespace+6f/cc>
Trace; c018658c <acpi_load_tables+fc/170>
Trace; c0105037 <init+7/110>
Trace; c0105478 <kernel_thread+28/38>

Code;  c017ffbe <acpi_ps_init_op+32/40>
00000000 <_EIP>:
Code;  c017ffbe <acpi_ps_init_op+32/40>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c017ffbf <acpi_ps_init_op+33/40>
   1:   aa                        stos   %al,%es:(%edi)
Code;  c017ffc0 <acpi_ps_init_op+34/40>
   2:   84 c0                     test   %al,%al
Code;  c017ffc2 <acpi_ps_init_op+36/40>
   4:   75 f7                     jne    fffffffd <_EIP+0xfffffffd> c017ffbb <acpi_ps_init_op+2f/40>
Code;  c017ffc4 <acpi_ps_init_op+38/40>
   6:   f3 aa                     repz stos %al,%es:(%edi)
Code;  c017ffc6 <acpi_ps_init_op+3a/40>
   8:   5b                        pop    %ebx
Code;  c017ffc7 <acpi_ps_init_op+3b/40>
   9:   5e                        pop    %esi
Code;  c017ffc8 <acpi_ps_init_op+3c/40>
   a:   5f                        pop    %edi
Code;  c017ffc9 <acpi_ps_init_op+3d/40>
   b:   c3                        ret    
Code;  c017ffca <acpi_ps_init_op+3e/40>
   c:   89 f6                     mov    %esi,%esi
Code;  c017ffcc <acpi_ps_alloc_op+0/94>
   e:   83 ec 04                  sub    $0x4,%esp
Code;  c017ffcf <acpi_ps_alloc_op+3/94>
  11:   56                        push   %esi
Code;  c017ffd0 <acpi_ps_alloc_op+4/94>
  12:   53                        push   %ebx
Code;  c017ffd1 <acpi_ps_alloc_op+5/94>
  13:   8b 00                     mov    (%eax),%eax


--EVF5PPMfhYS0aIcm--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
