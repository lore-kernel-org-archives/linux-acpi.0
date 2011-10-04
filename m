From: pingfank@linux.vnet.com
Subject: Enable x86 linux guest with cpu hotplug feature.
Date: Tue,  4 Oct 2011 19:13:35 +0800
Message-ID: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: linux-acpi@vger.kernel.org, qemu-devel@nongnu.org
Cc: aliguori@us.ibm.com, Liu Ping Fan <pingfank@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, ryanh@us.ibm.com, shaohua.li@intel.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

A bunch of patches, which are applied separately for kernel and qemu-kvm,
and make x86 based linux guest with cpu hotplug feature.

For kernel:
0001-ACPI-Call-ACPI-remove-handler-when-handling-ACPI-eje.patch
--call acpi eject event handler in acpi_bus_notify()

For qemu-kvm:
0001-ACPI-Update-cpu-hotplug-event-for-guest.patch
--trigger acpi cpu hotplug event for guest, so qemu-kvm can bring present cpu
  to online state
0002-LAPIC-make-lapic-support-cpu-hotplug.patch
--make qemu-kvm support to bring possible cpu to present state.

After applying these patches, we can bring possible cpu online 
by the following step.
1.Boot up qemu-kvm with the param "-smp 1,maxcpu=4", 
2.Use "cpu_set 2 online" cmd in qemu monitor to bring possible cpu 
  to present state. 
3.In guest,echo 1 > cpu2/online to bring the present cpu to online 
  state.
