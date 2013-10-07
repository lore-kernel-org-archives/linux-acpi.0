From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Mon, 7 Oct 2013 01:32:47 +0100
Message-ID: <20131007003247.GA21999@srcf.ucam.org>
References: <20131006203353.GA19795@srcf.ucam.org>
 <CAMP44s0N5xqD2W7-r-j1k3efo1k0qY2gCeqn+tbHsvOsrqOJgg@mail.gmail.com>
 <20131006204518.GA20077@srcf.ucam.org>
 <CAMP44s0GkVyw+PRYKqq7=MXFFtgUO9xCq6jTsoQV-rSRmC23yg@mail.gmail.com>
 <20131006205928.GA20296@srcf.ucam.org>
 <CAMP44s33CByGsRz7vsNAoOLnbEMY+fz73NzHJq07BzSuCEGJUg@mail.gmail.com>
 <20131006233106.GA21562@srcf.ucam.org>
 <CAMP44s1-vCgOkE_h1ZEmCA2WiQyLTOvnis2MOjdu8kdDB39kFg@mail.gmail.com>
 <20131006235702.GA21738@srcf.ucam.org>
 <CAMP44s3+GdeN6ZFxi6dKZ_1kyTgmgjTf4ET=pJnkSwoirZQMjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57138 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab3JGAcu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2013 20:32:50 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3+GdeN6ZFxi6dKZ_1kyTgmgjTf4ET=pJnkSwoirZQMjw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Oct 06, 2013 at 07:27:48PM -0500, Felipe Contreras wrote:

> If _you_ want to add comments for each entry in the list you can do so
> after this patch is applied.

If you want to participate in a collaborative development effort you 
should pay attention to other people's concerns. I don't get the final 
say in whether or not this patch gets merged, but there's a decent 
chance that I'm going to be the one who has to remove the entries again 
once the backlight mess is fixed up. My life would be significantly 
easier if the entries are unambiguously identified in such a way that I 
can remove them without having to dig through git history to figure out 
where each came from. Is that really an unreasonable request?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
