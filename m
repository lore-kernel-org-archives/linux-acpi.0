From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Tue, 28 Apr 2009 13:24:12 -0700
Message-ID: <20090428202409.GU7917@plum>
References: <20090415225348.GW8311@plum> <20090416002712.GX8311@plum> <200904161201.13409.trenn@suse.de> <20090416174217.GY8311@plum> <20090416224507.GA31984@srcf.ucam.org> <20090428193303.GC6968@plum> <20090428195348.GA8376@srcf.ucam.org>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:51898 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZD1UYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2009 16:24:15 -0400
Content-Disposition: inline
In-Reply-To: <20090428195348.GA8376@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Apr 28, 2009 at 08:53:48PM +0100, Matthew Garrett wrote:
> On Tue, Apr 28, 2009 at 12:33:04PM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 16, 2009 at 11:45:07PM +0100, Matthew Garrett wrote:
> > 
> > > That's not really an option. It works with Windows.
> > 
> > Who verified that?  Does anyone know what strategy Windows uses to avoid this
> > T60 problem?  
> 
> The best guess was that Windows only evaluates _PPC when it receives a 
> notification.

I have asked the Windows side of the UEFI development team here about what
they've observed about Windows' behavior regarding reading _PPC at boot and
will post their answers when I receive them.

--D
