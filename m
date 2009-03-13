From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: patch for video.c driver
Date: Fri, 13 Mar 2009 17:47:26 +0000
Message-ID: <20090313174726.GA2888@srcf.ucam.org>
References: <20090312154741.GA1055@hygelac> <1236910092.2807.103.camel@rzhang-dt> <20090313030030.GA23571@srcf.ucam.org> <20090313173604.GB13342@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33651 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZCMRre (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2009 13:47:34 -0400
Content-Disposition: inline
In-Reply-To: <20090313173604.GB13342@hygelac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Mar 13, 2009 at 12:36:04PM -0500, Terence Ripperda wrote:

> in the case I'm trying to fix here, a vendor is using the NVIF ACPI
> extensions, rather than the DGS/DCS methods. not all vendors use these, but for
> the ones that do, there's no other way to get the hotkey information. our fix
> here is to update the video.c driver to acknowledge the NVIF methods and pass
> the methods on to the userspace daemon.

I'm not quite clear on what you mean by the hotkey information here. As 
far as I'm aware, we don't use DCS/DGS support for anything on Linux 
since it often seems to be either broken or just filled with incorrect 
information.

> currently the nvidia X driver handles the control logic and display change
> actions on our boards. this was written a couple of years ago and due to nothing
> else in place at the time. we'd prefer to switch to a more generic mechanism in
> line with what the community is working on. my understanding is that there is
> work on a daemon that relies on X RandR 1.2. I would like nvidia to get involved
> in and support that effort. (and I admit nvidia is behind on getting our X RandR
> support up to 1.2)
> 
> even once that's done, you'd still need the patch (or a similar patch) I'm
> suggesting for this infrastructure to work on NVIF-based platforms. userspace
> logic for parsing the NVIF methods would also be needed; I'm working on getting
> sign-off to release that IP for general linux support.

Yeah, this is the bit I don't understand. The design we've adopted for 
output switching ignores any BIOS provided information, and instead just 
enables outputs based on the user preferences. The X driver then has 
responsibility for performing the actual switch. Nouveau appears to be 
able to handle this on nvidia platforms without any problem. So, really, 
I guess I'm not clear on what functionality NVIF is intended to provide 
here. Is it impossible to enable outputs on some systems without it?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
