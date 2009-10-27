From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: EC driver registration (was: IPMI/ACPI: Locate the IPMI system interface
 in ACPI namespace)
Date: Tue, 27 Oct 2009 21:02:01 +0300
Message-ID: <4AE73599.5050109@gmail.com>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com> <1256605375.3563.182.camel@localhost.localdomain> <200910270938.42527.bjorn.helgaas@hp.com> <200910271105.10056.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:19671 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbZJ0SB5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 14:01:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1583394fga.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2009 11:02:02 -0700 (PDT)
In-Reply-To: <200910271105.10056.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Bjorn,

Currently EC driver work by doing either ECDT parse or acpi_walk_namespace,
Do you think it will be appropriate to change it to use PNP layer?

Thanks in advance,
Alex.

