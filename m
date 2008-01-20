From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sun, 20 Jan 2008 13:03:18 +0100
Message-ID: <47933886.7050401@dbservice.com>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu> <200801192313.10296.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:38056 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752549AbYATMNZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 07:13:25 -0500
In-Reply-To: <200801192313.10296.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

Len Brown wrote:
>    I am okay with defining OSI strings for the benefit of BIOS vendors that
>    need to know about Linux capabilities.  But the string must
>    identify that specific capability (or lack of a capability).

Is there a chance this will be added to future ACPI specs, or have it 
standardized in one way or another? I think that would be not only good 
for Linux, but all other UNIX-like operating systems as well (and maybe 
Windows as well).

Not that I care, really, but for me as an outsider to the whole ACPI 
domain, it seems _OSI() isn't a well thought out interface. Checking for 
an OS name rather than individual capabilities may not matter as much 
under Windows, but for Linux, with its rather short release cycle, it 
certainly does.

tom
