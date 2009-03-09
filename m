From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Bugme-new] [Bug 12831] New: Hot/Fn Keys do not work EEEPC 1000HE (eeepc_laptop)
Date: Mon, 9 Mar 2009 20:37:22 +0000
Message-ID: <20090309203722.GA18521@srcf.ucam.org>
References: <bug-12831-10286@http.bugzilla.kernel.org/> <20090309125142.54f707dd.akpm@linux-foundation.org> <94855ae5f6d072e7c9b5920b67fc4c1d@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34297 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbZCIUha (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 16:37:30 -0400
Content-Disposition: inline
In-Reply-To: <94855ae5f6d072e7c9b5920b67fc4c1d@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pyther <pyther@pyther.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, bugme-daemon@bugzilla.kernel.org, patrick.bregman@gmail.com, linux-acpi@vger.kernel.org

Ok. There haven't been any changes in eeepc-laptop that I can see 
causing this, and nothing springs to mind as an obvious cause. I know 
it's a pile of work (especially on an eee), but is there any chance to 
can bisect this to a smaller range of patches?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
