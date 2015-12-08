From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 0/9] ACPI / LPSS: fix system hangup on BYT/BSW/CHT
Date: Mon, 7 Dec 2015 20:39:47 -0800
Message-ID: <20151207203947.7c62ce3a@yairi>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1838591.lmJz0NSQxf@vostro.rjw.lan>
	<CAHp75VeJ+Qc4c+n69WXQu3_r5=GZr2MtK02XCm1xtEs==Kiihw@mail.gmail.com>
	<CAJZ5v0gO5BhqMv6QFAjL-PkAT8_kKiQN6XHq41W4tFk74ArCdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54732 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124AbbLHEjt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Dec 2015 23:39:49 -0500
In-Reply-To: <CAJZ5v0gO5BhqMv6QFAjL-PkAT8_kKiQN6XHq41W4tFk74ArCdw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, jacob.jun.pan@linux.intel.com

On Sat, 5 Dec 2015 01:07:47 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> >>> [2] http://www.spinics.net/lists/kernel/msg2119229.html  
> 
> I'm the top-level powercap maintainer, but the RAPL driver is
> maintained by Jacob.  Please ask him for an ACK.

looks good to me. no functional change to the driver.
