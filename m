From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]  ACPI : Add T-state coordination when updating T-state
Date: Thu, 24 Jan 2008 22:09:27 -0500
Message-ID: <200801242209.27275.lenb@kernel.org>
References: <1199954381.3948.10.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43192 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbYAYDJn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jan 2008 22:09:43 -0500
In-Reply-To: <1199954381.3948.10.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Looks like we need to set ACPI_PDC_SMP_T_SWCOORD
in _PDC for this to work.

Also, if you can possibly break the 300-line patch up into
multiple logical steps, that would be ideal.

thanks,
-Len
