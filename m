From: Len Brown <lenb@kernel.org>
Subject: sysfs regression on Supermicro X7DB8+ (was Re: ACPICA 20061109 regression on Supermicro X7DB8+)
Date: Fri, 15 Dec 2006 23:38:57 -0500
Message-ID: <200612152338.57315.lenb@kernel.org>
References: <200612151436.27426.lenb@kernel.org> <200612151925.48887.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33085 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255AbWLPEjc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 23:39:32 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id kBG4d37d028833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 16 Dec 2006 04:39:29 GMT
In-Reply-To: <200612151925.48887.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


> Neither 2.6.19.1 nor 2.6.19+ACPICA 20061109 show this exception
> So either it is transient, or it comes in some later 2.6.20-related patch.
> (and the SCSI, hanging off a PCIX AIC79XXX works fine)

The failure is caused by the sysfs branch, which I'll have to drop from the acpi-test tree.

