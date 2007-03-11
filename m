From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_serialize lock kernel 2.6.21-rc3
Date: Sat, 10 Mar 2007 22:26:02 -0500
Message-ID: <200703102226.02991.lenb@kernel.org>
References: <beb91d720703101142q7e82cf8dt392eb932d12b1813@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59224 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932809AbXCKD1X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Mar 2007 22:27:23 -0500
In-Reply-To: <beb91d720703101142q7e82cf8dt392eb932d12b1813@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Salatiel Filho <salatiel.filho@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 10 March 2007 14:42, Salatiel Filho wrote:
> Is anyone having problems with acpi_serialize in kernel 2.6.21-rc3 ?
> Kernel locks during boot when i use acpi_serialize, and i need it to
> acpi function properly on my laptop. It worked fine in 2.6.20.
> 
> Any help ?

Why were you using acpi_serialize in the first place.
There is a serious bug if you need it -- which is obscured
by the fact that you're using it...

-Len

