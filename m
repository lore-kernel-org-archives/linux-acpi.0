From: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Subject: Re: Crash with fs corruption on 2.4.23-rc1 + CONFIG_ACPI_PROCESSOR
Date: Fri, 14 Nov 2003 16:24:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031114152403.GK29316@roosevelt.alcove-fr>
References: <20031113161857.GM26911@roosevelt.alcove-fr> <20031114124713.GK32464@poupinou.org>
Reply-To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031114124713.GK32464-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 14, 2003 at 01:47:13PM +0100, Ducrot Bruno wrote:

> > Attached you'll find the .config and dmesg in case it is useful...
> > 
> 
> Have you a decoded oops?

Here is one, hand copied because there is no serial port on this laptop...

I'm not sure it is useful because it shows the actual corruption in ext3
code more than the place where the memory gets corrupted...

But I'm 100% positive that this does happen only *after* inserting
the processor.o module...

Stelian.


ksymoops 2.4.9 on i686 2.4.23-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-rc1/ (default)
     -m /boot/System.map-2.4.23-rc1 (specified)

Unable to handle kernel paging request at virtual address 02000000
  c0145098
Oops: 0000
CPU:    0
EIP:    0010:[<c0145098>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c37b93e0   ebx: c37b93e0   ecx: c37b9378   edx: 02000000
ds: 0018  es: 0018  ss: 0018
Process find (pid: 6451, stackpage=cd2a7000)
Stack: cefee6a0 cd2a7f40 cb0f5000 c01456b9 cefee6a0 cd2a7f40 00000000 00000008 
       cef2a080 00000000 cb0f5000 00000006 d3fc8528 080560fd cd2a7f98 cb0f5000
       00000000 00000008 c0145b99 cb0f5000 cb0f5000 cd2a7f98 c0145e39 080560fd
Call Trace: [<c01456b9>] [<c0145b99>] [<c0145e39>] [<c014251f>] [<c013aa64>] [<c01090ff>]
Code: 8b 02 85 c0 75 0a 89 d8 8b 5c 24 08 83 c4 0c c3 89 1c 24 8b


>>EIP; c0145098 <cached_lookup+28/70>   <=====

>>eax; c37b93e0 <_end+34d33c8/f523048>
>>ebx; c37b93e0 <_end+34d33c8/f523048>
>>ecx; c37b9378 <_end+34d3360/f523048>

Trace; c01456b9 <link_path_walk+3b9/6e0>
Trace; c0145b99 <path_lookup+39/40>
Trace; c0145e39 <__user_walk+49/60>
Trace; c014251f <sys_lstat64+1f/90>
Trace; c013aa64 <sys_write+f4/140>
Trace; c01090ff <system_call+33/38>

Code;  c0145098 <cached_lookup+28/70>
00000000 <_EIP>:
Code;  c0145098 <cached_lookup+28/70>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c014509a <cached_lookup+2a/70>
   2:   85 c0                     test   %eax,%eax
Code;  c014509c <cached_lookup+2c/70>
   4:   75 0a                     jne    10 <_EIP+0x10>
Code;  c014509e <cached_lookup+2e/70>
   6:   89 d8                     mov    %ebx,%eax
Code;  c01450a0 <cached_lookup+30/70>
   8:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  c01450a4 <cached_lookup+34/70>
   c:   83 c4 0c                  add    $0xc,%esp
Code;  c01450a7 <cached_lookup+37/70>
   f:   c3                        ret    
Code;  c01450a8 <cached_lookup+38/70>
  10:   89 1c 24                  mov    %ebx,(%esp,1)
Code;  c01450ab <cached_lookup+3b/70>
  13:   8b 00                     mov    (%eax),%eax

-- 
Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Alcove - http://www.alcove.com


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
