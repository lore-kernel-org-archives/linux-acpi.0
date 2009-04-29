From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Wed, 29 Apr 2009 21:30:08 +0100
Message-ID: <20090429203008.GB2944@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com> <20090429165729.GB32619@srcf.ucam.org> <49F89981.10806@dell.com> <20090429183154.GC2325@srcf.ucam.org> <36672.1241033029@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37880 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZD2UaN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 16:30:13 -0400
Content-Disposition: inline
In-Reply-To: <36672.1241033029@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Mario Limonciello <mario_limonciello@dell.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 29, 2009 at 03:23:49PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 29 Apr 2009 19:31:54 BST, Matthew Garrett said:
> > It's a precision M6300 - I'm afraid I'm not sure what BIOS it's running.
> 
> This works on Latitudes and Optiplexes, should be good for Precision as well:
> 
> # dmidecode | grep -C 5 'BIOS Info'
> 
> should get you (somewhere) this:
> 
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>         Vendor: Dell Inc.
>         Version: A09
>         Release Date: 06/04/2008
> 

Yeah, the issue is that the battery is flat and I can't find the PSU :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
