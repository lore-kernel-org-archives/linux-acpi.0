From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/2] fix issue when acpi smmuv3 device alloc offline node
 memory
Date: Fri, 15 Mar 2019 10:19:38 +0800
Message-ID: <20190315021940.86905-1-wangkefeng.wang@huawei.com>
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
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

IF acpi smmuv3 device is set to offline node, parsed from proximity domain
in SMMUv3 IORT table, it will lead to crash when alloc memory, so fix it
by using acpi_map_pxm_to_online_node() to find a online node and set it to
smmuv3 device. Meanwhile, show the match info about pxm id, offline node and
online node.

Kefeng Wang (2):
  ACPI/IORT: set online numa node for smmuv3 device
  ACPI: NUMA: show match info about PXM ID and offline/online node

 drivers/acpi/arm64/iort.c | 8 ++++----
 drivers/acpi/numa.c       | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.20.1
