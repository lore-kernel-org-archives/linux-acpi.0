From: Dave Jones <davej@redhat.com>
Subject: Re: Could the k8temp driver be interfering with ACPI?
Date: Mon, 2 Apr 2007 15:22:09 -0400
Message-ID: <20070402192209.GB15810@redhat.com>
References: <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302135810.GF2156@elf.ucw.cz> <20070302220052.f93f3976.khali@linux-fr.org> <20070401153951.GE5095@ucw.cz> <20070402174859.80b74b05.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33432 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965673AbXDBTYu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Apr 2007 15:24:50 -0400
Content-Disposition: inline
In-Reply-To: <20070402174859.80b74b05.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Mon, Apr 02, 2007 at 05:48:59PM +0200, Jean Delvare wrote:
 > +	u8  val;
 > +#ifdef CONFIG_ACPI
 > +	acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
 > +#endif
 >  	outb(reg, data->addr + ADDR_REG_OFFSET);
 > -	return inb(data->addr + DATA_REG_OFFSET);
 > +	val = inb(data->addr + DATA_REG_OFFSET);
 > +#ifdef CONFIG_ACPI
 > +	acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 > +#endif
 > +	return val;
 > ... deletia, more of the same.

it'd probably end up a lot cleaner to #define them to empty macros
in the !ACPI case in acpi/acpi.h and just #include it unconditionally.

	Dave

-- 
http://www.codemonkey.org.uk
