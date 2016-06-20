From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V8 0/9] vfio, platform: add ACPI support
Date: Mon, 20 Jun 2016 11:51:10 -0400
Message-ID: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, agross@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

The current code only supports the device tree based platforms.
The code checks for the presence of a reset driver and calls the reset
function pointer by looking up the reset driver as a module.

ACPI defines _RST method to perform device level reset. After the _RST
method is executed, the OS can resume using the device.

The patchset is moving the device tree specific pieces out of the code
to common functions so that ACPI support is added without impacting the
rest of the code.

During probe, the ACPI HID of the object will be saved and will be used to
determine if this is an ACPI capable platform or not. If acpihid is NULL
then, device tree functions are called.

In addition to plumbing ACPI support, reset functionality is now a
requirement by default.

The code was allowing platform devices to be used without a supporting
VFIO reset driver. The hardware can be left in some inconsistent state
after a guest machine abort.

The reset driver will put the hardware back to safe state and disable
interrupts before returning the control back to the host machine.

Adding a new reset_required kernel module option to AMBA and platform
VFIO drivers with a default value of true.

New requirements are:
1. A reset function needs to be implemented by the corresponding driver
via DT/ACPI.
2. The reset function needs to be discovered via DT/ACPI.

The probe of the driver will fail if any of the above conditions are
not satisfied.

Changes from V7:
1. Move the reset function test before IOMMU group set up so that we can
clean up properly when reset function is not found.
2. Correct the _RST function call. _RST method does not return any value.
We were calling acpi_evaluate_integer. The correct API needs to be
acpi_evaluate_object.

Sinan Kaya (9):
  vfio: platform: rename reset function
  vfio: platform: move reset call to a common function
  vfio: platform: determine reset capability
  vfio: platform: add support for ACPI probe
  vfio: platform: add extra debug info argument to call reset
  vfio: platform: call _RST method when using ACPI
  vfio, platform: make reset driver a requirement by default
  vfio: platform: check reset call return code during open
  vfio: platform: check reset call return code during release

 drivers/vfio/platform/vfio_amba.c             |   5 +
 drivers/vfio/platform/vfio_platform.c         |   5 +
 drivers/vfio/platform/vfio_platform_common.c  | 197 +++++++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |   8 +-
 4 files changed, 177 insertions(+), 38 deletions(-)

-- 
1.8.2.1
