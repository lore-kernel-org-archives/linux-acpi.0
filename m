From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 07/13] gma500: psb_irq_turn_off_dpst() fix bit operation
Date: Wed, 02 May 2012 19:14:12 +0100
Message-ID: <20120502181412.26650.5074.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56291 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab2EBSOz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:14:55 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/psb_irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index 4ffb2a0..8652cdf 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -426,7 +426,7 @@ void psb_irq_turn_off_dpst(struct drm_device *dev)
 		psb_disable_pipestat(dev_priv, 0, PIPE_DPST_EVENT_ENABLE);
 
 		pwm_reg = PSB_RVDC32(PWM_CONTROL_LOGIC);
-		PSB_WVDC32(pwm_reg & !(PWM_PHASEIN_INT_ENABLE),
+		PSB_WVDC32(pwm_reg & ~PWM_PHASEIN_INT_ENABLE,
 							PWM_CONTROL_LOGIC);
 		pwm_reg = PSB_RVDC32(PWM_CONTROL_LOGIC);
 

