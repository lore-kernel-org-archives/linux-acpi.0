From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [RFC, PATCH] acer-wmi: Add driver for newer Acer laptops
Date: Wed, 5 Dec 2007 02:12:31 +0000
Message-ID: <200712050212.32540.carlos@strangeworlds.co.uk>
References: <200712041447.28077.carlos@strangeworlds.co.uk> <20071205015749.GA8692@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:35340 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbXLECNx (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 4 Dec 2007 21:13:53 -0500
In-Reply-To: <20071205015749.GA8692@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux-acpi@vger.kernel.org

On Wednesday 05 December 2007 01:57:49 Matthew Garrett wrote:
> On Tue, Dec 04, 2007 at 02:47:27PM +0000, Carlos Corbacho wrote:
> > +#define AMW0_GUID1		"67C3371D-95A3-4C37-BB61-DD47B491DAAB"
> > +#define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
>
> It would be nice to export these, so wmi-based drivers could be
> autoloaded.

Something like modules.wmimap? Or do you mean something else?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
