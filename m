From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9533] New: 2.6.24-rc4: some ahci/acpi
 interaction causes delays during boot
Date: Mon, 10 Dec 2007 12:52:43 -0800
Message-ID: <20071210125243.df6b441e.akpm@linux-foundation.org>
References: <bug-9533-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40498 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754136AbXLJUxT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Dec 2007 15:53:19 -0500
In-Reply-To: <bug-9533-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 10 Dec 2007 05:55:20 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9533

Another box-killing regression to track, please.  Either ATA or ACPI.
