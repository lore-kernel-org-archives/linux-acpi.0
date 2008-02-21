From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 10:00:26 +0800
Message-ID: <b6a2187b0802201800n12f90b22x8cb0c2ad6e0c402@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802201337.52247.jesse.barnes@intel.com>
	<b6a2187b0802201635t2acb31f2n366f8ef81f119034@mail.gmail.com>
	<200802201639.02502.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802201639.02502.jesse.barnes@intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 21, 2008 at 8:39 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> On Wednesday, February 20, 2008 4:35 pm Jeff Chua wrote:
>  > On Thu, Feb 21, 2008 at 5:37 AM, Jesse Barnes <jesse.barnes@intel.com>
>  wrote:
>  > >  Ok, can you give this patch a try with the 'platform' method?  It should
>  > > at least tell us what ACPI would like the device to do at suspend time,
>  > > but it probably won't fix the hang.

It says "calling pci_set_power_state with 3". Then after all then it
still hangs, and then resume with Mr Green.

PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Shrinking memory...  ^H-^Hdone (0 pages freed)
PM: Freed 0 kbytes in 0.20 seconds (0.00 MB/s)
ACPI: Preparing to enter system sleep state S4
Suspending console(s)
sd 0:0:0:0: [sda] Synchronizing SCSI cache
drm_sysfs_suspend
ACPI: PCI interrupt for device 0000:00:02.0 disabled
calling pci_set_power_state with 3
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Disabling non-boot CPUs ...
PM: Creating hibernation image:
PM: Need to copy 25136 pages
tick-braodcast: ignoring broadcast for offline CPU #1
PM: Writing back config space on device 0000:00:02.0 at offset 1 (was
900007, writing 900003)
ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1b.0 to 64
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1c.1 to 64
...


Thanks,
Jeff.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
