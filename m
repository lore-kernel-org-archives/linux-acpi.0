From: Jiri Kosina <jkosina@suse.cz>
Subject: WARNING: at drivers/base/sys.c:183 sysdev_driver_register+0x75/0x12e()
Date: Tue, 22 Apr 2008 16:12:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804221609130.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org+glkc-cpufreq=gmane.org@lists.linux.org.uk
To: davej@codemonkey.org.uk, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi,

I am getting the acpi-cpufreq-drivercore warning below when booting 
current git (807501475)

powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors (1 cpu 
cores) (version 2.20.00)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
sysdev: class cpu: driver (ffffffff8057fd10) has already been registered 
to a class, something is wrong, but will forge on!
------------[ cut here ]------------
WARNING: at drivers/base/sys.c:183 sysdev_driver_register+0x75/0x12e()
Modules linked in: acpi_cpufreq(+) snd_mixer_oss freq_table snd_seq loop 
dm_mod snd_via82xx gameport snd_ac97_codec ac97_bus snd_pcm snd_timer 
snd_page_alloc snd_mpu401_uart snd_rawmidi parport_pc snd_seq_device 
parport snd shpchp floppy i2c_viapro i2c_core soundcore pci_hotplug sr_mod 
r8169 cdrom button sg usbhid hid sd_mod edd ext3 mbcache jbd fan pata_via 
sata_via libata scsi_mod dock thermal processor
Pid: 2284, comm: modprobe Not tainted 2.6.25-default-03410-g8075014 #27

Call Trace:
 [<ffffffff8022dcc7>] warn_on_slowpath+0x58/0x6b
 [<ffffffff8022eba7>] ? printk+0x67/0x69
 [<ffffffff8042777a>] ? __mutex_unlock_slowpath+0xf9/0x105
 [<ffffffff8042778f>] ? mutex_unlock+0x9/0xb
 [<ffffffff8042927d>] ? _spin_unlock_irqrestore+0x3f/0x47
 [<ffffffff80368b33>] sysdev_driver_register+0x75/0x12e
 [<ffffffff803a9fb3>] cpufreq_register_driver+0x95/0x12f
 [<ffffffffa00f503f>] :acpi_cpufreq:acpi_cpufreq_init+0x3f/0x41
 [<ffffffff80252b4b>] sys_init_module+0x19d1/0x1b02
 [<ffffffff80285eda>] ? __kmalloc+0x0/0xea
 [<ffffffff8024a87b>] ? trace_hardirqs_on+0xf1/0x115
 [<ffffffff80428afc>] ? trace_hardirqs_on_thunk+0x35/0x3a
 [<ffffffff8020bf7b>] system_call_after_swapgs+0x7b/0x80

---[ end trace 21ad653327c7db6f ]---

-- 
Jiri Kosina
