From: Yu Luming <luming.yu@intel.com>
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Date: Mon, 3 Jul 2006 09:51:29 +0800
Message-ID: <200607030951.29345.luming.yu@intel.com>
References: <17576.14005.767262.868190@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60511 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750885AbWGCBq2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Jul 2006 21:46:28 -0400
In-Reply-To: <17576.14005.767262.868190@phoenix.squirrel.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 03 July 2006 05:12, Johan Vromans wrote:
> From: Johan Vromans <jvromans@squirrel.nl>
>
> To get battery readings on some laptops it is necessary to interface
> with the SMBus that hangs of the EC. However, the current
> implementation of the EC driver does not permit other modules
> read/write access.

why NOT use ec_read/ec_write?

-- 
Thanks,
Luming
