From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCIe AER: honor ACPI HEST FIRMWARE FIRST mode
Date: Wed, 4 Nov 2009 13:07:49 -0800
Message-ID: <20091104130749.0686210d@jbarnes-piketon>
References: <20091006173311.GA15751@auslistsprd01.us.dell.com>
	<4ACEE220.1020705@jp.fujitsu.com>
	<20091009182810.GB24889@mock.linuxdev.us.dell.com>
	<20091009183319.GC24889@mock.linuxdev.us.dell.com>
	<4AEA4C82.6010604@jp.fujitsu.com>
	<20091030025313.GA1042@mock.linuxdev.us.dell.com>
	<4AEA5C52.2030900@jp.fujitsu.com>
	<20091102175123.GA4028@mock.linuxdev.us.dell.com>
	<20091104091106.32489ad7@jbarnes-piketon>
	<86802c440911041255i59024efckf496dfa966da8560@mail.gmail.com>
	<20091104130515.6ffb0e2b@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-21.bluehost.com ([69.89.21.16]:60589 "HELO
	outbound-mail-21.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932558AbZKDVHq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2009 16:07:46 -0500
In-Reply-To: <20091104130515.6ffb0e2b@jbarnes-piketon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Tom Long Nguyen <tom.l.nguyen@intel.com>, Zhang Yanmin <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Huong_Nguyen@dell.com

On Wed, 4 Nov 2009 13:05:15 -0800
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> > can not find acpi_hest.c and acpi_hest.h
> > 
> > maybe need to wait acpi hest code is there?
> 
> Arg, when I fixed up a conflict in the patch I forgot to add those
> files to the commit.  They were in my tree so I didn't see a build
> error... Fixing now.

Should be all fixed now, thanks for catching it Yinghai.

-- 
Jesse Barnes, Intel Open Source Technology Center
