From: Len Brown <lenb@kernel.org>
Subject: Re: no fan detected
Date: Tue, 13 Feb 2007 15:10:56 -0500
Message-ID: <200702131510.56754.lenb@kernel.org>
References: <e30fb88b0702130638g9e26873ned471eceaa309719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41428 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbXBMUMU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 15:12:20 -0500
In-Reply-To: <e30fb88b0702130638g9e26873ned471eceaa309719@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: martin schneebacher <martin.schneebacher@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 13 February 2007 09:38, martin schneebacher wrote:
> hi, list.
> 
> i have a aopen notebook 1559as with a centrino cpu and a nvidia
> graphic card. there are two fans inside (cpu and graphic), but since
> somewhen (i don't remember when exactly, i noticed it with the latest
> kernel) there is no fan detected by the acpi system, and
> /proc/acpi/fan is empty. the syslog lists all acpi devices but the
> fan.

Did /proc/acpi/fan have any contents with any previous version of Linux?
If so, what version and what was there?

-Len

> i'm using debian/sid with
> Linux gusti 2.6.20 #4 Tue Feb 13 14:58:45 CET 2007 i686 GNU/Linux
