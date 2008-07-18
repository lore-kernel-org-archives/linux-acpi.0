From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] ACPI: Provide a spec conform OSI interface to the BIOS
Date: Fri, 18 Jul 2008 09:16:25 +0200
Message-ID: <48804349.607@linux.intel.com>
References: <1216316268-24042-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:26923 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753101AbYGRHQY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jul 2008 03:16:24 -0400
In-Reply-To: <1216316268-24042-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> Introduce acpi_osi=windows_false boot parameter
> Introduce CONFIG_ACPI_OSI_SPEC_CONFORM config option

Why are you adding the CONFIG option? In what circumstances would one 
set it? If anything I think this should be a boot option only for now.

I'm not sure this is the right direction anyways, see earlier comments.

Probably needs more discussion first.

-Andi
