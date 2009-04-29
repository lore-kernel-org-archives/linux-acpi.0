From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Wed, 29 Apr 2009 22:29:24 +0100
Message-ID: <20090429212924.GA7900@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com> <20090429165729.GB32619@srcf.ucam.org> <49F89981.10806@dell.com> <20090429183154.GC2325@srcf.ucam.org> <49F8C59F.2010603@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38808 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761275AbZD2V3b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 17:29:31 -0400
Content-Disposition: inline
In-Reply-To: <49F8C59F.2010603@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 29, 2009 at 04:24:47PM -0500, Mario Limonciello wrote:

> I've obtained one of these and taken a look at it with a copy of Win 7
> and compared with dell-wmi and my patchset applied.  This platform's WMI
> support was introduced before Win7's WMI spec was drafted, and so it
> doesn't adhere to the spec.  I think the best thing to do will be create
> a DMI table to match for keys that are only on a per system basis for
> anything before this spec was ready.  I don't expect many other
> platforms like this, but it will allow for additional granularity in
> case something in the future ever deviates spec as well.

Ok. Is there any programmatic way to determine whether a given Dell 
complies with your WMI spec or not? I'd prefer not to use DMI tables 
unless it's the only way to identify the machines - the risk is that 
there'll be something else that also uses its own codes and will just 
behave oddly until someone figures out why it's broken.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
