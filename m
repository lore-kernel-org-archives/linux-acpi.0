From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
Date: Tue, 12 Jan 2016 19:32:28 +0100
Message-ID: <20160112183228.GK30558@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
 <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
 <20160112143653.GB30558@pd.tnic>
 <CAGDN=za9Pjm0B0OMJevgesBdkm=XOGyU7jXXfWqk+dLSo7BVtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39942 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbcALScm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jan 2016 13:32:42 -0500
Content-Disposition: inline
In-Reply-To: <CAGDN=za9Pjm0B0OMJevgesBdkm=XOGyU7jXXfWqk+dLSo7BVtQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tuan Phan <tphan@apm.com>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, mchehab@osg.samsung.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, patches@apm.com, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jan 12, 2016 at 10:26:04AM -0800, Tuan Phan wrote:
> So are you good with it?

How about this instead:

---
diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index fa4585a6914e..e42f6b7eac13 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -46,17 +46,22 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
  * Returns: linux IRQ number on success (>0)
  *          -EINVAL on failure
  */
-int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
+int acpi_gsi_to_irq(u32 gsi)
 {
+	unsigned int irq;
+
 	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
 							DOMAIN_BUS_ANY);
 
-	*irq = irq_find_mapping(d, gsi);
+	irq = irq_find_mapping(d, gsi);
 	/*
 	 * *irq == 0 means no mapping, that should
 	 * be reported as a failure
 	 */
-	return (*irq > 0) ? *irq : -EINVAL;
+	if (irq > 0)
+		return irq;
+	else
+		return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
