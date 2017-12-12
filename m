From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: [BUG] acpica: ltp_acpi test case causes kernel crash at acpi_ns_walk_namespace
Date: Tue, 12 Dec 2017 07:59:19 -0800
Message-ID: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: vadim.lomovtsev@cavium.com
List-Id: linux-acpi@vger.kernel.org

Hi guys,

While running LTP tests I've faced kernel crash caused by ltp_acpi test case.
I have ACPI support enabled in kernel but kernel is boot with FDT having ACPI
disabled. The ltp_acpi test case application is built along with ltp_acpi_cmds
module to run ACPI tests.

So my question is - should we update acpica implementation at kernel side by
adding 'acpi_disabled' variable checking to the 'acpi_get_devices' function (see
patch next to this email, maybe not a good approach) or this should be fixed at LTP
side so the ltp_acpi_cmds should be updated in order to check if acpi is enabled
before running tests ?

Please check for kernel trace below:

[  928.815454] Modules linked in: ltp_acpi_cmds(OE) ip6t_rpfilter ipt_REJECT
[ .. ]
2 05:12:36 ...
 kernel:Internal error: Oops: 96000007 [#1] SMP
 [  928.903937]  ipmi_devintf mdio_thunder thunderx_edac mdio_cavium ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod dax
 [  928.917581] CPU: 32 PID: 27679 Comm: ltp_acpi Tainted: G           OE    4.15.0-rc3+ #1
 [  928.928154] Hardware name: Gigabyte MT60-SC0-00_24SATA_02/MT60-SC0-00_24SATA_02, BIOS ThunderX-Firmware-Release-1.22.18-Build_02 Oct 17 2017
 [  928.946235] pstate: 60000005 (nZCv daif -PAN -UAO)
 [  928.953764] pc : acpi_ns_walk_namespace+0x64/0x1cc
 [  928.961296] lr : acpi_get_devices+0x74/0x90
 [  928.968159] sp : fffffc004d50fba0
 [  928.974170] x29: fffffc004d50fba0 x28: 0000000000000001
 [  928.982234] x27: fffffc00088a1000 x26: 0000000000000001
 [  928.990308] x25: 0000000000000000 x24: fffffc004d50fc58
 [  928.998413] x23: 0000000000000000 x22: 0000000000000001
 [  929.006536] x21: 0000000000000000 x20: fffffc00084fb2c4
 [  929.014680] x19: 0000000000000000 x18: 000003ffe27a5d70
 [  929.022848] x17: 0000000000000000 x16: 0000000000000000
 [  929.031030] x15: 0000000000005788 x14: 0e200e200e200e20
 [  929.039231] x13: 0000000000000008 x12: 0000000000000001
 [  929.047449] x11: 00000000ffffffff x10: ffffff00044e39a0
 [  929.055695] x9 : 00000000000009eb x8 : 0000000000000001
 [  929.063972] x7 : 0000000000000000 x6 : fffffc004d50fc58
 [  929.072272] x5 : 0000000000000000 x4 : fffffc00084fb2c4
 [  929.080583] x3 : 0000000000000001 x2 : 00000000ffffffff
 [  929.088915] x1 : ffffffffffffffff x0 : fffffc00095fa000
 [  929.097284] Process ltp_acpi (pid: 27679, stack limit = 0x0000000060c25f0d)
 [  929.107389] Call trace:
 [  929.112989]  acpi_ns_walk_namespace+0x64/0x1cc
 [  929.120648]  acpi_get_devices+0x74/0x90
 [  929.127639]  sys_tcase+0x158/0x618 [ltp_acpi_cmds]
 [  929.135610]  dev_attr_store+0x40/0x54
 [  929.142396]  sysfs_kf_write+0x5c/0x6c
 [  929.149123]  kernfs_fop_write+0xc8/0x1d0
 [  929.156122]  __vfs_write+0x48/0x150
 [  929.162658]  vfs_write+0xa8/0x1a0
 [  929.168994]  SyS_write+0x54/0xb0
 [  929.175234]  __sys_trace_return+0x0/0x4
 [  929.182099] Code: f9433c13 5280003c 52800017 0a1c007a (f9400e76)
 [  929.191352] ---[ end trace ae3e06a2af30d07c ]---
 [  929.199061] Kernel panic - not syncing: Fatal exception
 [  929.207409] SMP: stopping secondary CPUs
 [  929.214374] Kernel Offset: disabled
 [  929.220781] CPU features: 0x100108
 [  929.227004] Memory Limit: none
 [  929.232805] ---[ end Kernel panic - not syncing: Fatal exception

WBR,
Vadim
