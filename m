From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: 2.4.20 + ACPI-20021212 - strange oops
Date: Tue, 25 Feb 2003 00:27:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030224232749.GA11495@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,
I had this oops shortly after the system had started completely (i.e. the
gettys appeared). This has been the only occurence so far, I don't know how
to reproduce it. I'm using 2.4.20 with xfs, acpi-20021212, swsusp and
cpufreq patches. Here is the ksymoops output:

#v+
ksymoops 2.4.8 on i686 2.4.20-xfs-cpufreq-swsusp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-xfs-cpufreq-swsusp/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 87ec33cc
c0207057
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0207057>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 87ec33cc   ecx: 00000000   edx: cd935d7c
esi: 87ec33cc   edi: cd935df4   ebp: c021acf0   esp: cd935d84
ds: 0018   es: 0018   ss: 0018
Process kacpidpc (pid: 220, stackpage=cd935000)
Stack: 00001001 c02081ad 87ec33cc c02161bb 00200000 cd935df4 cd935dc0
87ec33cc
       87ec33cc c021ada0 87ec33cc c021acf0 cd935df4 00200000 00000000
00010000
       c02d9c9f c02d9c54 00000050 00000000 cd935df8 cd935e34 c0224c68
87ec33cc
Call Trace:    [<c02081ad>] [<c02161bb>] [<c021ada0>] [<c021acf0>]
[<c0224c68>]
  [<c02163d0>] [<c0225246>] [<c022589c>] [<c021b2f2>] [<c0216100>]
[<c022ac0c>]
  [<c0229cb9>] [<c022b0df>] [<c021ae23>] [<c022c286>] [<c01f0a3e>]
[<c01e5d73>]
  [<c01f09d0>] [<c010582e>] [<c01e5ca0>]
Code: 80 3b aa 0f 44 c3 5b c3 90 a1 94 f8 35 c0 eb f6 89 f6 8d bc


>>EIP; c0207057 <acpi_ns_map_handle_to_node+17/30>   <=====

>>edx; cd935d7c <_end+d5b7f24/12496208>
>>edi; cd935df4 <_end+d5b7f9c/12496208>
>>ebp; c021acf0 <acpi_bus_data_handler+0/50>
>>esp; cd935d84 <_end+d5b7f2c/12496208>

Trace; c02081ad <acpi_get_data+5d/90>
Trace; c02161bb <acpi_ut_trace+3b/40>
Trace; c021ada0 <acpi_bus_get_device+60/110>
Trace; c021acf0 <acpi_bus_data_handler+0/50>
Trace; c0224c68 <acpi_power_get_context+68/120>
Trace; c02163d0 <acpi_ut_value_exit+50/60>
Trace; c0225246 <acpi_power_off_device+56/290>
Trace; c022589c <acpi_power_transition+15c/190>
Trace; c021b2f2 <acpi_bus_set_power+1b2/3a0>
Trace; c0216100 <acpi_ut_debug_print+a0/e0>
Trace; c022ac0c <acpi_thermal_active+ec/220>
Trace; c0229cb9 <acpi_thermal_get_temperature+c9/100>
Trace; c022b0df <acpi_thermal_check+36f/3e0>
Trace; c021ae23 <acpi_bus_get_device+e3/110>
Trace; c022c286 <acpi_thermal_notify+d6/160>
Trace; c01f0a3e <acpi_ev_notify_dispatch+6e/a0>
Trace; c01e5d73 <acpi_os_queue_exec+d3/100>
Trace; c01f09d0 <acpi_ev_notify_dispatch+0/a0>
Trace; c010582e <kernel_thread+2e/40>
Trace; c01e5ca0 <acpi_os_queue_exec+0/100>

Code;  c0207057 <acpi_ns_map_handle_to_node+17/30>
00000000 <_EIP>:
Code;  c0207057 <acpi_ns_map_handle_to_node+17/30>   <=====
   0:   80 3b aa                  cmpb   $0xaa,(%ebx)   <=====
Code;  c020705a <acpi_ns_map_handle_to_node+1a/30>
   3:   0f 44 c3                  cmove  %ebx,%eax
Code;  c020705d <acpi_ns_map_handle_to_node+1d/30>
   6:   5b                        pop    %ebx
Code;  c020705e <acpi_ns_map_handle_to_node+1e/30>
   7:   c3                        ret
Code;  c020705f <acpi_ns_map_handle_to_node+1f/30>
   8:   90                        nop
Code;  c0207060 <acpi_ns_map_handle_to_node+20/30>
   9:   a1 94 f8 35 c0            mov    0xc035f894,%eax
Code;  c0207065 <acpi_ns_map_handle_to_node+25/30>
   e:   eb f6                     jmp    6 <_EIP+0x6>
Code;  c0207067 <acpi_ns_map_handle_to_node+27/30>
  10:   89 f6                     mov    %esi,%esi
Code;  c0207069 <acpi_ns_map_handle_to_node+29/30>
  12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi


1 warning issued.  Results may not be reliable.
#v-

My DSDT is at http://hell.org.pl/~sziwan/asus/dsdt.dsl, if anybody bothered
to look. The oops wasn't fatal to the kernel, but I wasn't really in the
mood of checking how far would it go, so I rebooted shortly after the
prompt. I hope this will be useful to somebody...
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
