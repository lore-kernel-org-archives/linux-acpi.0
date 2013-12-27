From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v4 3/5] ACPI: HW reduced mode does not allow use of the
 FADT sci_interrupt field
Date: Fri, 27 Dec 2013 04:56:30 +0000
Message-ID: <20131227045630.GA21429@srcf.ucam.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-4-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44954 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab3L0E4g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Dec 2013 23:56:36 -0500
Content-Disposition: inline
In-Reply-To: <1387239401-13918-4-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On Mon, Dec 16, 2013 at 05:16:39PM -0700, al.stone@linaro.org wrote:

> +	if (!acpi_gbl_reduced_hardware) {

I don't really understand this. You've explained that runtime hardware 
reduced mode switching isn't expected to work, but you're making this 
conditional on a runtime flag?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
