From: Thomas Renninger <trenn@suse.de>
Subject: Pentium 4 Mobile
Date: Wed, 09 Feb 2005 21:54:51 +0100
Message-ID: <420A789B.2000806@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk
To: ML ACPI-devel <acpi-devel@lists.sourceforge.net>, cpufreq@lists.linux.org.uk, linux-acpi@intel.com
List-Id: linux-acpi@vger.kernel.org

Hi,

I tried the P4M patches, but had no success.
Maschine:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Mobile Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping        : 1
cpu MHz         : 3057.212
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni 
monitor ds_cpl est tm2 cid xtpr

Most modules did not load.

The acpi-cpufreq module even gave me an oops, seems to come from the 
depths of the acpi interpreter:

Modules linked in: acpi_cpufreq speedstep_lib processor cpufreq_stats 
freq_table ide_cd cdrom ide_floppy ide_d
isk piix ide_core reiserfs
CPU:    0
EIP:    0060:[<c0214a65>]    Tainted: G     U VLI
EFLAGS: 00010203   (2.6.11-rc3-bk4-20050208180137-default)
EIP is at acpi_ut_find_allocation+0x25/0x33
eax: 00000010   ebx: 00000000   ecx: dfb55d20   edx: 00000010
esi: df4ac740   edi: 00000000   ebp: 00000000   esp: dfb55d28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 921, threadinfo=dfb54000 task=df9b0a60)
Stack: df4ac740 00000000 c0214b00 00000001 00000008 00000001 c030ee67 
c030ed25
        00000001 000000cc df4ac740 00000010 c030c41f c021492b 00000001 
00000010
        c030c41f 000000cc 00000008 dfb55d9c dfb55e74 dfb55ddc df4aca00 
c02098e5
Call Trace:
  [<c0214b00>] acpi_ut_track_allocation+0x8d/0x14c
  [<c021492b>] acpi_ut_callocate_and_track+0x50/0x7a
  [<c02098e5>] acpi_evaluate_object+0x85/0x263
  [<c01165b7>] recalc_task_prio+0x127/0x280
  [<e10f5a21>] acpi_processor_set_pdc+0x9d/0xe0 [processor]
  [<c02dfe1e>] wait_for_completion+0x6e/0xa0
  [<e10f5eed>] acpi_processor_get_performance_info+0x6d/0x118 [processor]
  [<e10f6299>] acpi_processor_register_performance+0xc9/0x126 [processor]
  [<e10f0474>] acpi_cpufreq_cpu_init+0x94/0x2e0 [acpi_cpufreq]
  [<c026b482>] cpufreq_add_dev+0xd2/0x280
  [<c018691a>] sysfs_add_file+0x3a/0x60
  [<c0148809>] unmap_area_pmd+0x39/0x50
  [<c014884d>] unmap_area_pud+0x2d/0x50
  [<e10ed000>] pentium3_get_frequency+0x0/0xe0 [speedstep_lib]
  [<c0148a3f>] unmap_vm_area+0x5f/0xa0
  [<e10ed000>] pentium3_get_frequency+0x0/0xe0 [speedstep_lib]
  [<c012e63a>] load_module+0xa8a/0xb40
  [<c0244377>] sysdev_driver_register+0x77/0xc0
  [<e10f0200>] acpi_cpufreq_target+0x0/0x50 [acpi_cpufreq]
  [<c026bf2f>] cpufreq_register_driver+0x4f/0xb0
  [<c012e7f4>] sys_init_module+0x104/0x180
  [<c0102c59>] sysenter_past_esp+0x52/0x79
Code: 14 5b 5e 5f 5d c3 56 53 89 c3 89 d6 e8 3a 04 00 00 31 d2 83 fb 06 
77 1c 6b c3 24 8b 80 e0 83 40 c0 85 c0
  74 0d 89 c2 39 f0 74 09 <8b> 40 04 85 c0 75 f3 31 d2 89 d0 5b 5e c3 55 
57 56 53 83 ec 18
  <6>b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 7 (level, low) -> IRQ 7



Are there  further implementations for Pentium 4 Mobile, maybe even with 
HT support planned/in process?


Thanks,

      Thomas
