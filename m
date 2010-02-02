From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Acpi4asus-user] ACPI device for ASUS EEEPC 1101HA not added
Date: Tue, 2 Feb 2010 15:12:42 +0000
Message-ID: <20100202151242.GA30214@srcf.ucam.org>
References: <20100201032554.GZ28972@buzzloop.caiaq.de> <cone.1265022400.369355.2380.1000@eeekiste> <alpine.LFD.2.00.1002020048110.12989@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48286 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab0BBPMr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 10:12:47 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002020048110.12989@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: andrej.gelenberg@udo.edu, Daniel Mack <daniel@caiaq.de>, linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

The correct solution is to implement an asus-wmi driver. The interface 
looks pretty much identical to the existing one, it's just indirected 
throguh WMI.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
