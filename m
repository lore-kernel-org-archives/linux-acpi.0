From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v3 1/2] acpi: Add "acpi_osi=" for ASUS X200MA to enable,
 brightness keys
Date: Thu, 18 Dec 2014 14:36:23 +0000
Message-ID: <20141218143623.GA7335@srcf.ucam.org>
References: <5492C5A3.8090700@gmail.com>
 <CA+5PVA43jLUp4K9=56nwgQJEyLB9EkEynb2PqfEhBWD8q-m-DQ@mail.gmail.com>
 <5492D938.1020907@gmail.com>
 <20141218135705.GD4918@srcf.ucam.org>
 <5492DEE7.8010407@gmail.com>
 <20141218140930.GA6436@srcf.ucam.org>
 <5492E32E.2030602@gmail.com>
 <20141218142629.GA6924@srcf.ucam.org>
 <5492E5F9.2000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59436 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaLROg2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2014 09:36:28 -0500
Content-Disposition: inline
In-Reply-To: <5492E5F9.2000504@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>

That's odd - it looks like the default behaviour in the absence of any 
OSI strings is to just default to an OSYS value that matches Windows 
2012, so disabling the 2013 value should be equivalent. If it's not, 
it's definitely not safe to turn off all values - there are several 
devices that change behaviour as a result.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
