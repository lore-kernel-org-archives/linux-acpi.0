From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH]  ACPI:  Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Mon, 28 Jul 2008 16:59:26 +0200
Message-ID: <20080728145926.GG28253@one.firstfloor.org>
References: <1217215550.4016.6.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:38318 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYG1O7k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jul 2008 10:59:40 -0400
Content-Disposition: inline
In-Reply-To: <1217215550.4016.6.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: AndiKleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, Jul 28, 2008 at 11:25:50AM +0800, Zhao Yakui wrote:
> Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC 
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> On some broken BIOS the ACPI object in EC _REG method can't be found in
> ACPI namespace, which causes that the AE_NOT_FOUND status code is returned by
> the EC _REG object. In such case the EC device can't be initialized correctly, 

Thanks. Queued for test. How urgent is this? Do we need to consider it 
for .27?

-Andi
