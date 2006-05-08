From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 6519] New: Athlon XP runs hot: s2k disconnect
 power saving inoperative
Date: Mon, 8 May 2006 14:41:09 -0700
Message-ID: <20060508144109.152e45af.akpm@osdl.org>
References: <200605082027.k48KRtq5031357@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:5041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751119AbWEHVia (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2006 17:38:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k48LcTtH001840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 8 May 2006 14:38:29 -0700
Received: from akpm.pao.digeo.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k48LcSs4022343
	for <linux-acpi@vger.kernel.org>; Mon, 8 May 2006 14:38:28 -0700
In-Reply-To: <200605082027.k48KRtq5031357@fire-2.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

bugme-daemon@bugzilla.kernel.org wrote:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=6519
> 

Guys, there's some mystification as to what subsystem could have caused
this person's CPU Disconnect Control to break.  Andi thinks perhaps ACPI.

Can someone please confirm that and if so, assign the report?

Thanks.
