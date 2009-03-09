From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Bugme-new] [Bug 12831] New: Hot/Fn Keys do not work EEEPC 1000HE (eeepc_laptop)
Date: Mon, 9 Mar 2009 20:04:13 +0000
Message-ID: <20090309200413.GA18124@srcf.ucam.org>
References: <bug-12831-10286@http.bugzilla.kernel.org/> <20090309125142.54f707dd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49451 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZCIUEX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 16:04:23 -0400
Content-Disposition: inline
In-Reply-To: <20090309125142.54f707dd.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Corentin Chary <corentincj@iksaif.net>, bugme-daemon@bugzilla.kernel.org, pyther@pyther.net, patrick.bregman@gmail.com, linux-acpi@vger.kernel.org

Can you try disabling pciehp? eeepc-laptop provides the same 
functionality. If that works, I have a patch here somewhere...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
