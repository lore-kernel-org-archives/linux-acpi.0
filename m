From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Auto load of coretemp and pkgtemp
Date: Tue, 25 Jan 2011 22:51:13 -0200
Message-ID: <20110126005112.GD25953@khazad-dum.debian.net>
References: <4D3DBCC9.7000804@cfl.rr.com>
 <4D3F6EA8.4030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58626 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752733Ab1AZAvQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 19:51:16 -0500
Content-Disposition: inline
In-Reply-To: <4D3F6EA8.4030503@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-acpi@vger.kernel.org

On Tue, 25 Jan 2011, Robert Hancock wrote:
> but coretemp support is based on CPUID and I don't think there's a
> way to construct a modalias for that.

Because we never had much reason to, in the past.

You can always extend the kernel to actually generate a modalias in the
CPU devices in sysfs with the cpuid, and add the relevant patterns to
drivers like coretemp.  If you do, make it extensible like the ones used
for the BIOS DMI information, so that we can add any relevant future
feature bits.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
