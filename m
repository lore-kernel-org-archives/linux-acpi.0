From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Wed, 12 Aug 2009 23:46:33 +0200
Message-ID: <200908122346.33626.rjw@sisk.pl>
References: <20090812201034.GA2983@localdomain.by>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60101 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbZHLVpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Aug 2009 17:45:46 -0400
In-Reply-To: <20090812201034.GA2983@localdomain.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 12 August 2009, Sergey Senozhatsky wrote:
> Hello,
> 
> Kernel oopses on early boot stages (boots normally with boot_delay=10).
> 
> rc5-git8
> eip: acpi_ex_system_memory_space_handler+0x75/0x22f

Do I assume correctly that it didn't happen before?

Rafael
