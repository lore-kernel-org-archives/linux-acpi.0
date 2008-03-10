From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: acer-wmi uses input:i8042_command() => build error
Date: Mon, 10 Mar 2008 19:59:06 +0000
Message-ID: <200803101959.06441.carlos@strangeworlds.co.uk>
References: <20080310124754.4ec3f24d.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:33702 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbYCJT7S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2008 15:59:18 -0400
In-Reply-To: <20080310124754.4ec3f24d.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Monday 10 March 2008 19:47:54 Randy Dunlap wrote:
> drivers/built-in.o: In function `set_u32':
> acer-wmi.c:(.text+0xb9bf6): undefined reference to `i8042_command'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2

It appears acer-wmi also depends on CONFIG_SERIO_I8042 for that function (I 
don't have CONFIG_EMBEDDED set so didn't notice that it could be disabled on 
x86).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
