From: James Morse <james.morse@arm.com>
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
Date: Thu, 28 Jun 2018 11:06:54 +0100
Message-ID: <20180628100656.10692-1-james.morse@arm.com>
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
To: linux-acpi@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoff Levand <geoff@infradead.org>, Riku Voipio <riku.voipio@linaro.org>, Mark Salter <msalter@redhat.com>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

There are reports[0] that HPE's 'ProLiant m400 Server' (aka moonshot) has
broken RAS support, and adding disable_hest to the kernel cmdline is the
only way to make the board boot if APEI support is built into the kernel.

After Mark Salter's investigation[1] we know that UEFI's ExitBootServices
is doing something that causes a fatal error to be written to GHES.2.
Once the kernel finds this, it falsely assume it was due to something that
happened during boot, and panic()s.

This series adds a DMI quirks table to hest.c, and adds a helper that lets
us query the UEFI system table version, to set hest_disabled on this
platform.

Testing the HEST table vendor and revision is a problem as this would
match all 'HPE ProLiant', some of which may be a totally different CPU
architecture.


I don't have access to an m400, these DMI and UEFI values were taken from
the crashlog report at [0], then tested with the equivalent fields on
Seattle.


Thanks,

James

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1574718
[1] https://www.spinics.net/lists/arm-kernel/msg660956.html

James Morse (2):
  efi: Add helper to retrieve runtime version number
  ACPI / APEI: Add DMI matching quirks for platforms that require
    hest_disable

 drivers/acpi/apei/hest.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/efi.h      |  5 +++++
 2 files changed, 43 insertions(+)

-- 
2.17.1
